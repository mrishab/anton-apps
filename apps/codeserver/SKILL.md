---
name: update-codeserver
description: "Procedure for updating code-server (VS Code in browser) Docker container."
---

# Update code-server

## How to update

1. Check latest release at https://github.com/coder/code-server/releases
2. Update `image: codercom/code-server:X.Y.Z-N` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- User extensions and config persist in `${CODESERVER_MOUNT_DIR}`
- No special migration needed
- Tags follow `X.Y.Z-N` format (e.g., `4.118.0-39`)
