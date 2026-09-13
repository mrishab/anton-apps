---
name: update-open-webui
description: "Procedure for updating Open WebUI Docker container."
---

# Update Open WebUI

## How to update

1. Check latest releases at https://github.com/open-webui/open-webui/releases
2. Update `image: ghcr.io/open-webui/open-webui:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- User data (chats, settings, config) persists in `${OPEN_WEBUI_MOUNT_DIR}`
- Open WebUI auto-migrates its SQLite DB on startup
- The `OLLAMA_BASE_URL` env var links to the Ollama instance
- Verify all models are still accessible after upgrade
