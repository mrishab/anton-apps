# LazyLibrarian

## Overview
LazyLibrarian is a program to follow authors and grab metadata for all your digital reading needs. It uses multiple sources for metadata and provides integration with Calibre and other e-book tools.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Calibre (optional, for e-book management)
- Download clients (optional, for automatic downloading)

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `LAZYLIBRARIAN_PORT`: External port for accessing the LazyLibrarian web interface (default: 5299)
- `LAZYLIBRARIAN_DATA`: Path to store LazyLibrarian configuration
- `BOOKS_DIR`: Path to store downloaded e-books
- `PUID`: User ID for permissions
- `PGID`: Group ID for permissions
- `TZ`: Timezone setting

## Usage
- Access the web interface at `http://your-server-ip:LAZYLIBRARIAN_PORT`
- Configure your book providers and download clients
- Add authors you want to follow
- LazyLibrarian will search for and download books automatically

## Troubleshooting
- API connection issues might require checking your provider credentials
- For permission problems with the books directory, verify PUID/PGID settings
- If books aren't being processed correctly, check the format compatibility

## Further Resources
- [LazyLibrarian GitHub Repository](https://github.com/lazylibrarian/LazyLibrarian)
- [Return to Main Documentation](../README.md)
