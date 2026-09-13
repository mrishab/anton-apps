---
name: update-upsnap
description: "Procedure for updating Uptime Kuma / UpSnap Docker container."
---

# Update UpSnap

## How to update

1. Check latest releases at https://github.com/seriousm4x/UpSnap/releases
2. Update `image: ghcr.io/seriousm4x/upsnap:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- UpSnap uses host networking (`network_mode: host`)
- Data (devices, settings) persists in `${UPSNAP_DATA_MOUNT_DIR}` (SQLite)
- UpSnap auto-migrates its DB on startup
- Verify device status and wake-on-LAN functionality after upgrade
