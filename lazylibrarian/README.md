# LazyLibrarian

LazyLibrarian is an automated e-book and audiobook manager. It tracks authors, finds new releases, and integrates with download clients to automatically acquire books in your preferred formats.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- A configured download client (e.g. Deluge) and indexer (e.g. Prowlarr)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker compose up -d
```

### Environment Variables
- `LAZYLIBRARIAN_WEB_UI_PORT`: Host port for the web interface (default: `5299`)
- `LAZYLIBRARIAN_CONFIG_MOUNT_DIR`: Persistent config directory (mounted to `/config`)
- `DOWNLOADS_MOUNT_DIR`: Shared downloads directory (mounted to `/downloads`)
- `EBOOKS_MOUNT_DIR`: E-book library directory (mounted to `/ebooks`)
- `AUDIOBOOKS_MOUNT_DIR`: Audiobook library directory (mounted to `/audiobooks`)
- `APP_PUID` / `APP_PGID`: Run-as user/group identity
- `HOST_TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:LAZYLIBRARIAN_WEB_UI_PORT`
- Configure your book providers (Goodreads, Google Books) and download clients
- Add authors you want to follow; LazyLibrarian will search for and download new releases automatically

## Troubleshooting
- API connection issues might require checking your provider credentials in the settings
- For permission problems with the books directory, verify `APP_PUID`/`APP_PGID` settings
- If books aren't being processed correctly, check format compatibility in LazyLibrarian settings

## Further Resources
- [LazyLibrarian GitHub Repository](https://github.com/lazylibrarian/LazyLibrarian)
- [Return to Main Documentation](../README.md)
