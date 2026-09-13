---
name: update-freshrss
description: "Procedure for updating FreshRSS Docker container."
---

# Update FreshRSS

## How to update

1. Check latest FreshRSS linuxserver image at https://hub.docker.com/r/linuxserver/freshrss/tags
2. Update `image: ghcr.io/linuxserver/freshrss:version-X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- FreshRSS auto-applies schema migrations on startup
- The app and Postgres DB update independently
- RSS feed data is in the Postgres DB (mounted at `${PG_MOUNT_DIR}`)
- Config persists in `${FRESHRSS_MOUNT_DIR}`
