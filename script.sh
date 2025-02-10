export HOST_DIR=/mnt/external_hdd
export HOST_USER=mrishab

# Configure Jenkins folder Permissions
mkdir -p $HOST_DIR/jenkins/
rm -rf $HOST_DIR/jenkins/*
chown -R $HOST_USER:$HOST_USER $HOST_DIR/jenkins/

# Configure PGAdmin folder permissions
mkdir -p $HOST_DIR/pgadmin/
rm -rf $HOST_DIR/pgadmin/*
chown -R 5050:5050 $HOST_DIR/pgadmin

# Configure Nexus folder permissions
mkdir -p $HOST_DIR/nexus/
rm -rf $HOST_DIR/nexus/*
chown -R 200:200 $HOST_DIR/nexus

# Configure CodeServer folder permissions
mkdir -p $HOST_DIR/codeserver
rm -rf $HOST_DIR/codeserver/*
chown -R 2311:2311 $HOST_DIR/codeserver

# Configure Airflow folder permissions
mkdir -p $HOST_DIR/airflow/app/plugins
rm -rf $HOST_DIR/airflow/app/plugins/*

mkdir -p $HOST_DIR/airflow/app/dags
rm -rf $HOST_DIR/airflow/app/dags/*

mkdir -p $HOST_DIR/airflow/app/logs
rm -rf $HOST_DIR/airflow/app/logs/*

chown -R 50000:50000 $HOST_DIR/airflow/app/

# MediaServer
mkdir -p $HOST_DIR/mediaserver/downloads/torrent
rm -rf $HOST_DIR/mediaserver/downloads/torrent/*

mkdir -p $HOST_DIR/mediaserver/downloads/completed
rm -rf $HOST_DIR/mediaserver/downloads/completed/*

mkdir -p $HOST_DIR/mediaserver/downloads/completed/Movies
rm -rf $HOST_DIR/mediaserver/downloads/completed/Movies/*

mkdir -p $HOST_DIR/mediaserver/music
rm -rf $HOST_DIR/mediaserver/music/*

mkdir -p $HOST_DIR/mediaserver/movies
rm -rf $HOST_DIR/mediaserver/movies/*

mkdir -p $HOST_DIR/mediaserver/tv
rm -rf $HOST_DIR/mediaserver/tv/*

## Plex
mkdir -p $HOST_DIR/mediaserver/plex/config
rm -rf $HOST_DIR/mediaserver/plex/config/*

mkdir -p $HOST_DIR/mediaserver/plex/transcode
rm -rf $HOST_DIR/mediaserver/plex/transcode/*

## Lazy Librarian
mkdir -p $HOST_DIR/mediaserver/ebooks
mkdir -p $HOST_DIR/mediaserver/audiobooks

chown -R 201:201 $HOST_DIR/mediaserver/

# Duplicati
export BACKUP_DIR=/mnt/wd_1000/backups/
export PRIMARY_RESTORE_DIR=/mnt/hitachi_500/restore
export SECONDARY_RESTORE_DIR=/mnt/external_hdd/restore

mkdir -p $HOST_DIR/duplicati/config/
chown -R 2234:2234 $HOST_DIR/duplicati

chgrp -R 2234 $HOST_DIR
chmod -R g+r $HOST_DIR

mkdir -p $BACKUP_DIR
chown -R 2234:2234 $BACKUP_DIR

mkdir -p $PRIMARY_RESTORE_DIR
chown -R 2234:2234 $PRIMARY_RESTORE_DIR

mkdir -p $SECONDARY_RESTORE_DIR
chown -R 2234:2234 $SECONDARY_RESTORE_DIR

# SonarQube
sysctl -w vm.max_map_count=262144
mkdir -p $HOST_DIR/sonarqube/db
mkdir -p $HOST_DIR/sonarqube/app/data
mkdir -p $HOST_DIR/sonarqube/app/extensions
mkdir -p $HOST_DIR/sonarqube/app/logs
chown -R 1000:1000 $HOST_DIR/sonarqube

# SFTPGO
mkdir -p $HOST_DIR/sftpgo/srv/sftpgo
mkdir -p $HOST_DIR/sftpgo/var/lib/sftpgo
chown -R 1000:2234 $HOST_DIR/sftpgo/var/lib/sftpgo

# Ollama
mdkir -p $HOST_DIR/ollama
chown -R 1000:2234 $HOST_DIR/ollama

# Open-WebUI
mkdir -p $HOST_DIR/open-webui
chown -R 1000:2234 $HOST_DIR/open-webui

# Ghost
mkdir -p $HOST_DIR/ghost/app
mkdir -p $HOST_DIR/ghost/db
chrown -R 1000:2234 $HOST_DIR/ghost

# Postiz
mkdir -p $HOST_DIR/postiz/app/config
mkdir -p $HOST_DIR/postiz/app/uploads
mkdir -p $HOST_DIR/postiz/db
mkdir -p $HOST_DIR/postiz/redis
chown -R 1000:1000 $HOST_DIR/postiz

# Immich
mkdir -p $HOST_DIR/immich/app
mkdir -p $HOST_DIR/immich/db
mkdir -p $HOST_DIR/immich/ml-cache

# Affine
mkdir -p $HOST_DIR/affine/db
mkdir -p $HOST_DIR/affine/app/uploads
mkdir -p $HOST_DIR/affine/app/config
