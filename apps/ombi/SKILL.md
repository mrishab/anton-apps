---
name: update-ombi
description: "Procedure for updating Ombi media request Docker container."
---

# Update Ombi

## How to update

1. Check latest linuxserver image at https://hub.docker.com/r/linuxserver/ombi/tags
2. Update `image: ghcr.io/linuxserver/ombi:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Ombi auto-migrates its config DB on startup
- Config persists in `${OMBI_CONFIG_MOUNT_DIR}`
- Verify integrations with *arr stack still work after update
