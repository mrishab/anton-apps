# Code Server

Code Server provides VS Code in the browser, enabling you to code from anywhere.

## Overview

This deployment includes:
- VS Code in browser with extension support
- Persistent storage for workspaces and settings
- Multi-user support with isolation

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
CODESERVER_WEB_UI_PORT=8080                          # Web interface port
CODESERVER_USER=coder                                # Application user
CODESERVER_GID=2311                                  # Group ID for the user
CODESERVER_UID=2311                                  # User ID for the user
CODESERVER_MOUNT_DIR=/mnt/external_hdd/codeserver    # Data directory
```

### Data Directories

Ensure proper permissions:

```sh
sudo mkdir -p /mnt/external_hdd/codeserver
sudo chown -R 2311:2311 /mnt/external_hdd/codeserver
```

## Usage

### Starting the Application

```sh
# From the codeserver directory
docker-compose up -d

# Or from the parent directory
make start APPS="codeserver"
```

### Accessing the Interface

Access Code Server at:
```
http://your-server-ip:CODESERVER_WEB_UI_PORT
```

### Initial Setup

1. Set a password on first login
2. Install desired extensions
3. Configure workspace settings

## Maintenance

### Updates

```sh
docker-compose pull
docker-compose up -d
```

### Backups

Back up the mount directory:
```sh
tar -czf codeserver_backup.tar.gz /path/to/codeserver
```

## Troubleshooting

### Common Issues

- **Permission Issues**: Verify UID/GID settings
- **Extension Problems**: Check browser console logs
- **Performance Issues**: Monitor resource usage

### Logs

```sh
docker logs codeserver
```

## Additional Resources

- [Code Server Documentation](https://coder.com/docs/code-server/latest)
- [GitHub Repository](https://github.com/coder/code-server)
- [Main Repository README](../README.md)

