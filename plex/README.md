# Plex Media Server

## Overview
Plex Media Server is a client-server media player system and software suite. This Docker setup provides a self-hosted Plex server to organize and stream your media collection.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Media library accessible to the container
- Plex account (free)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `PLEX_PORT`: External port for accessing Plex (default: 32400)
- `PLEX_CLAIM`: Claim token from plex.tv/claim
- `PLEX_DATA`: Path to store Plex configuration and metadata
- `MEDIA_LIBRARY`: Path to your media library
- `ADVERTISE_IP`: IP address to advertise for the server (for remote access)

## Usage
- Access Plex at `http://your-server-ip:PLEX_PORT/web`
- Sign in with your Plex account
- Add your media libraries and enjoy your content

## Troubleshooting
- For permission issues with media, check that the container user has access to the mounted directories
- Hardware transcoding might require additional configuration
- Remote access issues could be related to port forwarding or your network configuration

## Further Resources
- [Official Plex Documentation](https://support.plex.tv/)
- [Return to Main Documentation](../README.md)
