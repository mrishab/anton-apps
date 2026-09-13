---
name: update-immich
description: "Procedure for updating Immich photo management Docker deployment."
---

# Update Immich

## ⚠️ Important: Read the release notes before every update

Immich is under active development and releases often include breaking changes. Always check the [official upgrade guide](https://github.com/immich-app/immich/releases) before upgrading.

## How to update

1. **Read the release notes** at https://github.com/immich-app/immich/releases for breaking changes
2. Update `${IMMICH_VERSION}` in `.env` (e.g., `v1.130.0`). Default is `release`.
3. `docker compose pull && docker compose up -d`

## Notes

- Immich auto-runs DB schema migrations on server startup
- Microservices (machine-learning) are updated independently via the same version tag
- Redis and Postgres (pgvecto-rs) are separate services — update independently
- If sticking with `:release` tag, a simple pull is sufficient
- Postgres uses `pgvecto-rs` extension — verify compatibility on major version bumps
- Always backup DB before upgrading: `docker exec immich_postgres pg_dump -U <user> <db> > backup.sql`
