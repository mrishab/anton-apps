.PHONY: start stop config logs reset restart

start:
	docker-compose -f docker-compose.yml up -d

stop:
	docker-compose -f docker-compose.yml down

config:
	docker-compose -f docker-compose.yml config

remove:
	docker-compose -f docker-compose.yml rm

logs:
	docker-compose logs

reset: stop remove start

restart: stop start
