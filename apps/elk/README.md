# ELK Stack (Elasticsearch, Logstash, Kibana) with Logspout

Centralized log aggregation and analysis pipeline for applications running in the Anton server ecosystem.

> [!WARNING]
> This stack is not currently deployed anywhere — it is too resource-heavy for the available servers. The configuration is preserved here for future use.

## Architecture & Interaction

```mermaid
graph TD
    subgraph "Docker Host Containers"
        App1["App Container 1"]
        App2["App Container 2"]
    end

    subgraph "ELK Pipeline"
        Sock["/var/run/docker.sock"]
        Spout["Logspout Container"]
        Stash["Logstash Container"]
        ES["Elasticsearch Container"]
        KB["Kibana Container"]
    end

    subgraph "Client"
        Browser["Web Browser (UI)"]
    end

    %% Logs collection
    App1 -->|Logs stdout/stderr| Sock
    App2 -->|Logs stdout/stderr| Sock
    Sock -->|Mounted| Spout
    
    %% Logs ingestion
    Spout -->|UDP log stream (Port 5000)| Stash
    
    %% Storage & Indexing
    Stash -->|Elasticsearch output| ES
    
    %% Visualization
    ES <-->|Query / Retrieve logs| KB
    Browser <-->|Port 5601| KB
```

## Services & Ports

1. **Elasticsearch** (`elasticsearch`)
   - **Role**: Distributed database and search engine for logs indexation and storage.
   - **Internal Ports**: `9200` (REST API), `9300` (Node communication).
   - **Volumes**: `${ELASTICSEARCH_DATA_MOUNT_DIR}` mounted to `/usr/share/elasticsearch/data`.

2. **Kibana** (`kibana`)
   - **Role**: Data visualization and analytics dashboard.
   - **Internal Ports**: `5601` (Web UI).
   - **Volumes**: `${KIBANA_DATA_MOUNT_DIR}` mounted to `/usr/share/kibana/data`.

3. **Logstash** (`logstash`)
   - **Role**: Server-side data processing pipeline that ingests logs, transforms them, and sends them to Elasticsearch.
   - **Ingestion Port**: `5000` (UDP).
   - **Volumes**: `${LOGSTASH_DATA_MOUNT_DIR}` mounted to `/usr/share/logstash/data`.

4. **Logspout** (`logspout`)
   - **Role**: Log router for Docker containers. It runs as a daemon and automatically streams stdout/stderr from all containers on the host to Logstash via UDP.
   - **Sockets**: Accesses `/var/run/docker.sock` to capture host container logs automatically.

## Setup & Configuration

1. Copy the template environment file to create your own configuration:
   ```sh
   cp template.env .env
   ```

2. Edit `.env` to specify host data mount paths and ports. Ensure that target directories have proper read/write permissions.
