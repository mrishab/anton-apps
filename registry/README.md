# Docker Registry

## Overview
Docker Registry is a stateless, highly scalable server-side application that stores and distributes Docker images. This setup provides a private Docker registry for your organization or personal use.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- SSL certificates (recommended for production)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `REGISTRY_PORT`: External port for accessing the registry (default: 5000)
- `REGISTRY_DATA`: Path to store registry data
- `REGISTRY_USERNAME`: Username for basic authentication (if enabled)
- `REGISTRY_PASSWORD`: Password for basic authentication (if enabled)
- `REGISTRY_STORAGE_DELETE_ENABLED`: Enable image deletion (true/false)

## Usage
- Push images to your registry:
  ```sh
  docker tag myimage:latest your-registry-ip:REGISTRY_PORT/myimage:latest
  docker push your-registry-ip:REGISTRY_PORT/myimage:latest
  ```
- Pull images from your registry:
  ```sh
  docker pull your-registry-ip:REGISTRY_PORT/myimage:latest
  ```

## Troubleshooting
- For insecure registry issues, add your registry to Docker's insecure registries list
- Authentication problems may require checking the authentication configuration
- Storage issues might be related to permissions on mounted volumes

## Further Resources
- [Official Docker Registry Documentation](https://docs.docker.com/registry/)
- [Return to Main Documentation](../README.md)
