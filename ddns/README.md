# Anton Dynamic DNS Client

This is a Dynamic DNS Client setup for a home-server called Anton. The application uses Docker containers to run DDNS clients that automatically update DNS records when your home IP address changes.

## Table of Contents

- [Anton Dynamic DNS Client](#anton-dynamic-dns-client)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Setup Instructions](#setup-instructions)
    - [Environment Configuration](#environment-configuration)
    - [DDNS Configuration Files](#ddns-configuration-files)
  - [Makefile Commands](#makefile-commands)
  - [Docker Compose Configuration](#docker-compose-configuration)
  - [Deployment Workflow](#deployment-workflow)
  - [Best Practices](#best-practices)

## Introduction

This application manages Dynamic DNS configurations for multiple domains (cloudville.me, mrishab.io and rishabmanocha.com) using Docker containers. It allows a home server to maintain up-to-date DNS records that point to its public IP address, even when that address changes.

## Setup Instructions

### Environment Configuration

1. Copy the template environment file to create your own configuration:
   ```sh
   cp template.env .env
   ```

2. Edit the `.env` file with your specific values:
   ```
   DDNS_PUID=1000  # User ID for the container
   DDNS_PGID=1000  # Group ID for the container
   HOST_TZ=America/Los_Angeles  # Your local timezone
   ```

   You can find your PUID and PGID by running `id` on your host system.

### DDNS Configuration Files

1. Create the configuration directory:
   ```sh
   mkdir -p static/config
   ```

2. Create a configuration file for each domain:

   For cloudville.me:
   ```sh
   cp static/config/cloudville.me.conf static/config/cloudville.me.conf.example
   ```
   
   For mrishab.io, create a similar configuration file based on the cloudville.me example:
   ```sh
   touch static/config/mrishab.io.conf
   ```

   For rishabmanocha.com, create a similar configuration file based on the cloudville.me example:
   ```sh
   touch static/config/rishabmanocha.com.conf
   ```

3. Edit each configuration file with your DDNS provider details. For example, with NameCheap:
   ```
   use=web, web=dynamicdns.park-your-domain.com/getip
   protocol=namecheap
   server=dynamicdns.park-your-domain.com
   login=yourdomain.com
   password=your-namecheap-ddns-password
   *, @
   ```

## Makefile Commands

The project includes a Makefile with several useful commands:

| Command | Description |
|---------|-------------|
| `make start` | Starts the DDNS containers using Docker Compose |
| `make stop` | Stops the running DDNS containers |
| `make remove` | Removes the stopped containers |
| `make restart` | Restarts the DDNS containers (equivalent to `stop` followed by `start`) |
| `make clean` | Stops and removes the containers (equivalent to `stop` followed by `remove`) |
| `make pack` | Prepares the application for deployment by copying necessary files to the distribution directory |
| `make upload` | Uploads the packed application to the remote server |
| `make deploy` | Runs the reset command on the remote server |
| `make setup` | Complete deployment workflow (pack + upload + deploy) |
| `make reset` | Cleans and starts the application (used primarily on the remote server) |

## Docker Compose Configuration

The application uses Docker Compose to run two separate DDNS client containers:

1. **ddclient_cloudville**: Updates DNS records for cloudville.me
2. **ddclient_mrishab**: Updates DNS records for mrishab.io
3. **ddclient_rishabmanocha**: Updates DNS records for rishabmanocha.com

Each container:
- Uses the `ghcr.io/linuxserver/ddclient` image
- Is configured with environment variables from the `.env` file
- Maps a specific configuration file to `/config/ddclient.conf` inside the container
- Is set to restart automatically unless stopped manually

## Deployment Workflow

To deploy the application to a remote server:

1. Ensure all configuration files are properly set up
2. Make sure you can SSH into the remote server using public key authentication
3. Set the `USERNAME` environment variable for the SSH connection:
   ```sh
   export USERNAME=your-username
   ```
4. Run the setup command:
   ```sh
   make setup
   ```

This will:
- Pack all necessary files into the `dist` directory
- Upload them to the specified server at the path `/var/server/anton-ddns`
- Execute the `reset` command on the remote server, which restarts the containers

## Best Practices

1. **Never commit sensitive information**: The repository is configured to ignore:
   - `.env` files containing environment variables
   - `static` directory containing DDNS configuration with passwords
   - `.vscode` directory with editor-specific settings
   - `dist` directory used for building deployment packages

2. **Keep backups of your configuration**: Store encrypted backups of your DDNS configuration files in a secure location.

3. **Regularly check logs**: Monitor the containers' logs to ensure they're updating correctly:
   ```sh
   docker logs ddclient_cloudville
   docker logs ddclient_mrishab
   docker logs ddclient_rishabmanocha
   ```

4. **Update the containers**: Periodically update the container images to get the latest security patches:
   ```sh
   docker-compose pull
   make restart
   ```