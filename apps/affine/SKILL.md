---
name: update-affine
description: "Procedure for updating AFFiNE Docker container (self-hosted)."
---

# Update AFFiNE

## How to update

1. Check latest releases at https://github.com/toeverything/AFFiNE/releases
2. Update `${AFFINE_REVISION}` in `.env` (or pass a specific version tag)
3. The `affine_migration` container runs `node ./scripts/self-host-predeploy.js` on startup to handle DB schema migrations
4. Redeploy: `docker compose pull && docker compose up -d`

## Image reference

- Image: `ghcr.io/toeverything/affine:${AFFINE_REVISION:-stable}`
- `stable` tag tracks the latest stable release
- Pin an explicit version like `0.20.0` for reproducibility

## Notes

- AFFiNE's migration container handles schema changes automatically
- DB (Postgres) and cache (Redis) are separate services — they update independently
- Always check release notes for breaking changes before major version jumps
- After upgrading, verify the web UI loads and document sync works
