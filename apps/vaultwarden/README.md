# Vaultwarden

Self-hosted Bitwarden-compatible password manager (GPL-3.0).

- **Image:** `vaultwarden/server:1.37.1`
- **Web UI:** port `${VAULTWARDEN_WEB_PORT}`
- **Data:** `${VAULTWARDEN_DATA_MOUNT_DIR}` (mounted at `/data`)

Set `VAULTWARDEN_DOMAIN`, `VAULTWARDEN_ADMIN_TOKEN` (enables the admin panel) and `VAULTWARDEN_SIGNUPS_ALLOWED=false` in `.env`.
