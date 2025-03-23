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

- Docker Engine (19.03.0+)
- Docker Compose (1.27.0+)
- Git
- Make (optional, but recommended)

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/anton-apps.git
   cd anton-apps
   ```

2. Configure the applications:
   - For each application you want to use, go to its directory and copy the template.env file:
     ```sh
     cd app-name
     cp template.env .env
     ```
   - Edit the .env file to set your preferred configuration values.

3. Start the applications:
   - To start a specific application:
     ```sh
     make start app=app-name
     ```
   - To start all applications:
     ```sh
     make start-all
     ```

### Using the Makefile

The repository includes a Makefile to simplify common operations:

- `make start app=app-name` - Start a specific application
- `make stop app=app-name` - Stop a specific application
- `make restart app=app-name` - Restart a specific application
- `make logs app=app-name` - View logs for a specific application
- `make start-all` - Start all applications
- `make stop-all` - Stop all applications

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
   docker-compose up -d
   ```

4. Submit a pull request with your changes.

### Modifying Existing Applications

1. Make your changes to the application
2. Test thoroughly
3. Submit a pull request with your changes

## License

This collection is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

This collection builds upon the work of many open source projects and Docker image maintainers. See individual application directories for specific acknowledgements and references.
