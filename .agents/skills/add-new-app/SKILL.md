---
name: add-new-app
description: "Workflow for adding a new Dockerized application to the anton-apps collection. Use this skill when a user wants to create a new app directory, configure its Docker Compose and environment templates, register it in the Ansible deployment system, sync the fallback reverse proxy, and update the Cloudflared Tunnel configuration."
---

# Adding a New Application to anton-apps

This workflow guides you through adding a new application to the anton-apps project. Follow these steps in order to ensure consistency across Docker configurations, Ansible deployment variables, and Cloudflare Tunnel configs.

## Prerequisites
- Application name (e.g., `threadfin`)
- Docker image name and explicit version (NEVER use 'latest')
- Reference application for patterns (e.g., `plex` for media apps)
- Required ports and volumes

---

## Step 1: Create Application Directory Structure

Create a new directory for the app with the following files:

```bash
mkdir -p <app-name>
cd <app-name>
```

Required files:
- `docker-compose.yml` - Docker Compose configuration
- `template.env` - Environment variable template
- `.env` - Actual environment values (gitignored)

---

## Step 2: Create docker-compose.yml

Follow these patterns from reference applications:

### Required Structure:
```yaml
services:
  <app-name>:
    image: <image>:<explicit-version> # NEVER use 'latest'
    container_name: <app-name>
    restart: unless-stopped
    environment:
      # Use object format, NOT array format
      KEY: ${VARIABLE}
      PUID: ${APP_PUID}
      PGID: ${APP_PGID}
      TZ: ${HOST_TZ}
    volumes:
      - ${APP_CONFIG_MOUNT_DIR}:/path/to/config
      - ${APP_DATA_MOUNT_DIR}:/path/to/data
    ports:
      - ${APP_WEB_UI_PORT}:<container-port>
    # Optional: Add GPU support if needed
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

### Key Patterns:
1. **Explicit versions**: ALWAYS use an explicit version tag for the image (e.g., `10.10.6`). NEVER use `latest` to ensure stability and reproducibility.
2. **Environment variables**: Use `${VARIABLE}` format, never hardcode values.
3. **Naming conventions**: 
   - Use `${APP_PUID}` and `${APP_PGID}` for user/group IDs
   - Use `${HOST_TZ}` for timezone
   - Prefix app-specific vars with `<APP-NAME>_` (e.g., `THREADFIN_WEB_UI_PORT`)
4. **Environment syntax**: Use `KEY: ${VALUE}` format, NOT array format (`- KEY=VALUE`)
5. **Section order**: `restart` → `environment` → `volumes` → `ports` → `deploy`
6. **GPU support**: Add deploy section only if the app uses GPU.

---

## Step 3: Create template.env

Create a template file documenting all required environment variables:

```bash
# Global
HOST_TZ=<PUT-HOST-TZ-HERE>
APP_PUID=<PUT-APP-PUID-HERE>
APP_PGID=<PUT-APP-PGID-HERE>

# <App Name>
<APP-NAME>_WEB_UI_PORT=<PUT-<APP-NAME>-WEB-UI-PORT-HERE>
<APP-NAME>_CONFIG_MOUNT_DIR=<PUT-<APP-NAME>-CONFIG-MOUNT-DIR-HERE>
<APP-NAME>_DATA_MOUNT_DIR=<PUT-<APP-NAME>-DATA-MOUNT-DIR-HERE>
```

### Patterns:
1. Group variables: Global section first, then app-specific.
2. Use descriptive placeholder format: `<PUT-VARIABLE-NAME-HERE>`.
3. Add comments for complex values.
4. Use uppercase with underscores for variable names.

---

## Step 4: Create .env File

Create the actual environment file with real values:

```bash
# Global
HOST_TZ=America/Los_Angeles
APP_PUID=1001
APP_PGID=1001

# <App Name>
<APP-NAME>_WEB_UI_PORT=<port>
<APP-NAME>_CONFIG_MOUNT_DIR=/mnt/external_hdd/<category>/<app-name>/config
<APP-NAME>_DATA_MOUNT_DIR=/mnt/external_hdd/<category>/<app-name>/data
```

### Patterns:
1. Use absolute paths for mount directories.
2. Follow the pattern: `/mnt/external_hdd/<category>/<app-name>/<purpose>`.
3. Common categories: `mediaserver`, `duplicati`, `sonarqube`, etc.
4. The `.env` file is gitignored for security.

---

## Step 5: Register in Ansible

You MUST update the central registry to include the new app config:

### `ansible/vars/app_configs.yml`
Add the app definition under `app_configs`:
```yaml
app_configs:
  ...
  new-app-name:
    port: 1234  # The primary web port
    dirs:
      - { path: "{{ host_data_dir }}/new-app-name/config", owner: "{{ primary_owner }}", group: "{{ primary_owner }}" }
      - { path: "{{ host_data_dir }}/new-app-name/data", owner: "{{ primary_owner }}", group: "{{ primary_owner }}" }
