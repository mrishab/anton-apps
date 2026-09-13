---
name: update-plex
description: "Procedure for updating Plex Media Server Docker container."
---

# Update Plex

## How to update

1. Check latest releases at https://github.com/plexinc/pms-docker/releases or https://www.plex.tv/media-server-downloads/
2. Update `image: plexinc/pms-docker:X.Y.Z.N-hash` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Plex auto-migrates its metadata DB on startup
- Config and metadata persist in `${PLEX_CONFIG_MOUNT_DIR}`
- Transcode cache in `${PLEX_TRANSCODE_MOUNT_DIR}` (ephemeral)
- GPU (NVIDIA) HW transcoding is configured via `deploy.resources.reservations.devices`
- Verify hardware transcoding and remote access after update
- Plex Pass updates are available immediately; free tier updates may lag
