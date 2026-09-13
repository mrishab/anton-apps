---
name: update-threadfin
description: "Procedure for updating Threadfin IPTV proxy Docker container."
---

# Update Threadfin

## How to update

1. Check latest releases at https://github.com/Threadfin/Threadfin/releases
2. Update `image: fyb3roptik/threadfin:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Threadfin auto-migrates its config on startup
- Config persists in `${THREADFIN_CONFIG_MOUNT_DIR}`; temp in `${THREADFIN_TEMP_MOUNT_DIR}`
- GPU (NVIDIA) support is configured for hardware transcoding
- Verify IPTV streams and channel mappings after upgrade
