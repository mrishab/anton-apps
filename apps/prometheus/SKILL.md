---
name: update-prometheus
description: "Procedure for updating Prometheus + Alertmanager monitoring stack."
---

# Update Prometheus

## How to update

1. Check latest releases at:
   - Prometheus: https://github.com/prometheus/prometheus/releases
   - Alertmanager: https://github.com/prometheus/alertmanager/releases
2. Update image tags in `docker-compose.yml`:
   - `prometheus`: `prom/prometheus:vX.Y.Z`
   - `alertmanager`: `prom/alertmanager:vX.Y.Z`
3. `docker compose pull && docker compose up -d`

## Notes

- Prometheus uses local storage in `${PROMETHEUS_MOUNT_DIR}` — data persists
- Config files are in `./static/services/prometheus/`
- Alertmanager config is similarly in `./static/services/prometheus/etc/alertmanager/`
- Verify targets are still scraped and alerting rules work after upgrade
- Prometheus v2 → v3 may need config format changes — check release notes
