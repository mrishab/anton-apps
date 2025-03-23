# SFTPGo

## Overview
SFTPGo is a fully featured and highly configurable SFTP server with optional FTP/S and WebDAV support. This Docker setup provides a secure file transfer solution for your infrastructure.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Understanding of SFTP/SSH security principles

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `SFTPGO_PORT`: External port for accessing the SFTPGo web admin interface (default: 8080)
- `SFTP_PORT`: Port for SFTP connections (default: 2222)
- `SFTPGO_DATA`: Path to store SFTPGo data and configuration
- `ADMIN_USERNAME`: Admin user for the web interface
- `ADMIN_PASSWORD`: Admin password for the web interface

## Usage
- Access the web admin interface at `http://your-server-ip:SFTPGO_PORT`
- Create users and virtual folders through the web interface
- Connect to the SFTP server using your preferred SFTP client

## Troubleshooting
- For permission issues, check the ownership and permissions of mounted directories
- Connection problems may be related to firewall rules or SSH key configurations
- Review logs with `docker-compose logs sftpgo` for detailed error information

## Further Resources
- [Official SFTPGo Documentation](https://github.com/drakkan/sftpgo/blob/main/docs/README.md)
- [Return to Main Documentation](../README.md)
