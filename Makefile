prony: build clear

build :
	docker-compose -p nulllab build

clear :
	docker-compose down --rmi all -v --remove-orphans