---
name: update-n8n
description: "Procedure for updating n8n workflow automation Docker container."
---

# Update n8n

## How to update

1. Check latest releases at https://github.com/n8n-io/n8n/releases
2. Update `image: n8nio/n8n:X.Y.Z-hash` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- n8n auto-runs DB schema migrations on startup
- Workflows and credentials persist in `${N8N_MOUNT_DIR}`
- Postgres DB is separate — update independently if needed
- Check release notes for breaking changes (node API changes, credential format changes)
