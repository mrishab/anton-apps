# Anton Reverse Proxy

A robust and secure reverse proxy solution for managing and routing traffic to various self-hosted services running in the anton-apps ecosystem.

## Project Overview

Anton Reverse Proxy serves as the centralized gateway for all web traffic to services hosted on the Anton infrastructure. It provides SSL/TLS termination, domain-based routing, and security enhancement for multiple self-hosted applications. By centralizing these responsibilities, individual services can focus on their core functionality without implementing their own SSL or routing logic.

## Features

- **Centralized SSL Management**: Handles SSL certificates for all services using Certbot (Let's Encrypt)
- **Multi-Domain Support**: Routes traffic for multiple domains (configured as DOMAIN_1 and DOMAIN_2)
- **Automatic Certificate Renewal**: Uses Jenkins for scheduled certificate renewal
- **Secure Headers**: Implements recommended security headers for all proxied services
- **WebSocket Support**: Handles WebSocket connections for compatible services
- **Extended Timeouts**: Configurable timeout settings for services with long-running operations
- **Docker-Based**: Fully containerized for consistent deployment and easy management

## Prerequisites

Before setting up this reverse proxy, ensure you have:

- Docker and Docker Compose
- Make
- Server with public IP address
- Domain names with DNS properly configured
- Ports 80 and 443 available and forwarded to your server

## Setup Instructions

### 1. Environment Configuration

The reverse proxy uses environment variables for configuration:

```bash
cp template.env .env
```

Edit the `.env` file to configure:
- Mount directories for certificates
- Domain names
- Host IP address
- Maximum body size
- Port configurations for all services

### 2. SSL Certificate Initialization

To initialize SSL certificates for all configured services on the server:

```bash
make init-certs
```

This SSHes into the Anton server and runs `init-certs.sh`, which:
- Temporarily configures Nginx for the ACME challenge
- Generates certificates for all domains and subdomains
- Restores the reverse proxy configuration

### 3. Deployment

Deploy or update the reverse proxy by SSHing into the server and running Docker Compose directly:

```bash
docker-compose up -d
```

## Usage

The Makefile provides commands to manage certificates and subdomains:

### Certificate Management

- `make init-certs`: SSH into the server and run the full certificate initialization script (`init-certs.sh`).
- `make cert-renew`: Trigger a Certbot renewal for all certificates (runs locally via Docker Compose).
- `make subdomain-1-cert-setup SUBDOMAIN=<subdomain>`: Issue a new certificate for a subdomain under DOMAIN_1 (`cloudville.me`).
- `make subdomain-2-cert-setup SUBDOMAIN=<subdomain>`: Issue a new certificate for a subdomain under DOMAIN_2 (`rishabmanocha.com`).
- `make domain-1-cert-setup`: Issue a certificate for the root DOMAIN_1 (`cloudville.me`).
- `make domain-2-cert-setup`: Issue a certificate for the root DOMAIN_2 (`rishabmanocha.com`).
- `make setup-subdomain SUBDOMAIN=<subdomain>`: SSH into the server, issue the subdomain-1 certificate, and restart Nginx.

## Configuration Structure

The reverse proxy configuration is organized as follows:

- **docker-compose.yml**: Defines the Docker services (nginx and certbot)
- **static/etc/nginx/templates/**: Contains the Nginx server configurations
  - **domain-1-reverse-proxy.conf.template**: Configuration for the first domain
  - **domain-2-reverse-proxy.conf.template**: Configuration for the second domain
  - **default.conf.template**: HTTP to HTTPS redirection and ACME challenge handling
  - **global.conf.template**: Global Nginx settings
- **static/etc/nginx/snippets/**: Contains reusable configuration snippets
  - **ssl-params.conf**: SSL/TLS security settings
  - **header-params.conf**: HTTP header configurations
  - **websocket.conf**: WebSocket support settings
  - **timeout-params.conf**: Extended timeout settings

## Automated Maintenance

Certificate renewal is automated through Jenkins (defined in Jenkinsfile):
- Scheduled to run every 15 days
- Connects to the server via SSH
- Executes the certificate renewal process

## Adding New Services

To add a new service to the reverse proxy:

1. Add the service port to `.env`
2. Add the port mapping to `docker-compose.yml`
3. Add a server block to the appropriate domain template
4. Add the subdomain to the certificate initialization script
5. Restart the reverse proxy with `docker-compose up -d`

## Security Considerations

The reverse proxy implements several security enhancements:

- Strong SSL ciphers and protocols
- Security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
- Automatic HTTP to HTTPS redirection
- Isolation of services through subdomain separation

## License

This project is privately maintained for use within the Anton infrastructure.

## Acknowledgements

- [Nginx](https://nginx.org/)
- [Certbot](https://certbot.eff.org/)
- [Let's Encrypt](https://letsencrypt.org/)
- [Docker](https://www.docker.com/)
