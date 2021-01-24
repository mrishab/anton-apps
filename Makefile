.PHONY: start stop config remove logs pack deploy upload clean deploy restart setup start_all stop_all config_all remove_all logs_all pack_all deploy_all upload_all clean_all deploy_all restart_all setup_all

APP := .
TARGET := ./dist
HOST_APP_DIR := /var/server/anton

# App Stages

start:
	cd ./${APP} && docker-compose up -d

stop:
	cd ./${APP} && docker-compose down

config:
	cd ./${APP} && docker-compose config

remove:
	cd ./${APP} && docker-compose rm

logs:
	cd ./${APP} && docker-compose logs

pack:
	rsync -r --exclude template.env ./${APP} ${TARGET}

deploy:
	ssh ${USERNAME}@${HOST} "cd ${HOST_APP_DIR} && make restart APP=${APP}"

upload:
	ssh ${USERNAME}@${HOST} "mkdir -p ${HOST_APP_DIR}/${APP}"
	rsync -a ${TARGET}/${APP}/ ${USERNAME}@${HOST}:${HOST_APP_DIR}/${APP}/

restart: stop start

clean: stop remove

reset: clean start

setup: pack upload deploy

# Project Stages

start_all:
	make start APP=jenkins
	make start APP=nextcloud
	make start APP=nexus
	make start APP=pgadmin
	make start APP=plex
	make start APP=registry

stop_all:
	make stop APP=jenkins
	make stop APP=nextcloud
	make stop APP=nexus
	make stop APP=pgadmin
	make stop APP=plex
	make stop APP=registry

restart_all:
	make restart APP=jenkins
	make restart APP=nextcloud
	make restart APP=nexus
	make restart APP=pgadmin
	make restart APP=plex
	make restart APP=registry

clean_all:
	make clean APP=jenkins
	make clean APP=nextcloud
	make clean APP=nexus
	make clean APP=pgadmin
	make clean APP=plex
	make clean APP=registry

pack_all:
	rm -r ${TARGET} ; true
	mkdir -p ${TARGET}
	rsync Makefile ${TARGET}
	make pack APP=jenkins
	make pack APP=nextcloud
	make pack APP=nexus
	make pack APP=pgadmin
	make pack APP=plex
	make pack APP=registry

deploy_all:
	ssh ${USERNAME}@${HOST} "cd ${HOST_APP_DIR} && make restart_all"

upload_all:
	ssh ${USERNAME}@${HOST} "mkdir -p ${HOST_APP_DIR}"
	rsync -a ${TARGET}/ ${USERNAME}@${HOST}:${HOST_APP_DIR}

setup: pack_all upload_all deploy_all
