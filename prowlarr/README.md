# Prowlarr

Prowlarr is an indexer manager/proxy built for various PVR apps. It integrates with Sonarr, Radarr, Lidarr, and other download clients to provide comprehensive searching capabilities.

## Overview

This deployment includes:
- Prowlarr server with web UI
- Configuration for integrating with download clients
- Support for multiple indexers and trackers

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# Global
HOST_TZ=America/New_York                       # Your timezone
APP_PUID=1000                                  # User ID to run as
APP_PGID=1000                                  # Group ID to run as
DOWNLOADS_MOUNT_DIR=/mnt/external_hdd/mediaserver/downloads   # Common downloads directory

# Prowlarr
PROWLARR_WEB_UI_PORT=9696                      # Web UI port
PROWLARR_CONFIG_MOUNT_DIR=/mnt/external_hdd/prowlarr/config   # Config directory
```

### Data Directories

Ensure proper permissions on the mount directories:

```sh
sudo mkdir -p /path/to/prowlarr/config
sudo mkdir -p /path/to/downloads/torrent
sudo chown -R 1000:1000 /path/to/prowlarr
sudo chown -R 1000:1000 /path/to/downloads
```

## Usage

### Starting the Application

```sh
# From the prowlarr directory
docker-compose up -d

# Or from the parent directory
make start APPS="prowlarr"
```

### Accessing the Web UI

After starting the container, access the Prowlarr web interface at:

```
http://your-server-ip:PROWLARR_WEB_UI_PORT
```

### Setting Up Indexers

1. Navigate to the "Indexers" tab
2. Click "Add Indexer" and select from the available options
3. Configure the indexer with your credentials
4. Test the indexer to ensure connectivity

### Integrating with Apps

1. Go to "Settings" > "Apps"
2. Add applications like Sonarr, Radarr, or Lidarr
3. Configure the connection details for each app
4. Sync the indexers to your applications

## Maintenance

### Updating Indexers

- Periodically check for outdated indexers
- Update configurations when sites change their requirements
- Remove defunct indexers to avoid errors

### Performance Tuning

- Adjust search limits to prevent overloading indexers
- Configure appropriate caching settings
- Set up rate limiting for busy indexers

## Troubleshooting

### Common Issues

- **Indexer Connection Errors**: Check API keys and site availability
- **Integration Failures**: Verify app connection details and API keys
- **Search Timeouts**: Increase timeout values for slower indexers

### Logs

```sh
docker logs prowlarr
```

## Additional Resources

- [Prowlarr Wiki](https://wiki.servarr.com/prowlarr/)
- [Prowlarr GitHub](https://github.com/Prowlarr/Prowlarr)
- [Main Repository README](../README.md)
