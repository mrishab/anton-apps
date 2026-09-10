---
name: update-airflow
description: "Procedure for updating Apache Airflow Docker deployment."
---

# Update Apache Airflow

## ⚠️ Important: Airflow requires sequential major version upgrades

Airflow does NOT support skipping major versions. You must upgrade through each major version sequentially (e.g., 2.3 → 2.4 → 2.5 → ...).

## How to update

1. Check the [Airflow release notes](https://github.com/apache/airflow/releases) for breaking changes
2. If jumping multiple major versions, upgrade one major at a time:
   - Update `image: apache/airflow:X.Y.Z` in `docker-compose.yml`
   - `docker compose pull && docker compose up -d`
   - Verify the webserver starts correctly
   - Proceed to next version
3. The `airflow_setup` container runs `airflow db upgrade` automatically on each start
4. After all version upgrades, verify DAGs load and the webserver is accessible

## Pipeline

The compose has three services:
- `airflow_setup` — one-shot DB migration container (runs `airflow db upgrade`)
- `airflow_webserver` — the web UI
- `airflow_scheduler` — the task scheduler

All share the same image tag.

## Notes

- Always backup the Postgres DB before upgrading: `pg_dump -U <user> <db> > backup.sql`
- Check for deprecated config options in new versions (Airflow prints warnings at startup)
- Postgres 9.6 is very old (EOL) — consider upgrading the DB separately
