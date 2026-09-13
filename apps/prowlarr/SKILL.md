---
name: update-prowlarr
description: "Procedure for updating Prowlarr indexer manager Docker container."
---

# Update Prowlarr

## How to update

1. Check latest linuxserver image at https://hub.docker.com/r/linuxserver/prowlarr/tags
2. Update `image: ghcr.io/linuxserver/prowlarr:X.Y.Z-develop` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Prowlarr auto-migrates its config DB on startup
- Config persists in `${PROWLARR_CONFIG_MOUNT_DIR}`
- Verify indexer connections and *arr integrations after update
- Currently uses the `-develop` tag — switch to mainline if stable releases are preferred
