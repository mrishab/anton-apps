# NZBGet

## Overview
NZBGet is a binary downloader specifically designed for Usenet. This Docker setup provides a self-hosted NZBGet instance for downloading content from Usenet newsgroups efficiently.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Usenet service provider account
- Download destination path accessible to the container

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `NZBGET_PORT`: External port for accessing the NZBGet web interface (default: 6789)
- `NZBGET_DATA`: Path to store NZBGet configuration
- `DOWNLOADS_DIR`: Path to store downloaded files
- `PUID`: User ID for permissions
- `PGID`: Group ID for permissions
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:NZBGET_PORT`
- Default login is nzbget/tegbzn6789
- Configure your Usenet providers and downloaders
- Add NZB files to start downloading

## Troubleshooting
- Connection issues to Usenet providers may require checking your credentials or firewall settings
- Permission problems with downloads directory should be resolved by setting appropriate PUID/PGID
- Performance issues might be related to resource constraints; check container resource limits

## Further Resources
- [Official NZBGet Documentation](https://nzbget.net/documentation)
- [Return to Main Documentation](../README.md)
