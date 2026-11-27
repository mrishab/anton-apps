# Anton Dynamic DNS Client

This application manages Dynamic DNS configurations using `ddclient` running in Docker. It periodically refreshes Cloudflare DNS A-records with the server's public IP address, allowing homelab services and subdomains to stay reachable even when your ISP reassigns your IP.

## Architecture

```mermaid
graph TD
    subgraph "Docker Host (Anton)"
        C1["ddclient_cloudflare"]
        F1["static/config/cloudflare.conf"]
    end

    subgraph "Cloudflare DNS (Managed)"
        P1["Primary Domain (<your-domain>)<br/>@, *, ovpn -> Origin IP"]
        P2["Secondary Domain (<your-personal-domain>)<br/>blog, * -> Origin IP<br/>@, www, apps -> GitHub Pages"]
    end

    F1 -.->|Mounted to /config/ddclient.conf| C1
    C1 -->|Cloudflare API (HTTPS)| P1
    C1 -->|Cloudflare API (HTTPS)| P2
```

### DNS Layout

- **Primary Domain (`<your-cloudville-domain>`)**: The apex (`@`), wildcard (`*`), and specific subdomains (e.g. `ovpn`) point to Anton's public IP.
- **Secondary Domain (`<your-personal-domain>`)**:
  - Apex (`@`), `www`, and `apps` point to GitHub Pages (`<username>.github.io`, DNS-only / `proxied = false`).
  - Subdomain `blog.<your-personal-domain>` and wildcard `*.<your-personal-domain>` point to Anton's public IP (`proxied = true`) and are maintained by `ddclient`.
  - The apex domain and GitHub Pages subdomains (such as `www` and `apps`) are deliberately **omitted** from `cloudflare.conf` so `ddclient` does not overwrite the GitHub Pages CNAME.

## Setup Instructions

### Environment Configuration

1. Copy the template environment file to create your own configuration:
   ```sh
   cp template.env .env
   ```

2. Edit the `.env` file with your specific values:
   ```env
   DDNS_PUID=1000  # User ID for the container
   DDNS_PGID=1000  # Group ID for the container
   HOST_TZ=America/Los_Angeles  # Your local timezone
   ```

### DDNS Configuration File

1. Copy the template configuration file:
   ```sh
   cp static/config/cloudflare.conf.template static/config/cloudflare.conf
   ```

2. Edit `static/config/cloudflare.conf` with your Cloudflare API token and domains:
   ```ini
   protocol=cloudflare
   zone=example.com
   ttl=1
   login=token
   password=your-cloudflare-api-token
   example.com,*.example.com,ovpn.example.com

   protocol=cloudflare
   zone=personal.com
   ttl=1
   login=token
   password=your-cloudflare-api-token
   blog.personal.com,*.personal.com
   ```

## Docker Compose Configuration

The application uses Docker Compose to run the `ddclient_cloudflare` container:
- Image: `ghcr.io/linuxserver/ddclient:4.0.0`
- Config mount: `./static/config/cloudflare.conf:/config/ddclient.conf`
- Automatically restarts unless manually stopped.