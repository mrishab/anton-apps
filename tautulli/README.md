# Tautulli

Tautulli is a monitoring and analytics application for Plex Media Server that provides detailed insights about your Plex usage, viewing history, and user statistics.

## Overview

This deployment includes:
- Tautulli server with web UI
- Persistent configuration and database storage
- Comprehensive Plex monitoring capabilities
- Notification system for Plex events

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# Global Configuration
HOST_TZ=America/New_York                      # Your timezone
APP_PUID=1000                                # User ID to run as
APP_PGID=1000                                # Group ID to run as

# Tautulli Configuration
TAUTULLI_WEB_UI_PORT=8181                    # Web UI port
TAUTULLI_CONFIG_MOUNT_DIR=/mnt/data/tautulli # Config directory

# Plex Integration
PLEX_SERVER_URL=http://plex:32400            # Your Plex server URL (if linking containers)
```

### Data Directories

Ensure proper permissions on the mount directories:

```sh
sudo mkdir -p /mnt/data/tautulli
sudo chown -R 1000:1000 /mnt/data/tautulli
```

## Usage

### Starting the Application

```sh
# From the tautulli directory
docker-compose up -d

# Or from the parent directory
make start APPS="tautulli"
```

### Accessing the Web UI

After starting the container, access the Tautulli web interface at:

```
http://your-server-ip:TAUTULLI_WEB_UI_PORT
```

### Initial Setup

1. Follow the setup wizard to connect to your Plex server
2. Enter your Plex authentication details when prompted
3. Configure notification agents if desired
4. Customize your dashboard and display settings

## Features

### Monitoring Capabilities

- **User Statistics**: Track who watches what content and when
- **History**: View detailed playback history with media info
- **Bandwidth Monitoring**: Monitor bandwidth usage by user and device
- **Library Stats**: Get insights into your media library composition
- **Watch Time**: See total watch time by user, library, or content

### Notification System

Configure notifications for:
- New media additions
- User activity
- Server issues
- Playback events

### Customizable Reports

- Generate regular activity reports
- Export viewing statistics
- Create custom newsletter emails for users

## Maintenance

### Database Management

- Database backups are stored in the config directory
- Optimize database periodically through the Settings menu
- Backup configuration through the Settings menu

### Updates

```sh
docker-compose pull
docker-compose up -d
```

## Troubleshooting

### Common Issues

- **Cannot Connect to Plex**: Verify Plex server URL and accessibility
- **Database Corruption**: Restore from a backup in the settings menu
- **Missing History**: Check Plex server logs for failed logging

### Logs

```sh
docker logs tautulli
```

## Additional Resources

- [Tautulli Wiki](https://github.com/Tautulli/Tautulli/wiki)
- [Tautulli GitHub](https://github.com/Tautulli/Tautulli)
- [Main Repository README](../README.md)