```

### Common UID/GID Values:
- `201:201` - Media server apps (plex, threadfin, etc.)
- `1000:1000` - General apps (sonarqube, postiz, etc.)
- `1000:2234` - Apps needing backup access (ollama, open-webui, etc.)
- `2234:2234` - Duplicati
- `50000:50000` - Airflow
- `5050:5050` - PGAdmin
- `200:200` - Nexus

---

## Step 6: Update Makefile

Add the new app to the `APPS` list in the Makefile:

```makefile
APPS:=affine airflow ... <app-name> ... wikijs
```

*Note: Keep the list in alphabetical order.*

---

## Step 7: Expose Subdomain via Reverse Proxy (Legacy/Backwards Compatibility)

To keep the legacy `reverse-proxy` in sync for fallback/direct routing purposes:

### 1. Update `reverse-proxy/docker-compose.yml`
- Add the new port environment variable to the `nginx` service's `environment` section:
  ```yaml
  {SUBDOMAIN_NAME_UPPERCASE}_PORT: ${{{SUBDOMAIN_NAME_UPPERCASE}_PORT}}
  ```

### 2. Update `reverse-proxy/init-certs.sh`
- Add a certificate setup command for the new subdomain in the execution chain:
  ```bash
  make subdomain-1-cert-setup SUBDOMAIN={subdomain_name} &&\
  ```

### 3. Update `reverse-proxy/static/etc/nginx/templates/domain-1-reverse-proxy.conf.template`
- Append a new server block at the end of the file:
  ```nginx
  server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name {subdomain_name}.${DOMAIN_1};

    ssl_certificate /etc/nginx/ssl/live/{subdomain_name}.${DOMAIN_1}/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/{subdomain_name}.${DOMAIN_1}/privkey.pem;

    location / {
      proxy_pass http://${HOST_IP}:${{{SUBDOMAIN_NAME_UPPERCASE}_PORT}};
      include snippets/header-params.conf;
      include snippets/websocket.conf;
    }
  }
  ```

### 4. Update `reverse-proxy/template.env`
- Document the port environment variable at the end of the file:
  ```env
  {SUBDOMAIN_NAME_UPPERCASE}_PORT=<PUT-{SUBDOMAIN_NAME_UPPERCASE}-PORT-HERE>
  ```

### 5. Update `reverse-proxy/.env`
- Add the actual port definition:
  ```env
  {SUBDOMAIN_NAME_UPPERCASE}_PORT={port_number}
  ```

---

## Step 8: Register App in Cloudflared Tunnel (Terraform)

To expose the new application securely through the Cloudflare Tunnel:

1. Update `cloudflared/terraform/main.tf` under `locals.cloudville_apps` by adding the subdomain, port, and setting path to null (or a custom path if path-based routing is needed):
   ```hcl
   {subdomain_name} = { port = {port_number}, path = null }
   ```

2. Run Terraform check and apply the configurations:
   ```bash
   cd cloudflared/terraform
   terraform plan
   terraform apply
   ```

---

## Step 9: Verify the Setup

Run these commands to verify everything is configured correctly:

```bash
# Check docker compose syntax
cd <app-name>
docker compose config

# Verify environment variables are loaded
docker compose config | grep -i <app-name>
```

---

## Summary Checklist

- [ ] Created `<app-name>/` directory
- [ ] Created `docker-compose.yml` following patterns
- [ ] Created `template.env` with all variables documented
- [ ] Created `.env` with actual values
- [ ] Registered directory/port details in `ansible/vars/app_configs.yml`
- [ ] Updated `Makefile` or `enabled_apps` in host variables
- [ ] (Optional) Configured reverse proxy subdomain blocks and certificate requests (to keep reverse-proxy in sync)
- [ ] Registered app in `cloudflared/terraform/main.tf` and ran `terraform apply`
- [ ] Verified docker compose configuration
