---
name: update-homarr
description: "Procedure for updating Homarr dashboard Docker container."
---

# Update Homarr

## How to update

1. Check latest releases at https://github.com/homarr-labs/homarr/releases
2. Update `image: ghcr.io/homarr-labs/homarr:vX.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Homarr auto-migrates its config/settings DB on startup
- Data persists in `${HOMARR_DATA_MOUNT_DIR}`
- Checks release notes for breaking changes in widget/service definitions
