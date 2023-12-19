prony: build clear test cloud


# aws configure export-credentials --profile aws-dev --format env-no-export > .env.docker
# go mod tidy

cloud:
	docker container run -it --rm -v $PWD/cloud:/tf --workdir /tf hashicorp/terraform:latest 

build :
	docker-compose -p nulllab build

synth :
	rm -rf ./_cloud/cdk.out
	docker compose run  aws cdk synth

clear :
	docker-compose down --rmi all -v --remove-orphans

test :
		cd _cloud && \
		cdk synth && \
		cdk deploy
