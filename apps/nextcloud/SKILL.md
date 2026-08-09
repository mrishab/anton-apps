---
name: update-nextcloud
description: "Procedure for updating Nextcloud Docker container."
---

# Update Nextcloud

## ⚠️ Critical: Nextcloud requires sequential major version upgrades

You **cannot** skip major versions. You must upgrade through each major version step:
- e.g., 27 → 28 → 29 → 30 → 31 → 32 (or whatever the path is)
- Check the [Nextcloud upgrade guide](https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html) for the current upgrade path

## How to update

1. **Check the version path** at https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html
2. For the custom image, rebuild:
   - Update `ARG NC_VERSION` or equivalent in the `Dockerfile`
   - Rebuild: `docker compose build`
   - Or pull the upstream image and rebuild: `docker compose build --pull`
3. `docker compose up -d`
4. Run the upgrade: `docker exec nextcloud occ upgrade`
5. Verify: check the admin panel for status warnings

## Notes

- This deployment uses a custom Dockerfile (builds on top of `nextcloud:32.0-apache`)
- Apps may need updating after upgrade: `docker exec nextcloud occ app:update --all`
- Postgres (9.6) is very old — consider migrating to a newer version
- Always backup before upgrading:
  ```
  docker exec nextcloud_postgres pg_dump -U <user> <db> > nextcloud_backup.sql
  docker exec nextcloud occ maintenance:mode --on
  ```
