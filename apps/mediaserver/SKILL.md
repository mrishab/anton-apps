---
name: update-mediaserver
description: "Procedure for updating the media server stack (Sonarr + Radarr + Lidarr + Bazarr)."
---

# Update Media Server

This stack uses four linuxserver images — each can be updated independently.

## How to update

1. Check latest tags at linuxserver Docker Hub:
   - Sonarr: https://hub.docker.com/r/linuxserver/sonarr/tags
   - Radarr: https://hub.docker.com/r/linuxserver/radarr/tags
   - Lidarr: https://hub.docker.com/r/linuxserver/lidarr/tags
   - Bazarr: https://hub.docker.com/r/linuxserver/bazarr/tags
2. Update the relevant `image:` tags in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Tag conventions

- Sonarr: `ghcr.io/linuxserver/sonarr:X.Y.Z.N-lsNNN`
- Radarr: `ghcr.io/linuxserver/radarr:X.Y.Z.NNNNN-lsNNN`
- Lidarr: `ghcr.io/linuxserver/lidarr:X.Y.Z`
- Bazarr: `ghcr.io/linuxserver/bazarr:X.Y.Z`

## Notes

- Each app auto-migrates its own config DB on startup
- Config dirs are independent (Sonarr → `${SONARR_CONFIG_MOUNT_DIR}`, etc.)
- All connect to shared media mounts (`${MEDIA_TV_MOUNT_DIR}`, `${MEDIA_MOVIES_MOUNT_DIR}`, etc.)
- Verify *arr integrations still work (download client, indexer connections) after update
