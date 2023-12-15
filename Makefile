include .env

prony: build clear test

build :
	docker-compose -p nulllab build

sync :
	rm -rf ./_cloud/cdk.out
	docker compose run  aws cdk synth

clear :
	docker-compose down --rmi all -v --remove-orphans

test :
		cd _cloud && \
		cdk synth && \
		cdk deploy
