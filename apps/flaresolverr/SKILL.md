---
name: update-flaresolverr
description: "Procedure for updating FlareSolverr proxy Docker container."
---

# Update FlareSolverr

## How to update

1. Check latest FlareSolverr image at https://github.com/FlareSolverr/FlareSolverr/releases or https://hub.docker.com/r/flaresolverr/flaresolverr/tags
2. Update `image: ghcr.io/flaresolverr/flaresolverr:vX.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- FlareSolverr is a stateless proxy used by Prowlarr to bypass Cloudflare protection
- Verify proxy health at `http://<host>:${FLARESOLVERR_PORT}`
- Ensure Prowlarr indexer proxy tags remain matched after updates
