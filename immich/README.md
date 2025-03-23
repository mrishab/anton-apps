# Immich

Immich is a self-hosted photo and video backup solution designed to be a Google Photos alternative. It provides a mobile app, web interface, and automatic backup capabilities.

## Overview

This deployment includes:
- Immich server with API, web interface, and microservices
- PostgreSQL database with vector search capabilities
- Redis for caching and message queueing
- Machine learning service for photo analysis

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# Storage locations
UPLOAD_LOCATION=./library                              # Where uploaded files are stored
ML_CACHE_DIR=/mnt/external_hdd/immich/ml-cache        # Machine learning cache location
EXTERNAL_LIBRARY_NEXTCLOUD_PATH=/mnt/external_hdd/nextcloud/html/data # Path to Nextcloud data (optional)
DB_DATA_LOCATION=./postgres                            # Database storage location

# Optional timezone setting
# TZ=Etc/UTC                                           # Your timezone

# Immich version
IMMICH_VERSION=release                                 # Set to specific version or 'release' for latest

# Database credentials
DB_PASSWORD=postgres                                   # Postgres password (change this!)
DB_USERNAME=postgres                                   # Postgres username
DB_DATABASE_NAME=immich                                # Database name
```

### Hardware Requirements

- **CPU**: 4+ cores recommended
- **RAM**: 8GB minimum, 16GB+ recommended
- **Storage**: Depends on your library size (plan accordingly)
- **GPU**: Optional, but recommended for faster machine learning capabilities

## Usage

### Starting the Application

```sh
# From the immich directory
docker-compose up -d

# Or from the parent directory
make start APPS="immich"
```

### Accessing the Application

After starting the container, access the Immich web interface at:

```
http://your-server-ip:2283
```

### Mobile App Setup

1. Download the Immich mobile app from Google Play or App Store
2. Enter your server URL (http://your-server-ip:2283)
3. Create an account or log in
4. Set up auto backup in the app settings

### External Libraries

Immich can access photos from external sources such as Nextcloud:

1. Configure the `EXTERNAL_LIBRARY_NEXTCLOUD_PATH` in your .env file
2. Restart the service
3. Use the "External Libraries" feature in the web UI to import

## Maintenance

### Backup Strategy

1. Regular database backups:
   ```sh
   docker exec immich_postgres pg_dump -U postgres immich > immich_backup.sql
   ```

2. Backup the upload directory:
   ```sh
   tar -czf immich_library_backup.tar.gz /path/to/library
   ```

### Updates

To update to the latest version:

1. Edit the .env file to set `IMMICH_VERSION=release` (or a specific version)
2. Pull and restart:
   ```sh
   docker-compose pull
   docker-compose up -d
   ```

## Troubleshooting

### Common Issues

- **Database Connection Errors**: Check the database container is running
- **Upload Failures**: Verify permissions on the upload directory
- **Machine Learning Issues**: Check ML container logs and ensure enough resources

### Logs

```sh
# View server logs
docker logs immich_server

# View database logs
docker logs immich_postgres

# View machine learning logs
docker logs immich_machine_learning
```

## Hardware Acceleration

For improved performance, you can enable hardware acceleration:

1. Uncomment the relevant sections in docker-compose.yml
2. Choose the appropriate hardware acceleration option for your system
3. Restart the service

## Additional Resources

- [Immich Documentation](https://immich.app/docs)
- [Immich GitHub](https://github.com/immich-app/immich)
- [Main Repository README](../README.md)
