HOST_DIR=/mnt/external_hdd/
HOST_USER=mrishab

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
