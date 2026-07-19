# Anton Apps Collection

A curated collection of self-hosted applications using Docker and Docker Compose.

## Overview

This repository contains a collection of Dockerized applications, each residing in its own directory. These applications cover a wide range of use cases, from media management to development tools.

## Table of Contents

- [Media](#media)
  - [Calibre](./calibre) - Comprehensive e-book manager
  - [Plex](./plex) - Personal media server
  - [Jellyfin](./mediaserver) - Open source media server
  - [Ombi](./ombi) - Media request manager
  - [LazyLibrarian](./lazylibrarian) - E-book/audiobook manager
  - [NZBGet](./nzbget) - Usenet downloader
  - [Deluge](./deluge) - BitTorrent client

- [Development](#development)
  - [SonarQube](./sonarqube) - Code quality platform
  - [Nexus](./nexus) - Repository manager
  - [Docker Registry](./registry) - Private Docker registry
  - [Jupyter](./jupyter) - Interactive computing environment

- [Databases and Management](#databases-and-management)
  - [pgAdmin](./pgadmin) - PostgreSQL management

- [Tools](#tools)
  - [Wiki.js](./wikijs) - Powerful and extensible wiki platform
  - [SFTPGo](./sftpgo) - Fully featured SFTP server
  - [FreshRSS](./freshrss) - RSS feed aggregator
  - [PostiZ](./postiz) - Content management system

## Setup Guide

### Prerequisites

- Ansible
- Docker Engine on target host
- SSH access to target host

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/anton-apps.git
   cd anton-apps
   ```

2. Configure Ansible:
   - Edit `ansible/inventories/<TARGET_NAME>.ini` to match your target hosts.
   - Install required Ansible collections:
     ```sh
     ansible-galaxy collection install -r ansible/requirements.yml
     ```

3. Deploy applications:
   - To deploy all applications:
     ```sh
     make deploy
     ```
   - To deploy specific applications:
     ```sh
     make deploy APPS=nextcloud,plex
     ```

### Using the Makefile

The repository includes a Makefile to simplify common operations:

- `make deploy` - Deploy all applications (creates directories, uploads files, manages .env, restarts)
- `make deploy APPS=name` - Deploy specific applications
- `make dry-run` - Preview changes without applying (check mode with diff)
- `make stop APPS=name` - Stop specific applications
- `make start APPS=name` - Start specific applications
- `make restart APPS=name` - Restart specific applications
- `make ping` - Test connectivity to hosts
- `make check-nvidia` - Check NVIDIA GPU status on hosts

All targets support `LIMIT=hostname` to target specific hosts.


## Contributing

Contributions to this collection are welcome! Here's how you can contribute:

### Adding a New Application

1. Create a new directory for your application:
   ```sh
   mkdir -p new-app-name
   ```

2. Create the necessary files:
   - `docker-compose.yml` - Container configuration
   - `template.env` - Environment variable template
   - `README.md` - Documentation for your application

3. Test your application:
   ```sh
   cd new-app-name
   cp template.env .env
   # Edit .env with appropriate values
   docker compose up -d
   ```

4. Submit a pull request with your changes.

### Modifying Existing Applications

1. Make your changes to the application
2. Test thoroughly
3. Submit a pull request with your changes

## Disabled Applications

The following applications have been disabled/moved out of the default active deployment list:

### 1. Dynamic DNS Client (`ddns`)
- **Reason**: All domain routing and DNS records have migrated to Cloudflare Tunnels (which dynamically handle CNAME mapping directly under Cloudflare's dashboard), rendering a local DDNS A-record updater container unnecessary.
- **How to enable back**: Add `ddns` back to the `enabled_apps` list in your host variables (e.g., [anton.yml](file:///Users/rishabmanocha/SourceCode/anton-apps/ansible/host_vars/anton.yml)) and run:
  ```sh
  make deploy APPS=ddns
  ```

### 2. Reverse Proxy (`reverse-proxy`)
- **Reason**: Remote SSL/TLS termination and subdomain routing are now natively managed by the Cloudflare Zero Trust Tunnel. The local Nginx reverse-proxy and automated Certbot certificate setups are no longer required to route incoming traffic.
- **How to enable back**: Add `reverse-proxy` back to the `enabled_apps` list in your host variables (e.g., [anton.yml](file:///Users/rishabmanocha/SourceCode/anton-apps/ansible/host_vars/anton.yml)) and run:
  ```sh
  make deploy APPS=reverse-proxy
  ```

### 3. OpenVPN (`dockovpn`)
- **Reason**: Replaced by Cloudflare Zero Trust / WARP private network routing (`192.168.1.0/24`). This provides secure remote access to local resources without exposing open VPN ports (such as UDP `1194` or TCP `8386`) to the public internet.
- **How to enable back**: Add `dockovpn` back to the `enabled_apps` list in your host variables (e.g., [anton.yml](file:///Users/rishabmanocha/SourceCode/anton-apps/ansible/host_vars/anton.yml)) and run:
  ```sh
  make deploy APPS=dockovpn
  ```

## License

This collection is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

This collection builds upon the work of many open source projects and Docker image maintainers. See individual application directories for specific acknowledgements and references.
