prony: build clear cdk

build :
	docker-compose -p nulllab up

cdk :
	docker-compose run --rm aws_cdk_toolkit

clear :
	docker-compose down --rmi all -v --remove-orphans