# Threadfin

Threadfin is a fork of xTeVe, serving as an M3U proxy for Plex or Jellyfin. It acts as a virtual tuner, allowing you to feed IPTV playlists (M3U) and Electronic Program Guides (XMLTV) into your media servers.

## Features
- **M3U Proxy**: Manages and filters IPTV streams from M3U playlists for use with Plex DVR or Jellyfin Live TV.
- **Plex/Jellyfin Compatibility**: Emulates a SiliconDust HDHomeRun tuner so media servers treat it as a hardware tuner.
- **Port**: Binds to `THREADFIN_WEB_UI_PORT` (typically `34400`).

## Environment Variables
- `APP_PUID`/`APP_PGID`: Standard container run permissions.
- `HOST_TZ`: Host timezone configuration.
- `THREADFIN_CONFIG_MOUNT_DIR`: Configuration directory on the host.
- `THREADFIN_TEMP_MOUNT_DIR`: Location for IPTV cache and temporary files.
- `THREADFIN_WEB_UI_PORT`: Host port for the administration web UI.

## Directory Mounts
- `/home/threadfin/conf`: Configuration, channel list, mapping database.
- `/tmp/threadfin`: Temporary workspace for cache and EPG updates.
