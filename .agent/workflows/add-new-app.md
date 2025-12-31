---
description: Add a new application to the anton-apps project
---

# Adding a New Application to anton-apps

This workflow guides you through adding a new application to the anton-apps project. Follow these steps in order.

## Prerequisites
- Application name (e.g., `threadfin`)
- Docker image name and explicit version (NEVER use 'latest')
- Reference application for patterns (e.g., `plex` for media apps)
- Required ports and volumes

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

## Step 2: Create docker-compose.yml

Follow these patterns from reference applications (e.g., plex):

### Required Structure:
```yaml
version: '3'

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
              count: 1
              capabilities: [gpu]
```

### Key Patterns:
1. **Explicit versions**: ALWAYS use an explicit version tag for the image (e.g., `10.10.6`). NEVER use `latest` to ensure stability and reproducibility.
2. **Environment variables**: Use `${VARIABLE}` format, never hardcode values
2. **Naming conventions**: 
   - Use `${APP_PUID}` and `${APP_PGID}` for user/group IDs
   - Use `${HOST_TZ}` for timezone
   - Prefix app-specific vars with `<APP-NAME>_` (e.g., `THREADFIN_WEB_UI_PORT`)
3. **Environment syntax**: Use `KEY: ${VALUE}` format, NOT array format (`- KEY=VALUE`)
4. **Section order**: `restart` → `environment` → `volumes` → `ports` → `deploy`
5. **GPU support**: Add deploy section only if the app uses GPU

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
1. Group variables: Global section first, then app-specific
2. Use descriptive placeholder format: `<PUT-VARIABLE-NAME-HERE>`
3. Add comments for complex values (e.g., "# Use /dev/shm on linux to use RAM instead of disk")
4. Use uppercase with underscores for variable names

## Step 4: Create .env File

Create the actual environment file with real values:

```bash
cat > .env << 'EOF'
# Global
HOST_TZ=America/Los_Angeles
APP_PUID=1001
APP_PGID=1001

# <App Name>
<APP-NAME>_WEB_UI_PORT=<port>
<APP-NAME>_CONFIG_MOUNT_DIR=/mnt/external_hdd/<category>/<app-name>/config
<APP-NAME>_DATA_MOUNT_DIR=/mnt/external_hdd/<category>/<app-name>/data
EOF
```

### Patterns:
1. Use absolute paths for mount directories
2. Follow the pattern: `/mnt/external_hdd/<category>/<app-name>/<purpose>`
3. Common categories: `mediaserver`, `duplicati`, `sonarqube`, etc.
4. The `.env` file is gitignored for security

## Step 5: Update script.sh

Add folder creation commands to `script.sh` in the appropriate section:

### For Media Server Apps:
```bash
## <App Name>
mkdir -p $HOST_DIR/mediaserver/<app-name>/config
mkdir -p $HOST_DIR/mediaserver/<app-name>/data

# Note: chown command is already at the end of mediaserver section
# chown -R 201:201 $HOST_DIR/mediaserver/
```

### For Standalone Apps:
```bash
# <App Name>
mkdir -p $HOST_DIR/<app-name>/config
mkdir -p $HOST_DIR/<app-name>/data
chown -R <uid>:<gid> $HOST_DIR/<app-name>
```

### Patterns:
1. Add comment header: `## <App Name>` or `# <App Name>`
2. Create all required directories with `mkdir -p`
3. Do NOT add `rm -rf` commands (removed from pattern)
4. For mediaserver apps, rely on the existing `chown -R 201:201 $HOST_DIR/mediaserver/` at the end
5. For standalone apps, add specific `chown` command with appropriate UID/GID

### Common UID/GID Values:
- `201:201` - Media server apps (plex, threadfin, etc.)
- `1000:1000` - General apps (sonarqube, postiz, etc.)
- `1000:2234` - Apps needing backup access (ollama, open-webui, etc.)
- `2234:2234` - Duplicati
- `50000:50000` - Airflow
- `5050:5050` - PGAdmin
- `200:200` - Nexus

## Step 6: Update Makefile

Add the new app to the `APPS` list in the Makefile:

```makefile
APPS:=affine airflow ... <app-name> ... wikijs
```

### Patterns:
1. Add app name in alphabetical order
2. Use lowercase, hyphenated names
3. Space-separated list on a single line

## Step 7: Verify the Setup

Run these commands to verify everything is configured correctly:

```bash
# Check docker-compose syntax
cd <app-name>
docker-compose config

# Verify environment variables are loaded
docker-compose config | grep -i <app-name>

# Test folder creation (on target system)
# Run the relevant section from script.sh
```

## Summary Checklist

- [ ] Created `<app-name>/` directory
- [ ] Created `docker-compose.yml` following patterns
- [ ] Created `template.env` with all variables documented
- [ ] Created `.env` with actual values
- [ ] Updated `script.sh` with folder creation commands
- [ ] Updated `Makefile` APPS list
- [ ] Verified docker-compose configuration
- [ ] Tested on target system (optional)

## Common Patterns Reference

### Environment Variable Naming:
- Global: `HOST_TZ`, `APP_PUID`, `APP_PGID`
- App-specific: `<APP>_WEB_UI_PORT`, `<APP>_CONFIG_MOUNT_DIR`, `<APP>_<PURPOSE>_MOUNT_DIR`

### Directory Structure:
- Media apps: `/mnt/external_hdd/mediaserver/<app-name>/{config,data,temp}`
- Standalone: `/mnt/external_hdd/<app-name>/{config,data,db}`

### Docker Compose Sections Order:
1. `image`
2. `container_name`
3. `restart`
4. `environment`
5. `volumes`
6. `ports`
7. `deploy` (optional, for GPU)

### File Permissions:
- Media server apps: `201:201`
- Most other apps: `1000:1000` or `1000:2234`
- Check existing apps for specific requirements
