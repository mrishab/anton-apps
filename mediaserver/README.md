# Media Server (Jellyfin)

## Overview
This Docker setup provides a full-featured media server using Jellyfin, an open-source alternative to Plex and Emby. Jellyfin lets you collect, manage, and stream your media to any device.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Media library (movies, TV shows, music, etc.) accessible to the container
- Sufficient system resources for transcoding (especially if 4K content is used)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `JELLYFIN_PORT`: External port for accessing the Jellyfin web interface (default: 8096)
- `JELLYFIN_DATA`: Path to store Jellyfin configuration and cache
- `MEDIA_LIBRARY`: Path to your media collection
- `PUID`: User ID for permissions
- `PGID`: Group ID for permissions
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:JELLYFIN_PORT`
- Complete the initial setup wizard
- Add your media libraries (movies, TV shows, music)
- Create user accounts for your family members or friends

## Troubleshooting
- Transcoding issues may require checking hardware acceleration settings
- Permission problems with media files can be resolved by setting correct PUID/PGID
- High CPU usage during playback could indicate transcoding is necessary; adjust quality settings

## Further Resources
- [Official Jellyfin Documentation](https://jellyfin.org/docs/)
- [Return to Main Documentation](../README.md)
