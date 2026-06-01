# Grafana

Grafana is a multi-platform open-source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources (such as Prometheus, Elasticsearch, InfluxDB, etc.).

## Features
- **Visualizations**: Modern, fast, and highly customizable dashboards.
- **Data Sources**: Queries Prometheus, Elasticsearch, InfluxDB, and other supported backends for metrics and logs.
- **Alerting**: Define and evaluate alert rules directly within Grafana dashboards.

## Configuration & Ports

- **Port**: `3000` (exposes web interface)
- **Environment Variables**:
  - `GF_SECURITY_ADMIN_USER`: Set via `GRAFANA_ADMIN_USER` in `.env`
  - `GF_SECURITY_ADMIN_PASSWORD`: Set via `GRAFANA_ADMIN_PASSWORD` in `.env`
  - `GF_USERS_ALLOW_SIGN_UP`: Disabled by default (`false`)
- **Volumes**:
  - `${GRAFANA_MOUNT_DIR}` mounted to `/var/lib/grafana` (requires permissions for container user UID/GID `472`)

## Usage

1. Initialize configuration:
   ```sh
   cp template.env .env
   ```
2. Set your custom admin user credentials and mount directory path in the `.env` file.
3. Once running, access the Grafana interface at `http://<your-server-ip>:3000` (or via reverse-proxy at `https://grafana.cloudville.me`).
