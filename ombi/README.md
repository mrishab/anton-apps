# Ombi

## Overview
Ombi is a self-hosted web application that allows users to request movies and TV shows for Plex, Emby, or Jellyfin. This Docker setup enables you to quickly deploy Ombi to manage media requests from your users.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Plex, Emby, or Jellyfin server (preferably running in Docker as well)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `OMBI_PORT`: External port for accessing the Ombi web interface (default: 3579)
- `OMBI_DATA`: Path to store Ombi configuration data
- `PUID`: User ID for permissions
- `PGID`: Group ID for permissions
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:OMBI_PORT`
- Complete the initial setup wizard
- Connect Ombi to your media server and configure request settings
- Share the URL with users so they can request content

## Troubleshooting
- If Ombi cannot connect to your media server, check network connectivity and credentials
- For permission issues, make sure the PUID and PGID are set correctly
- Database errors may require checking the Ombi logs with `docker-compose logs ombi`

## Further Resources
- [Official Ombi Documentation](https://docs.ombi.app/)
- [Return to Main Documentation](../README.md)
