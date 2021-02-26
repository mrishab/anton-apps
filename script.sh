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

mkdir -p $HOST_DIR/mediaserver/movies
rm -rf $HOST_DIR/mediaserver/movies/*

mkdir -p $HOST_DIR/mediaserver/tv
rm -rf $HOST_DIR/mediaserver/tv/*

mkdir -p $HOST_DIR/mediaserver/plex/config
rm -rf $HOST_DIR/mediaserver/plex/config/*

mkdir -p $HOST_DIR/mediaserver/plex/transcode
rm -rf $HOST_DIR/mediaserver/plex/transcode/*

chown -R 201:201 $HOST_DIR/mediaserver/