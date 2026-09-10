---
name: update-bentopdf
description: "Procedure for updating BentoPDF Docker container."
---

# Update BentoPDF

## How to update

1. Check latest release at https://github.com/fal-ai/bento-pdf or Docker Hub
2. Update `image: bentopdf/bentopdf:vX.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- No DB or special migration needed
- Config is in `${BENTOPDF_CONFIG_MOUNT_DIR}`
- Verify the web UI loads after upgrade
