# PostiZ

## Overview
PostiZ is a self-hosted application for managing and sharing digital content. This Docker setup allows you to quickly deploy your own PostiZ instance.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Database service (included in docker-compose setup)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `POSTIZ_PORT`: External port for accessing the PostiZ web interface (default: 8085)
- `POSTIZ_DATA`: Path to store PostiZ data
- `DB_USER`: Database username
- `DB_PASSWORD`: Database password
- `DB_NAME`: Database name
- `SECRET_KEY`: Security key for session encryption

## Usage
- Access the web interface at `http://your-server-ip:POSTIZ_PORT`
- Register an admin account on first run
- Start creating and organizing your content

## Troubleshooting
- Database connection issues might require checking database container logs
- For permission problems, verify the ownership of mounted volumes
- Check the application logs with `docker-compose logs postiz` for detailed error information

## Further Resources
- [PostiZ Documentation](https://github.com/postiz)
- [Return to Main Documentation](../README.md)
