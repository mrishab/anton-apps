---
name: update-cloudflared
description: "Procedure for updating Cloudflare Tunnel (cloudflared) Docker container."
---

# Update Cloudflare Tunnel

## How to update

1. Check latest release at https://github.com/cloudflare/cloudflared/releases
2. Update `image: cloudflare/cloudflared:YYYY.M.d` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- The tunnel runs with `--no-autoupdate` flag — updates are manual only
- Tunnel token is set via `${CLOUDFLARED_TUNNEL_TOKEN}` env var
- After upgrade, verify the tunnel connects: check Cloudflare Zero Trust dashboard
- Tags follow `YYYY.M.d` date-based versioning
