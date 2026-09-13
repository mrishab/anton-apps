---
name: update-elk
description: "Procedure for updating ELK stack (Elasticsearch + Kibana + Logstash + Logspout)."
---

# Update ELK Stack

## How to update

1. Check the compatible [Elastic stack versions](https://www.elastic.co/support/matrix)
2. Update `${ELK_VERSION}` in `.env` to the desired version (e.g., `8.17.0`)
3. ELK images use `${ELK_VERSION}` env var — all three update at once
4. `docker compose pull && docker compose up -d`

## Note on major version upgrades

Elasticsearch can't skip major versions. For a major jump (e.g., 7.x → 8.x):
- Upgrade one major at a time (7.x → 8.x)
- Re-index data if needed after upgrade
- Check breaking changes in Elastic release notes

## Good to know

- Logstash is configured with a simple UDP input that forwards to ES
- Logspout uses `gliderlabs/logspout:v3.2.13` — update independently if needed
- Data persists in `${ELASTICSEARCH_DATA_MOUNT_DIR}` and `${KIBANA_DATA_MOUNT_DIR}`
