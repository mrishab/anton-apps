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
**pgAdmin:**
- `PGADMIN_WEB_PORT`: Host port for the pgAdmin web interface (default: `3487`)
- `PGADMIN_DEFAULT_EMAIL`: Administrator login email
- `PGADMIN_DEFAULT_PASSWORD`: Administrator login password
- `PGADMIN_MOUNT_DIR`: Persistent pgAdmin data directory

**Bundled PostgreSQL instance:**
- `PG_USERNAME` / `PG_PASSWORD` / `PG_DATABASE`: Superuser credentials
- `PG_MOUNT_DIR`: PostgreSQL data directory
- `PERSONAL_DB_USER` / `PERSONAL_DB_PASS` / `PERSONAL_DB_NAME`: Personal application database credentials

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
