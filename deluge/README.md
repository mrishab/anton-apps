# Deluge

## Overview
Deluge is a lightweight, free BitTorrent client. This Docker setup provides a self-hosted Deluge instance with a web interface for managing your downloads.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Download directory accessible to the container

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `DELUGE_WEB_PORT`: External port for accessing the Deluge web interface (default: 8112)
- `DELUGE_DAEMON_PORT`: Deluge daemon port (default: 58846)
- `DELUGE_DATA`: Path to store Deluge configuration
- `DOWNLOADS_DIR`: Path to store downloaded files
- `PUID`: User ID for permissions
- `PGID`: Group ID for permissions
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:DELUGE_WEB_PORT`
- Default password is "deluge"
- Configure your preferences and download locations
- Start adding torrents through the web interface

## Troubleshooting
- If connections to trackers are slow, check your network configuration and firewall settings
- Permission issues with the downloads directory can be fixed by setting appropriate PUID/PGID values
- Performance problems might require adjusting queue settings and connection limits

## Further Resources
- [Official Deluge Documentation](https://dev.deluge-torrent.org/wiki/UserGuide)
- [Return to Main Documentation](../README.md)
