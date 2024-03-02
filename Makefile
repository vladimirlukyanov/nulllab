prony: build clear cloud sync watch


# aws configure export-credentials --profile aws-dev --format env-no-export > .env.docker
# go mod tidy

cloud:
	docker container run -it --rm -v $PWD/cloud:/tf --workdir /tf hashicorp/terraform:latest 

watch:
	docker-compose

build :
	docker-compose up -d
#	ASTRO_TELEMETRY_DISABLED=1 npm run build --prefix="./backend/" -- --verbose

sync :
	npm run build --prefix=./backend/
	aws s3 rm s3://nulllab.net --recursive
	aws s3 cp frontend/ s3://nulllab.net --recursive
	aws cloudfront create-invalidation --distribution-id E3ONXJXS0O5775 --paths '/*'

clear :
	docker-compose down --rmi all -v --remove-orphans
