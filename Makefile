prony: build clean cloud sync watch

# aws configure export-credentials --profile aws-dev --format env-no-export > .env.docker
# go mod tidy

CURRENT_DIR := $(PWD)
SCSSLEON_DIR := ~/Developer/my/scssleon

cloud:
	docker container run -it --rm -v $PWD/cloud:/tf --workdir /tf hashicorp/terraform:latest 

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
	npm run build --prefix=./backend/
	aws s3 rm s3://nulllab.net --recursive
	aws s3 cp frontend/ s3://nulllab.net --recursive
	aws cloudfront create-invalidation --distribution-id E3ONXJXS0O5775 --paths '/*'

clean :
	docker compose down --rmi all -v --remove-orphans