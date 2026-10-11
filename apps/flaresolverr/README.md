# FlareSolverr

FlareSolverr is a proxy server designed to bypass Cloudflare and DDoS-GUARD anti-bot protections. It acts as an intermediary for indexer managers such as Prowlarr and Jackett, solving JavaScript challenges and CAPTCHAs so that search requests can succeed.

## Overview

This deployment provides:
- FlareSolverr proxy service running headless Chromium/Firefox
- Integration endpoint for Prowlarr indexers experiencing Cloudflare blocks
- Configurable logging and CAPTCHA solver settings

## Configuration

### Environment Variables

Copy `template.env` to `.env`:

```sh
cp template.env .env
```

Edit the `.env` file with your configuration:

```env
# Global
HOST_TZ=America/Los_Angeles
APP_PUID=1001
APP_PGID=1001

# FlareSolverr
FLARESOLVERR_PORT=8191
FLARESOLVERR_LOG_LEVEL=info
FLARESOLVERR_LOG_HTML=false
FLARESOLVERR_CAPTCHA_SOLVER=none
```

### Key Settings

- `FLARESOLVERR_PORT`: Host port where the FlareSolverr API is exposed (default: `8191`).
- `FLARESOLVERR_LOG_LEVEL`: Log verbosity level (`info`, `debug`, `verbose`, `warn`, `error`).
- `FLARESOLVERR_LOG_HTML`: Set to `true` to print incoming/outgoing HTML in logs for debugging.
- `FLARESOLVERR_CAPTCHA_SOLVER`: Integration with external CAPTCHA solving services if needed (`none`, `hcaptcha`, etc.).

## Usage

### Starting the Application

```sh
# From the flaresolverr directory
docker compose up -d

# Or from the root directory
make start APPS="flaresolverr"
```

### Testing the Service

Verify FlareSolverr is running by sending a GET request to the root endpoint:

```sh
curl http://localhost:8191/
```

Expected response:
```json
{"msg":"FlareSolverr is ready!","version":"v3.5.2","userAgent":"..."}
```

## Integrating with Prowlarr

To configure Prowlarr to route requests through FlareSolverr:

1. Open the **Prowlarr** web interface (`http://your-server-ip:9696`).
2. Navigate to **Settings** > **Indexers**.
3. Under **Indexer Proxies**, click the **+** (Add) button.
4. Select **FlareSolverr**.
5. Configure the proxy settings:
   - **Name**: `FlareSolverr`
   - **Host**: `http://172.17.0.1:8191` (or your Docker host IP)
   - **Request Timeout**: `60` (or `120` if indexers have slower challenges)
   - **Tags**: `flaresolverr` (or any custom tag)
6. Save the proxy.
7. Edit any indexer that fails with Cloudflare protection errors, and add the `flaresolverr` tag to its configuration.
8. Test the indexer to verify connectivity.

> **Security & Network Architecture Note**: FlareSolverr is an internal indexer proxy service. It is omitted from UFW firewall opening (`ports: []` in `ansible/vars/app_configs.yml`), omitted from reverse proxy mappings, and omitted from Cloudflare Tunnels, preventing any inbound access from the public internet. Containerized indexer managers (such as Prowlarr) communicate with FlareSolverr across the Docker bridge gateway at `http://172.17.0.1:8191`.

