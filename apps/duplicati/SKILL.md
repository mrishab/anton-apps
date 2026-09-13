---
name: update-duplicati
description: "Procedure for updating Duplicati backup tool Docker container."
---

# Update Duplicati

## How to update

1. Check latest Duplicati linuxserver image at https://hub.docker.com/r/linuxserver/duplicati/tags
2. Update `image: linuxserver/duplicati:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Duplicati auto-upgrades its own config DB on version changes
- Backup config/settings persist in `${DUPLICATI_CONFIG_MOUNT_DIR}`
- Settings encryption key is `${DUPLICATI_SETTINGS_ENCRYPTION_KEY}`
- Verify backups still run after upgrade
