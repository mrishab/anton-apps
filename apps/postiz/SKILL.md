---
name: update-postiz
description: "Procedure for updating Postiz social media scheduler Docker container."
---

# Update Postiz

## How to update

1. Check latest releases at https://github.com/gitroomhq/postiz-app/releases
2. **Pin the version**: Replace `:latest` with an explicit version tag
3. Update `image: ghcr.io/gitroomhq/postiz-app:vX.Y.Z` in `docker-compose.yml`
4. Update Redis if needed: `redis:7.N.M`
5. `docker compose pull && docker compose up -d`

## Notes

- Postiz auto-runs DB schema migrations on startup
- Uploads persist in `${POSTIZ_UPLOAD_MOUNT_DIR}`
- Postgres (9.6) and Redis are separate services — update independently
- Check release notes for breaking changes (API changes, provider integrations)
