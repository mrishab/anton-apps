# Vikunja

Self-hosted to-do / kanban / project management (AGPL-3.0).

- **Image:** `vikunja/vikunja:2.5.0`
- **Web UI:** port `${VIKUNJA_WEB_PORT}` (3456)
- **Data:** `${VIKUNJA_DB_MOUNT_DIR}` (sqlite at `/db`) + `${VIKUNJA_FILES_MOUNT_DIR}` (`/app/vikunja/files`)

Set `VIKUNJA_PUBLIC_URL` in `.env`.
