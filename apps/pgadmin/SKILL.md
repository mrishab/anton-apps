---
name: update-pgadmin
description: "Procedure for updating pgAdmin4 Docker container."
---

# Update pgAdmin4

## How to update

1. Check latest releases at https://www.postgresql.org/ftp/pgadmin/pgadmin4/
2. Update `image: dpage/pgadmin4:X.Y.Z` in `docker-compose.yml`
3. Update the shared Postgres helper if needed: `postgres:18.N-alpine3.NN`
4. `docker compose pull && docker compose up -d`

## Notes

- Server connection configs persist in `${PGADMIN_MOUNT_DIR}`
- The shared Postgres service is used by multiple apps — coordinate updates
- No special migration needed for pgAdmin itself
