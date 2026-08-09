---
name: update-epg
description: "Procedure for updating IPTV EPG Docker container."
---

# Update EPG

## How to update

1. Check latest releases at https://github.com/iptv-org/epg
2. The image currently uses `ghcr.io/iptv-org/epg:master` (rolling branch tag)
3. **Recommended**: Pin to a specific commit hash for reproducibility
4. `docker compose pull && docker compose up -d`

## Notes

- EPG data is generated based on `${EPG_CHANNELS_FILE}` (XML) and output to `${EPG_PUBLIC_MOUNT_DIR}`
- The CRON schedule is set via `${EPG_CRON_SCHEDULE}`
- Rolling `:master` tag means updates are unpredictable — pinning is preferred
