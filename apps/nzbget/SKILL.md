---
name: update-nzbget
description: "Procedure for updating NZBGet Docker container."
---

# Update NZBGet

## How to update

1. Check latest linuxserver image at https://hub.docker.com/r/linuxserver/nzbget/tags
2. Update `image: ghcr.io/linuxserver/nzbget:version-vX.Y` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Config (server settings, download categories) persists in `${NZBGET_CONFIG_MOUNT_DIR}`
- Downloads persist in `${DOWNLOADS_MOUNT_DIR}`
- NZBGet auto-updates its config format on version changes
