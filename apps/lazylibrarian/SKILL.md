---
name: update-lazylibrarian
description: "Procedure for updating LazyLibrarian Docker container."
---

# Update LazyLibrarian

## How to update

1. Check latest linuxserver image at https://hub.docker.com/r/linuxserver/lazylibrarian/tags
2. Update `image: ghcr.io/linuxserver/lazylibrarian:version-hash` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Config persists in `${LAZYLIBRARIAN_CONFIG_MOUNT_DIR}`
- linuxserver images handle internal upgrades automatically
- Verify books/audiobooks are still accessible after update
