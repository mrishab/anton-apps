# Jenkins CI/CD Server

Jenkins is an open-source automation server that enables developers to build, test, and deploy their software. This directory contains a Dockerized Jenkins setup with common plugins and configurations.

## Overview

This Jenkins setup includes:
- Pre-installed popular plugins
- Docker-in-Docker support for container builds
- Persistent volume for Jenkins home directory
- Automated backup configuration
- Security configurations and best practices

## Prerequisites

- Docker and Docker Compose installed
- Make (optional, but recommended)
- At least 2GB of RAM available
- Docker socket access (for Docker-in-Docker)

## Quick Start

1. Set up environment:
```sh
cp template.env .env
```

2. Launch Jenkins:
```sh
make jenkins-up
# or using docker-compose directly
docker-compose up -d
```

3. Access Jenkins at `http://localhost:8080`

4. Get initial admin password:
```sh
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Environment Configuration

Key variables in `.env`:

- `JENKINS_ADMIN_ID`: Admin username (default: admin)
- `JENKINS_ADMIN_PASSWORD`: Admin password
- `JENKINS_URL`: Jenkins URL (e.g., http://localhost:8080)
- `JENKINS_OPTS`: Additional Jenkins options
- `DOCKER_GID`: Docker group ID for Docker-in-Docker support

## Data Persistence

Jenkins data is stored in:
- `/var/jenkins_home`: Configuration, jobs, and plugins
- `/var/jenkins_backup`: Automated backups (if enabled)

## Security Notes

- Change default admin credentials immediately
- Review and configure security realm
- Set up appropriate authorization strategy
- Configure proxy settings if behind a reverse proxy

## Troubleshooting

Common issues and solutions:

1. **Jenkins fails to start**
   - Check container logs: `docker logs jenkins`
   - Verify sufficient system resources
   - Ensure correct permissions on volume mounts

2. **Docker build issues**
   - Verify Docker socket mounting
   - Check Docker group ID configuration
   - Ensure Jenkins user has Docker permissions

3. **Plugin installation fails**
   - Check network connectivity
   - Verify proxy settings if applicable
   - Try restarting Jenkins

## Additional Resources

- [Official Jenkins Documentation](https://www.jenkins.io/doc/)
- [Jenkins Docker Image](https://hub.docker.com/r/jenkins/jenkins)
- [Back to Main Repository](..)

## License

This Jenkins setup is provided under the same license as the main repository. Jenkins is licensed under [MIT License](https://github.com/jenkinsci/jenkins/blob/master/LICENSE.txt).
