---
name: update-wikijs
description: "Procedure for updating Wiki.js Docker container."
---

# Update Wiki.js

## How to update

1. Check latest releases at https://github.com/Requarks/wiki/releases
2. Update `image: requarks/wiki:2` in `docker-compose.yml` — pin to an explicit version like `2.N.M`
3. `docker compose pull && docker compose up -d`

## Notes

- Wiki.js auto-runs DB schema migrations on startup
- Content and config are stored in the Postgres DB
- File uploads are stored in the DB or on disk depending on configuration
- Check release notes for breaking changes (markdown engine changes, auth config changes)
- The `:2` tag tracks the latest 2.x release
