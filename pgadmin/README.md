# pgAdmin

## Overview
pgAdmin is a management tool for PostgreSQL and derivative relational databases. This Docker setup provides a web-based administration interface for managing your PostgreSQL databases.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- PostgreSQL server (can be on a separate container or remote host)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `PGADMIN_PORT`: External port for accessing the pgAdmin web interface (default: 5050)
- `PGADMIN_DEFAULT_EMAIL`: Default administrator email
- `PGADMIN_DEFAULT_PASSWORD`: Default administrator password
- `PGADMIN_DATA`: Path to store pgAdmin data

## Usage
- Access the web interface at `http://your-server-ip:PGADMIN_PORT`
- Log in with the email and password specified in the environment variables
- Add your PostgreSQL server connections through the interface

## Troubleshooting
- If you cannot connect to your PostgreSQL server, ensure network connectivity between pgAdmin and the database server
- Check that the PostgreSQL server is configured to accept remote connections
- Verify that any firewall rules allow the connection

## Further Resources
- [Official pgAdmin Documentation](https://www.pgadmin.org/docs/)
- [Return to Main Documentation](../README.md)
