---
name: update-adguardhome
description: "Procedure for updating AdGuard Home Docker container to a new version."
---

# Update AdGuard Home

## How to update

1. Check latest release at https://github.com/AdguardTeam/AdGuardHome/releases
2. Update `image: adguard/adguardhome:vX.Y.Z` in `docker-compose.yml`
3. Pull and recreate: `docker compose pull && docker compose up -d`

## Notes

- Config persists in `${ADGUARD_CONF_MOUNT_DIR}` and work data in `${ADGUARD_WORK_MOUNT_DIR}`
- No manual DB migration needed — AdGuard Home handles upgrades in-place
- After upgrade, verify at `http://<host>:${ADGUARD_WEBUI_PORT}`
- Docker image tags follow SemVer with `v` prefix (e.g., `v0.107.71`)
