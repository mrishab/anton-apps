# Nexus Repository Manager

## Overview
Nexus Repository Manager is a repository manager that supports multiple package formats. This Docker setup provides a self-hosted repository for Maven, npm, Docker, and other formats.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Minimum 4GB of RAM available for the container
- Sufficient disk space for package storage

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `NEXUS_PORT`: External port for accessing the Nexus web interface (default: 8081)
- `NEXUS_DATA`: Path to store Nexus data and packages
- `NEXUS_DOCKER_PORT`: Port for Docker repository (default: 8082)
- `MEMORY_LIMIT`: JVM memory limit (e.g., "2G")

## Usage
- Access the web interface at `http://your-server-ip:NEXUS_PORT`
- Default admin password is stored in `/nexus-data/admin.password` inside the container
- Create and configure repositories for your package formats
- Set up proxy repositories to cache packages from public repositories

## Troubleshooting
- Memory issues might require increasing the JVM memory limit
- Slow performance could be related to insufficient resources; check Docker host metrics
- Permission issues with mounted volumes should be fixed by adjusting the ownership

## Further Resources
- [Official Nexus Documentation](https://help.sonatype.com/repomanager3)
- [Return to Main Documentation](../README.md)
