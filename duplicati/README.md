# Duplicati

Duplicati is a free, open-source backup software that securely stores encrypted, incremental, compressed backups on cloud storage services and remote file servers.

## Overview

This deployment includes:
- Duplicati server with web UI
- Configuration for multiple backup sources and destinations
- Support for scheduled backups

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

# Duplicati
DUPLICATI_WEB_UI_PORT=8200                     # Web UI port
DUPLICATI_CONFIG_MOUNT_DIR=/mnt/external_hdd/duplicati/config     # Config directory
DUPLICATI_BACKUPS_MOUNT_DIR=/mnt/external_hdd/duplicati/backups   # Backups directory
DUPLICATI_SOURCE_MOUNT_DIR=/mnt/external_hdd/duplicati/source     # Source data directory
DUPLICATI_PRIMARY_RESTORE_MOUNT_DIR=/mnt/external_hdd/duplicati/primary_restore       # Primary restore directory
DUPLICATI_SECONDARY_RESTORE_MOUNT_DIR=/mnt/external_hdd/duplicati/secondary_restore   # Secondary restore directory
```

### Data Directories

Ensure proper permissions on the mount directories:

```sh
sudo mkdir -p /path/to/data/{config,backups,source,primary_restore,secondary_restore}
sudo chown -R 1000:1000 /path/to/data
```

## Usage

### Starting the Application

```sh
# From the duplicati directory
docker-compose up -d

# Or from the parent directory
make start APPS="duplicati"
```

### Accessing the Web UI

After starting the container, access the Duplicati web interface at:

```
http://your-server-ip:DUPLICATI_WEB_UI_PORT
```

### Setting Up Backups

1. Access the web UI and click "Add backup"
2. Choose a backup destination (local folder, cloud storage, etc.)
3. Select source data from the mounted directories:
   - `/source` contains your source files
   - `/backups` is for local backup storage
4. Configure scheduling and retention policies

## Maintenance

### Managing Backups

- **Verify Backups**: Regularly test the integrity of your backups
- **Monitor Space**: Watch storage usage on your backup destinations
- **Check Logs**: Review logs for backup failures or warnings

### Restoring Data

To restore data:

1. From the web UI, select the backup job
2. Click "Restore"
3. Choose files to restore
4. Select destination (primary or secondary restore directory)

## Troubleshooting

### Common Issues

- **Backup Failures**: Check source permissions and connectivity to destinations
- **Database Errors**: Try repairing the database from the About menu
- **Performance Issues**: Adjust block and file sizes in advanced settings

### Logs

```sh
docker logs duplicati
```

## Additional Resources

- [Duplicati Documentation](https://duplicati.readthedocs.io/)
- [Duplicati Forums](https://forum.duplicati.com/)
- [Main Repository README](../README.md)
