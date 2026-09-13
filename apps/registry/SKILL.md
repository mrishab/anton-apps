---
name: update-registry
description: "Procedure for updating Docker Registry container."
---

# Update Docker Registry

## How to update

1. Check latest registry image tags at https://hub.docker.com/_/registry/tags
2. **Pin the version**: Replace `image: registry:2` with an explicit version (e.g., `registry:2.8.3`)
3. Update the tag in `docker-compose.yml`
4. `docker compose pull && docker compose up -d`

## Notes

- Registry data (stored images) persists in `${REGISTRY_MOUNT_DIR}`
- No migration needed for minor/patch updates
- The `registry:2` tag tracks the latest 2.x release
