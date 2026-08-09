---
name: update-ghost
description: "Procedure for updating Ghost CMS Docker container."
---

# Update Ghost

## How to update

1. Check latest releases at https://github.com/TryGhost/Ghost/releases
2. Update `image: ghost:X.Y.Z-alpine3.N` in `docker-compose.yml`
3. Similarly update MySQL if needed: `image: mysql:9.N.0-oraclelinux9`
4. `docker compose pull && docker compose up -d`

## Notes

- Ghost auto-runs DB migrations on startup (schema changes, data migrations)
- Content persists in `${GHOST_MOUNT_DIR}`
- For major version jumps, check the [Ghost upgrade guide](https://ghost.org/docs/update/)
- MySQL 9.x can update minor versions safely
- Always backup before upgrading: `docker exec ghost_mysql mysqldump -u root -p ghost_db > backup.sql`

## Upgrade path

Ghost supports jumping multiple versions safely — the auto-migration handles sequential migrations in order.
