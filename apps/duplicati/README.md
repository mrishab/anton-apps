# Duplicati

Duplicati is a free, open-source backup software that securely stores encrypted, incremental, compressed backups on cloud storage services and remote file servers.

## Overview

This deployment includes:
- Duplicati server with web UI
- Configuration for multiple backup sources and destinations
- Settings encryption key support
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
HOST_TZ=America/Vancouver                      # Your timezone
APP_PUID=1000                                  # User ID to run as
APP_PGID=1000                                  # Group ID to run as

# Duplicati
DUPLICATI_WEB_UI_PORT=8200                     # Web UI port
DUPLICATI_CONFIG_MOUNT_DIR=/mnt/external_hdd/duplicati/config        # Config directory (mounted to /config)
DUPLICATI_PRIMARY_BACKUPS_MOUNT_DIR=/mnt/wd_portable_hdd_3tb         # Primary backup destination (mounted to /primary_backups)
DUPLICATI_SECONDARY_BACKUPS_MOUNT_DIR=/mnt/sony_portable_hdd_1tb     # Secondary backup destination (mounted to /secondary_backups)
DUPLICATI_SOURCE_MOUNT_DIR=/mnt/external_hdd                         # Source data to back up (mounted to /source)
DUPLICATI_SETTINGS_ENCRYPTION_KEY=your-encryption-key               # Key used to encrypt the Duplicati settings database
```

## Usage

### Starting the Application

```sh
docker compose up -d
```

### Accessing the Web UI

After starting the container, access the Duplicati web interface at:

```
http://your-server-ip:DUPLICATI_WEB_UI_PORT
```

### Setting Up Backups

1. Access the web UI and click "Add backup"
2. Choose a backup destination:
   - `/primary_backups` — primary drive (large capacity)
   - `/secondary_backups` — secondary drive (additional redundancy)
3. Select source data from `/source` (maps to `DUPLICATI_SOURCE_MOUNT_DIR`)
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
3. Choose files to restore and a target path

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
