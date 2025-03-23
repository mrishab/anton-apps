# FreshRSS

## Overview
FreshRSS is a self-hosted RSS feed aggregator. This Docker setup provides a lightweight, responsive, and customizable feed reader to keep up with your favorite websites and blogs.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Database server (included in the docker-compose setup)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `FRESHRSS_PORT`: External port for accessing the FreshRSS web interface (default: 8080)
- `FRESHRSS_DATA`: Path to store FreshRSS data
- `DB_TYPE`: Database type (mysql, postgresql, sqlite)
- `DB_HOST`: Database host
- `DB_USER`: Database username
- `DB_PASSWORD`: Database password
- `DB_NAME`: Database name
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:FRESHRSS_PORT`
- Complete the initial setup with your preferred settings
- Add your RSS/Atom feeds and organize them into categories
- Access your feeds from any device or use compatible mobile apps

## Troubleshooting
- Database connection issues might require checking your database configuration
- Feed update problems could be related to cron job settings
- For slow performance, consider optimizing your database

## Further Resources
- [Official FreshRSS Documentation](https://freshrss.github.io/FreshRSS/en/)
- [Return to Main Documentation](../README.md)
