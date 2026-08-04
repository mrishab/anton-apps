# MinIO

Self-hosted S3-compatible object storage (AGPL-3.0). Used for build artifacts, logs and backups.

- **Image:** `minio/minio:RELEASE.2025-10-15T17-29-55Z`
- **API port:** `${MINIO_API_PORT}` (9000) · **Console port:** `${MINIO_CONSOLE_PORT}` (9001)
- **Data:** `${MINIO_DATA_MOUNT_DIR}` (`/data`)

Set `MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD` in `.env` (a strong, unique root password).
