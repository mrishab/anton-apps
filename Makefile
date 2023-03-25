TARGET:=./dist
HOST_APP_DIR:=/var/server/anton

APPS:=airflow codeserver deluge duplicati freshrss jenkins jupyter lazylibrarian mediaserver nextcloud nexus nzbget ombi openvpn pgadmin plex prowlarr registry sonarqube tautulli wikijs

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

clean: stop remove

restart: stop start

reset: clean start

setup: pack upload deploy
