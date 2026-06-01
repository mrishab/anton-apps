# Code Server

Code Server provides VS Code in the browser, enabling you to code from anywhere.

## Overview

This deployment includes:
- VS Code in the browser with extension support
- Persistent storage for workspaces and settings

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
CODESERVER_WEB_UI_PORT=2342          # Host port for the web interface (container port is always 8080)
CODESERVER_USER=mrishab              # DOCKER_USER env for the code-server process
CODESERVER_UID=1000                  # User ID to run the container process as
CODESERVER_GID=1000                  # Group ID to run the container process as
CODESERVER_MOUNT_DIR=/mnt/external_hdd/codeserver/config  # Mounted to /home/coder inside the container
```

## Usage

### Starting the Application

```sh
# From the codeserver directory
docker compose up -d
```

### Accessing the Interface

Access Code Server at:
```
http://your-server-ip:CODESERVER_WEB_UI_PORT
```

Or via reverse proxy at `https://code.cloudville.me`.

### Initial Setup

1. Set a password on first login
2. Install desired extensions
3. Configure workspace settings

## Maintenance

### Updates

```sh
docker compose pull
docker compose up -d
```

### Backups

Back up the mount directory:
```sh
tar -czf codeserver_backup.tar.gz /mnt/external_hdd/codeserver
```

## Troubleshooting

### Common Issues

- **Permission Issues**: Verify `CODESERVER_UID`/`CODESERVER_GID` match the host directory owner
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
