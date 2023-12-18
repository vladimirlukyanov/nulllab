prony: build clear test


# aws configure export-credentials --profile aws-dev --format env-no-export > .env.docker
# go mod tidy

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
