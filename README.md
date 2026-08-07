# Anton Apps Collection

A curated collection of self-hosted applications using Docker, Docker Compose, and Cloudflare DNS/Reverse Proxy.

## Architecture Overview

Traffic flow to home server applications:

```text
Internet
   │
   ▼
Cloudflare DNS + WAF (Orange Cloud Proxy)
   │ (HTTPS - Full Strict)
   ▼
Public IP (Dynamic DNS updated via apps/ddns)
   │
   ▼
Router (Ports 80 / 443)
   │
   ▼
apps/reverse-proxy (Nginx with Let's Encrypt SSL)
   │
   ▼
Local Docker Applications (apps/*)
```

- **Infrastructure as Code**: Root [/terraform](terraform/) manages Cloudflare DNS wildcard records (`*.example.com`, `*.your-second-domain.com`), SSL settings (Full Strict), and WAF rules.
- **Dynamic DNS**: [apps/ddns](apps/ddns/) runs `ddclient` to refresh Cloudflare DNS A-records with the server's public IP.
- **Reverse Proxy & SSL**: [apps/reverse-proxy](apps/reverse-proxy/) routes incoming traffic to internal application ports and handles SSL termination.

## Table of Contents

- [Media](#media)
  - [Calibre](./apps/calibre) - Comprehensive e-book manager
  - [Plex](./apps/plex) - Personal media server
  - [Jellyfin](./apps/mediaserver) - Open source media server
  - [Ombi](./apps/ombi) - Media request manager
  - [LazyLibrarian](./apps/lazylibrarian) - E-book/audiobook manager
  - [NZBGet](./apps/nzbget) - Usenet downloader
  - [Deluge](./apps/deluge) - BitTorrent client

- [Development](#development)
  - [SonarQube](./apps/sonarqube) - Code quality platform
  - [Nexus](./apps/nexus) - Repository manager
  - [Docker Registry](./apps/registry) - Private Docker registry
  - [Jupyter](./apps/jupyter) - Interactive computing environment

- [Databases and Management](#databases-and-management)
  - [pgAdmin](./apps/pgadmin) - PostgreSQL management

- [Tools](#tools)
  - [Wiki.js](./apps/wikijs) - Powerful and extensible wiki platform
  - [SFTPGo](./apps/sftpgo) - Fully featured SFTP server
  - [FreshRSS](./apps/freshrss) - RSS feed aggregator
  - [PostiZ](./apps/postiz) - Content management system

## Setup Guide

### Prerequisites

- Ansible
- Docker Engine on target host
- SSH access to target host
- Terraform (for Cloudflare DNS/WAF management)

### Installation & Deployment

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

### Infrastructure Management (Terraform)

Cloudflare DNS proxy, wildcard records, and security rules are configured in `/terraform`:

```sh
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with Cloudflare API Token, Zone IDs, and Public IP
terraform init
terraform apply
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

1. Create a new directory for your application under `apps/`:
   ```sh
   mkdir -p apps/new-app-name
   ```

2. Create the necessary files:
   - `docker-compose.yml` - Container configuration
   - `template.env` - Environment variable template
   - `README.md` - Documentation for your application

3. Test your application:
   ```sh
   cd apps/new-app-name
   cp template.env .env
   # Edit .env with appropriate values
   docker compose up -d
   ```

4. Follow the [.agents/skills/add-new-app/SKILL.md](.agents/skills/add-new-app/SKILL.md) workflow to register the application in Ansible and `apps/reverse-proxy`.

5. Submit a pull request with your changes.

### Modifying Existing Applications

1. Make your changes to the application in `apps/<app-name>`
2. Test thoroughly
3. Submit a pull request with your changes

## License

This collection is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

This collection builds upon the work of many open source projects and Docker image maintainers. See individual application directories for specific acknowledgements and references.
