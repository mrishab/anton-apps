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

- `GHOST_URL`: Your blog's URL (e.g., http://localhost:2368)
- `MYSQL_ROOT_PASSWORD`: Root password for MySQL
- `MYSQL_DATABASE`: Database name for Ghost
- `MYSQL_USER`: MySQL user for Ghost
- `MYSQL_PASSWORD`: MySQL password for Ghost

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
