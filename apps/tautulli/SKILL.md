---
name: update-tautulli
description: "Procedure for updating Tautulli Plex monitor Docker container."
---

# Update Tautulli

## How to update

1. Check latest linuxserver image at https://hub.docker.com/r/linuxserver/tautulli/tags
2. Update `image: ghcr.io/linuxserver/tautulli:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Tautulli auto-migrates its config DB on startup
- Config persists in `${TAUTULLI_CONFIG_MOUNT_DIR}`
- Verify Plex connection and monitoring data after update
