# cAdvisor (Container Advisor)

cAdvisor provides container users an understanding of the resource usage and performance characteristics of their running containers. It is a running daemon that collects, aggregates, processes, and exports information about running containers.

## Features
- **Resource Monitoring**: Tracks CPU, memory, network, and disk usage for all containers on the host.
- **Web UI**: Offers a simple built-in web interface to view live resource usage charts.
- **Prometheus Metrics**: Exposes a `/metrics` endpoint compatible with Prometheus for metrics collection.

## Architecture

cAdvisor runs as a single container on the target host. It requires read-only access to various system paths (`/`, `/sys`, `/var/lib/docker`) and read-write access to `/var/run` to query Docker engine statistics.

## Configuration & Port

- **Port**: `8383` (host port bound to container port `8080`; controlled by `CADVISOR_UI_PORT` in `.env`)
- **Volumes**:
  - `/:/rootfs:ro`
  - `/var/run:/var/run:rw`
  - `/sys:/sys:ro`
  - `/var/lib/docker/:/var/lib/docker:ro`
  - `/dev/disk/:/dev/disk:ro`
- **Devices**:
  - `/dev/kmsg:/dev/kmsg` (for kernel log monitoring)
