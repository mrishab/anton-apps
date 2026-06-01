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
docker compose up -d
```

### Environment Variables
- `PLEX_WEB_UI_PORT`: Host port for accessing Plex (default: `32400`)
- `PLEX_CONFIG_MOUNT_DIR`: Path to store Plex configuration and metadata
- `PLEX_TRANSCODE_MOUNT_DIR`: Path to store temporary transcode files
- `PLEX_ALLOWED_NETWORKS`: Local networks allowed without authentication (e.g. `192.168.1.0/24`)
- `MEDIA_MOVIES_MOUNT_DIR` / `MEDIA_TV_MOUNT_DIR` / `MEDIA_MUSIC_MOUNT_DIR` / `MEDIA_COURSES_MOUNT_DIR`: Paths to your media libraries
- `APP_PUID` / `APP_PGID`: Run-as user/group identity
- `HOST_TZ`: Timezone setting

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
