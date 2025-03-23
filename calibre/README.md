# Calibre

## Overview
Calibre is a powerful and easy-to-use e-book manager. This Docker setup provides a web-based interface for your Calibre library, allowing you to manage, read, and organize your e-books.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Sufficient disk space for your e-book collection

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `CALIBRE_PORT`: External port for accessing the Calibre web interface (default: 8083)
- `CALIBRE_DATA`: Path to store your Calibre library data

## Usage
- Access the web interface at `http://your-server-ip:CALIBRE_PORT`
- Upload e-books via the web interface
- Organize your e-book collection with tags, authors, and series

## Troubleshooting
- If you encounter permission issues, check that the host directories have the correct permissions
- For connection issues, verify that the configured port is not blocked by a firewall

## Further Resources
- [Official Calibre Documentation](https://calibre-ebook.com/help)
- [Return to Main Documentation](../README.md)
