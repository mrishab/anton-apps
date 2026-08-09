---
name: update-grafana
description: "Procedure for updating Grafana Docker container."
---

# Update Grafana

## How to update

1. Check latest releases at https://github.com/grafana/grafana/releases
2. Update `image: grafana/grafana:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Grafana auto-upgrades its SQLite DB schema on startup
- Dashboards, datasources, and config persist in `${GRAFANA_MOUNT_DIR}`
- For major version jumps, check the [Grafana upgrade guide](https://grafana.com/docs/grafana/latest/setup-grafana/upgrade-grafana/)
- Current image is very old (8.0.5) — upgrading to 13.x may need multi-step migration
