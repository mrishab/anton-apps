# BentoPDF

BentoPDF is a self-hosted web reader and organizer designed for reading and managing PDF documents.

## Features
- **Web-Based Reader**: Read PDF books directly in your web browser.
- **Book Organization**: Organize your PDF database inside a modern interface.
- **Lightweight**: Simple container footprints and fast startup times.

## Ports & Configuration
- **Port**: `BENTOPDF_WEB_UI_PORT` (default: `8085`).
- **Environment Variables**:
  - `APP_PUID`/`APP_PGID`: Container ownership parameters.
  - `HOST_TZ`: Host timezone configuration.
- **Directory Mounts**:
  - `${BENTOPDF_CONFIG_MOUNT_DIR}` → `/config` — PDF database and system configurations.
  - `${BENTOPDF_DATA_MOUNT_DIR}` → `/data` — Location of the PDF documents to be read/imported.
