# Ghost Blog Platform

Ghost is a powerful open source publishing platform. This directory contains a Dockerized setup of the Ghost blogging platform.

## Overview

This setup provides a containerized Ghost instance with:
- MySQL database for content storage
- Persistent volume for media uploads
- Custom configuration options via environment variables
- Automatic HTTPS support (when configured)

## Prerequisites

- Docker and Docker Compose installed
- Make (optional, but recommended)

## Quick Start

1. Copy the environment template:
```sh
cp template.env .env
```

2. Start the application:
```sh
make ghost-up
# or using docker-compose directly
docker-compose up -d
```

3. Access Ghost at `http://localhost:2368` (or your configured domain)

## Environment Configuration

Key environment variables in `.env`:

- `GHOST_PORT`: Host port (default `2368`; Ghost always listens on `2368` internally)
- `PUBLIC_URL`: Your blog's public URL (e.g., `https://rishabmanocha.com`)
- `ADMIN_URL`: Ghost admin panel URL (e.g., `https://ghost.rishabmanocha.com`)
- `GHOST_MOUNT_DIR`: Persistent volume for Ghost content (themes, images, etc.)
- `MYSQL_ROOT_PASSWORD`: Root password for MySQL
- `MYSQL_MOUNT_DIR`: Persistent MySQL data directory
- `GHOST_DB_NAME`: Database name for Ghost
- `GHOST_DB_USER`: MySQL user for Ghost
- `GHOST_DB_PASSWORD`: MySQL password for Ghost

**SMTP (Mailgun):**
- `MAIL_SERVICE`: Mail service provider (e.g., `Mailgun`)
- `MAIL_HOST`: SMTP server (e.g., `smtp.mailgun.org`)
- `MAIL_PORT`: SMTP port (default `465` for SMTPS)
- `MAIL_AUTH_USER` / `MAIL_AUTH_PASS`: Mailgun SMTP credentials
- `MAIL_SECURE_CONNECTION`: Set to `true` for TLS

## Data Persistence

Ghost data is persisted in two locations:
- `/var/lib/ghost/content`: Ghost content (themes, images, etc.)
- MySQL database data

## Troubleshooting

Common issues and solutions:

1. **Cannot access Ghost**
   - Verify the port mapping in docker-compose.yml
   - Check if the container is running: `docker ps`
   - Ensure no other service is using port 2368

2. **Database connection issues**
   - Verify MySQL container is running
   - Check database credentials in .env
   - Ensure MySQL data volume exists

3. **Content not persisting**
   - Verify volume mounts in docker-compose.yml
   - Check permissions on host directories

## Additional Resources

- [Official Ghost Documentation](https://ghost.org/docs/)
- [Ghost Docker Image](https://hub.docker.com/_/ghost/)
- [Back to Main Repository](..)

## License

This Ghost setup is provided under the same license as the main repository. Ghost itself is licensed under [MIT License](https://github.com/TryGhost/Ghost/blob/master/LICENSE).
