---
name: update-jellyfin
description: "Procedure for updating Jellyfin media server Docker container."
---

# Update Jellyfin

## How to update

1. Check latest releases at https://github.com/jellyfin/jellyfin/releases
2. Update `image: jellyfin/jellyfin:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Jellyfin auto-migrates its DB on startup
- Config and cache persist in `${JELLYFIN_CONFIG_MOUNT_DIR}` / `${JELLYFIN_CACHE_MOUNT_DIR}`
- Media libraries are read-only mounts — no migration needed
- GPU (NVIDIA) pass-through is configured via `deploy.resources.reservations.devices`
- Verify hardware transcoding still works after update
