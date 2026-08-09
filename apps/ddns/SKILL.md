---
name: update-ddns
description: "Procedure for updating DDNS (ddclient) Docker container."
---

# Update DDNS

## How to update

1. Check latest ddclient image tags at https://hub.docker.com/r/linuxserver/ddclient/tags
2. Update `image: ghcr.io/linuxserver/ddclient:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Config is mounted from `./static/config/cloudflare.conf` — no changes needed on update
- DDNS provider limits (Cloudflare API calls) are the only constraint
- Verify DNS records update correctly after upgrade
