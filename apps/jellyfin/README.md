# Jellyfin Media Server

Jellyfin is a free, open-source software media system that puts you in control of managing and streaming your media.

## Features
- **GPU Acceleration**: Preconfigured with NVIDIA GPU reservations for hardware-accelerated transcoding.
- **RAM Transcoding**: Uses a 2GB RAM disk (`tmpfs` mounted at `/transcode-ram`) to execute video transcoding in memory, reducing disk wear on SSDs/HDDs.
- **Web UI & API**: Accessible via `JELLYFIN_WEB_UI_PORT` (typically 8096).

## Directory Mounts

- `/config` — Jellyfin configuration, users, metadata database
- `/cache` — Generated images, metadata caches
- `/music` — Music libraries
- `/movies` — Movie libraries
- `/tv` — TV show libraries
- `/courses` — Educational video libraries

## Environment Variables

- `JELLYFIN_PUBLISHED_SERVER_URL`: Public URL used by clients to locate the server.
- `JELLYFIN_CONFIG_MOUNT_DIR`: Path to the config directory on the host.
- `JELLYFIN_CACHE_MOUNT_DIR`: Path to the cache directory on the host.
- `MEDIA_MUSIC_MOUNT_DIR`: Music storage path.
- `MEDIA_MOVIES_MOUNT_DIR`: Movie storage path.
- `MEDIA_TV_MOUNT_DIR`: TV show storage path.
- `MEDIA_COURSES_MOUNT_DIR`: Course video storage path.
- `JELLYFIN_WEB_UI_PORT`: Host port for web interface access.
