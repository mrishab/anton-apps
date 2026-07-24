# Prometheus and Alertmanager

Centralized systems monitoring and alerting platform running on the Orion server, scraping metrics from both the Anton and Orion hosts.

## Architecture & Monitoring Flow

```mermaid
graph TD
    subgraph "Scrape Targets (Docker Hosts)"
        NodeAnton["Node Exporter (Anton Host)"]
        NodeOrion["Node Exporter (Orion Host)"]
        cAdvisorAnton["cAdvisor (Anton Host)"]
        cAdvisorOrion["cAdvisor (Orion Host)"]
        NginxExp["Nginx Prometheus Exporter"]
    end

    subgraph "Monitoring Stack"
        Prom["Prometheus Container"]
        AlertM["Alertmanager Container"]
        Rules["Alert Rules Files"]
    end

    subgraph "Notification Outputs"
        Slack["Slack Channels (#server-health)"]
    end

    %% Scraping
    Prom -->|HTTP pull /metrics| NodeAnton
    Prom -->|HTTP pull /metrics| NodeOrion
    Prom -->|HTTP pull /metrics| cAdvisorAnton
    Prom -->|HTTP pull /metrics| cAdvisorOrion
    Prom -->|HTTP pull /metrics| NginxExp

    %% Evaluation
    Rules -.->|Evaluated by| Prom
    
    %% Alerting
    Prom -->|Sends alerts (Port 9093)| AlertM
    
    %% Notifications
    AlertM -->|Webhook Notification| Slack
```

## Services & Ports

1. **Prometheus** (`prometheus`)
   - **Role**: Scrapes metrics at regular intervals from defined endpoints, evaluates rule expressions, displays results, and triggers alerts.
   - **Internal Ports**: `9090` (Web UI & API).
   - **Volumes**:
     - `./static/services/prometheus/etc/prometheus` mounted to `/etc/prometheus` (containing configurations and rule files).
     - `${PROMETHEUS_MOUNT_DIR}` mounted to `/prometheus` (stores metrics time-series data).

2. **Alertmanager** (`alertmanager`)
   - **Role**: Handles alerts sent by Prometheus. It deduplicates, groups, and routes them to the correct receiver integration (such as Slack, email, PagerDuty).
   - **Internal Ports**: `9093` (Web UI & API).
   - **Volumes**:
     - `./static/services/prometheus/etc/alertmanager` mounted to `/etc/alertmanager`.
     - `./alertmanager-data` mounted to `/alertmanager` (active alert state storage, used by `--storage.path=/alertmanager`).
     - `${ALERTMANAGER_MOUNT_DIR}` mounted to `/prometheus` (additional host-side backup mount).

## Configuration

### Scraper Targets (`prometheus.yml`)
Configured to scrape metrics from:
- Prometheus itself (`host.docker.internal:9090`)
- Node Exporters (exposes host metrics such as CPU/Memory/Disk) on both Anton (`192.168.1.67:9100`) and Orion (`host.docker.internal:9100`)
- cAdvisors (exposes container metrics) on both Anton (`192.168.1.67:8383`) and Orion (`host.docker.internal:8383`)
- Nginx Exporter (exposes web server connection metrics from Anton at `192.168.1.67:9113`)

### Alerts Rules (`rules/`)
Evaluates rule configurations:
- `node_rules.yml` — CPU, Memory, and Disk usage thresholds
- `nginx_rules.yml` — Nginx performance metrics
- `app_rules.yml` — Custom application-specific health checks

### Alert Destinations (`alertmanager.yml`)
Configured to push real-time alerts directly to a designated Slack incoming webhook (`#server-health` channel) with rich color-coded formatting representing status changes.
