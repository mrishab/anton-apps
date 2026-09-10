---
name: update-hermes
description: "Procedure for updating Hermes Agent Docker container."
---

# Update Hermes

## How to update

1. Check latest releases at https://github.com/NousResearch/hermes-agent/releases
2. Update `image: nousresearch/hermes-agent:vYYYY.M.D` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- `$HERMES_HOME` (`/opt/data`) is the persistent host mount — all data survives
- The Redis cache is ephemeral (recreated on restart)
- Telegram bot token and API keys are set via env vars, updated in `.env`
- Check release notes for breaking config changes before upgrading
