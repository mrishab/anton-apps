TARGET:=./dist
HOST_APP_DIR:=/var/server/anton

APPS:=affine airflow calibre codeserver deluge dockovpn duplicati freshrss ghost immich jenkins jupyter lazylibrarian mediaserver nextcloud nexus nzbget ollama ombi open-webui pgadmin plex postiz prowlarr registry sftpgo sonarqube tautulli wikijs

start:
	for app in $(APPS) ; do \
		cd $$app ; docker-compose up -d ; cd .. ; \
	done

stop:
	for app in $(APPS) ; do \
		cd ./$$app ; docker-compose down ; cd .. ; \
	done

remove:
	for app in $(APPS) ; do \
		cd ./$$app ; docker-compose rm ; cd .. ; \
	done

logs:
	for app in $(APPS) ; do \
		cd ./$$app ; docker-compose logs ; cd .. ; \
	done

pack:
	rm -r $(TARGET) ; true
	mkdir -p $(TARGET)
	rsync Makefile $(TARGET)
	for app in $(APPS) ; do \
		rsync -r --exclude template.env ./$$app $(TARGET) ; \
	done

deploy:
	# Asserting that .env file is present.
	ssh $(USERNAME)@$(HOST) "cd $(HOST_APP_DIR) && make restart APPS='$(APPS)'"

upload:
	ssh $(USERNAME)@$(HOST) "mkdir -p ${HOST_APP_DIR}"
	rsync --progress -avz $(TARGET)/ $(USERNAME)@$(HOST):$(HOST_APP_DIR)

check-nvidia:
	nvidia-smi

clean: stop remove

restart: stop start

reset: clean start

setup: pack upload deploy

