.PHONY: cloud build clean sync watch

CURRENT_DIR := $(PWD)
SCSSLEON_DIR := ~/Developer/my/scssleon
CLOUDFRONT_ID := $(shell docker container run -it --rm -v ~/.aws:/root/.aws -v ${CURRENT_DIR}/cloud:/tf --workdir /tf hashicorp/terraform:latest output -raw cloudfront_id)

cloud:
	@echo "[Applying TerraForm]"
	docker container run -it --rm -v ~/.aws:/root/.aws -v ${CURRENT_DIR}/cloud:/tf --workdir /tf hashicorp/terraform:latest init
	docker container run -it --rm -v ~/.aws:/root/.aws -v ${CURRENT_DIR}/cloud:/tf --workdir /tf hashicorp/terraform:latest plan
	docker container run -it --rm -v ~/.aws:/root/.aws -v ${CURRENT_DIR}/cloud:/tf --workdir /tf hashicorp/terraform:latest apply

build:
	@echo "[Building Docker image]"
	docker build -t nulllab . -f ${CURRENT_DIR}/.config/docker/watch.Dockerfile

watch:
	@echo "[Running Docker nulllab container]"
	docker run --rm -it -v ${CURRENT_DIR}/backend:/app nulllab npm i
	docker run --rm -it \
    		-v ${CURRENT_DIR}/backend:/app \
    		-v ${SCSSLEON_DIR}/scss:/app/src/styles/scss \
    		-p 4321:4321 nulllab npm run dev

sync :
	docker run --rm -it \
    		-v ${CURRENT_DIR}/backend:/app \
    		-v ${CURRENT_DIR}/frontend:/app/dist \
    		-v ${SCSSLEON_DIR}/scss:/app/src/styles/scss \
    		nulllab npm run build
	docker run --rm -it -v ~/.aws:/root/.aws public.ecr.aws/aws-cli/aws-cli:latest s3 rm s3://nulllab.net --recursive
	docker run --rm -it -v ~/.aws:/root/.aws -v ${CURRENT_DIR}/frontend:/dist public.ecr.aws/aws-cli/aws-cli:latest s3 cp /dist s3://nulllab.net --recursive
	docker run --rm -it -v ~/.aws:/root/.aws public.ecr.aws/aws-cli/aws-cli:latest cloudfront create-invalidation --distribution-id ${CLOUDFRONT_ID} --paths '/*'

clean :
	docker compose down --rmi all -v --remove-orphans