# Nextcloud

Nextcloud is a self-hosted productivity platform that provides a content collaboration platform, file synchronization and sharing solution with enhanced security features.

## Overview

This deployment includes:
- Nextcloud server with Apache
- PostgreSQL database
- Face recognition application pre-installed

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# POSTGRES Configuration
PG_USERNAME=postgres          # PostgreSQL superuser username
PG_PASSWORD=your_secure_pass  # PostgreSQL superuser password
PG_PORT=5432                  # PostgreSQL port
PG_DATABASE=postgres          # PostgreSQL database name
PG_MOUNT_DIR=/path/to/pg/data # PostgreSQL data directory

# Nextcloud Configuration
NC_USERNAME=nextcloud         # Nextcloud database user
NC_PASSWORD=secure_password   # Nextcloud database password
NC_DATABASE=nextcloud         # Nextcloud database name

# Nextcloud App Configuration
NC_PORT=8080                  # Web port for Nextcloud
NC_ADMIN_USERNAME=admin       # Nextcloud admin username
NC_ADMIN_PASSWORD=admin_pass  # Nextcloud admin password
NC_MOUNT_DIR=/path/to/data    # Data directory for Nextcloud
NC_TRUSTED_DOMAINS=nextcloud.local,192.168.1.10  # Comma-separated trusted domains
```

### Data Directories

Ensure proper permissions on the mount directories:

```sh
sudo mkdir -p /path/to/data
sudo chown -R www-data:www-data /path/to/data
```

## Usage

### Starting the Application

```sh
# From the nextcloud directory
docker-compose up -d

# Or from the parent directory
make start APPS="nextcloud"
```

### Accessing the Application

After starting the container, access Nextcloud at:

```
http://your-server-ip:NC_PORT
```

### Face Recognition Setup

After initial installation, run the following to configure the face recognition app:

```sh
./facerecognition-config.sh
```

### Scanning Files

To scan files in Nextcloud:

```sh
./import.sh
```

## Maintenance

### Backing Up

To back up your Nextcloud installation:

1. Back up the PostgreSQL database:
   ```sh
   docker exec -t nextcloud_postgres pg_dump -U postgres nextcloud > nextcloud_db_backup.sql
   ```

2. Back up the data directory:
   ```sh
   tar -czf nextcloud_data_backup.tar.gz /path/to/data
   ```

### Upgrading

1. Update the image version in the Dockerfile
2. Rebuild and restart:
   ```sh
   docker-compose build
   docker-compose up -d
   ```

## Troubleshooting

### Common Issues

- **Database Connection Error**: Check PostgreSQL container is running and credentials in .env are correct
- **Permission Issues**: Ensure proper ownership on the mount directories
- **Face Recognition Not Working**: Check if the app is enabled in Nextcloud settings

### Logs

```sh
# View Nextcloud logs
docker logs nextcloud

# View PostgreSQL logs
docker logs nextcloud_postgres
```

## Additional Resources

- [Nextcloud Documentation](https://docs.nextcloud.com/)
- [Main Repository README](../README.md)
