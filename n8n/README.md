# n8n Workflow Automation

n8n is an extendable workflow automation tool that enables you to connect various APIs and services without writing code.

## Architecture & Interaction

```mermaid
graph TD
    subgraph "Clients"
        User["Web Browser"]
    end

    subgraph "Docker Stack"
        n8nApp["n8n App Container"]
        n8nDB["n8n Postgres Database"]
        Init["db-init-scripts/init.sh"]
    end

    subgraph "Volumes & State"
        AppVol["N8N_MOUNT_DIR"]
        DBVol["PG_MOUNT_DIR"]
    end

    %% Routing
    User -->|Port 5678| n8nApp
    n8nApp -->|Postgres client (Port 5432)| n8nDB
    
    %% Storage
    AppVol -.->|Mounted to /home/node/.n8n| n8nApp
    DBVol -.->|Mounted to /var/lib/postgresql/data| n8nDB
    
    %% DB Init
    Init -.->|Initializes user & database on first run| n8nDB
```

## Services & Ports

1. **n8n** (`n8n`)
   - **Role**: Core orchestration engine and Node-based visual editor.
   - **Ports**: Exposes the Web UI via `N8N_UI_PORT` (typically 5678).
   - **Database Connection**: Configured to connect to the postgres container using credentials configured in `.env`.
   - **Volume**: `${N8N_MOUNT_DIR}` mounted to `/home/node/.n8n` for settings and static files.

2. **postgres** (`n8n_postgres`)
   - **Role**: Database backend storing active workflows, execution logs, credentials, and settings.
   - **Ports**: None exposed publicly (secured inside Docker container network).
   - **Database Initialization**: `./db-init-scripts/init.sh` is loaded on startup to dynamically create the n8n database, user, and privileges.
   - **Volume**: `${PG_MOUNT_DIR}` mounted to `/var/lib/postgresql/data` for persistent database files.

## Setup Instructions

1. Copy the template configuration file:
   ```sh
   cp template.env .env
   ```
2. Configure credentials, database names, and host path mounts in `.env`.
3. Start the stack:
   ```sh
   docker compose up -d
   ```
