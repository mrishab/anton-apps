# SonarQube

## Overview
SonarQube is an open-source platform for continuous inspection of code quality. This Docker setup provides a self-hosted SonarQube instance for detecting bugs, vulnerabilities, and code smells in your codebase.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Minimum 4GB of RAM for the SonarQube container
- Elasticsearch requires specific system settings (see troubleshooting)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `SONARQUBE_PORT`: External port for accessing the SonarQube web interface (default: 9000)
- `SONARQUBE_DATA`: Path to store SonarQube data
- `POSTGRESQL_USER`: Database username
- `POSTGRESQL_PASSWORD`: Database password
- `POSTGRESQL_DATABASE`: Database name

## Usage
- Access the web interface at `http://your-server-ip:SONARQUBE_PORT`
- Default login is admin/admin
- Create projects and run analyses to measure code quality

## Troubleshooting
- If SonarQube fails to start, check Elasticsearch requirements:
  ```sh
  sysctl -w vm.max_map_count=262144
  ```
- Database connection issues may require checking PostgreSQL container logs
- SonarQube requires significant memory; adjust Docker memory limits if needed

## Further Resources
- [Official SonarQube Documentation](https://docs.sonarqube.org/)
- [Return to Main Documentation](../README.md)
