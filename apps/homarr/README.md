# Homarr

Homarr is a simple, yet powerful dashboard for your server. It is easy to use, ships with all dependencies inside a single container and is easy to use and maintain.

## Port
- **Port**: Binds to `HOMARR_PORT` (default `7575`).

## Volume Mounts
- `HOMARR_DATA_MOUNT_DIR`: Configuration/database directory on the host (e.g. `/mnt/external_hdd/homarr/appdata`).
- `/var/run/docker.sock`: Optional docker socket mount for container integration.
