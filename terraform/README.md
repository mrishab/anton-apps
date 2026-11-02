# Anton Apps — Cloudflare Reverse Proxy & Wildcard DNS Terraform Setup

This Terraform module sets up Cloudflare as a traditional reverse proxy (Orange Cloud) and DNS resolver for `<your-cloudville-domain>` and `<your-personal-domain>`.

## Architecture Overview

```text
Internet
   │
   ▼
Cloudflare DNS + WAF (Orange Cloud Proxy)
   │ (HTTPS - Full Strict)
   ▼
Home Server Public IP (Dynamic DNS updated via ddclient)
   │
   ▼
Router (Port 80 / 443 forwarded)
   │
   ▼
Reverse Proxy (Traefik / Nginx / Caddy with Let's Encrypt TLS)
   │
   ▼
Local Docker Applications
```

### Key Components

1. **DNS Architecture**:
   - Primary domain (`<your-cloudville-domain>`): Wildcard `*` and root `@` point to home server public IP via Cloudflare Orange Cloud proxy.
   - Secondary domain (`<your-personal-domain>`): Root `@`, `www`, and `apps` CNAME point to GitHub Pages (`<username>.github.io`, DNS-only `proxied = false`). Subdomain `blog.<your-personal-domain>` points to home server public IP (`proxied = true`) and is updated by dynamic DNS (`ddclient`).
2. **Full (Strict) SSL/TLS**:
   - SSL mode is explicitly set to `strict`.
   - Your local reverse proxy (Traefik/Nginx) terminates TLS using Let's Encrypt certificates (e.g. via DNS-01 challenge or HTTP-01 challenge).
3. **Web Application Firewall (WAF)**:
   - Rulesets limit inbound traffic to allowed country codes (`US`, `CA`, `IN`) and block malicious crawlers/AI bots.

## Getting Started

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Populate `terraform.tfvars` with your Cloudflare API Token, Account ID, Zone IDs, and origin server public IP.

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Preview and apply changes:
   ```bash
   terraform plan
   terraform apply
   ```
