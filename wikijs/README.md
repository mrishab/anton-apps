# Wiki.js

## Overview
Wiki.js is a modern, lightweight and powerful wiki app built on Node.js. This Docker setup enables you to quickly deploy your own wiki for documentation, knowledge management, and collaboration.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- PostgreSQL database (can be configured as a separate container)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `WIKIJS_PORT`: External port for accessing the Wiki.js interface (default: 3000)
- `DB_USER`: Database username
- `DB_PASSWORD`: Database password
- `DB_NAME`: Database name
- `DB_HOST`: Database host address
- `DB_PORT`: Database port

## Usage
- Access the web interface at `http://your-server-ip:WIKIJS_PORT`
- Complete the initial setup wizard
- Create and organize your wiki content with the powerful editor

## Troubleshooting
- For database connection issues, verify your database credentials and ensure the database is running
- Check logs with `docker-compose logs wikijs` for more detailed error information

## Further Resources
- [Official Wiki.js Documentation](https://docs.requarks.io/)
- [Return to Main Documentation](../README.md)
