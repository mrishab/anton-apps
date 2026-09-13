---
name: update-cadvisor
description: "Procedure for updating cAdvisor Docker container."
---

# Update cAdvisor

## How to update

1. Check latest release at https://github.com/google/cadvisor/releases
2. Update `image: gcr.io/cadvisor/cadvisor:vX.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Stateless — cAdvisor reads system metrics and exposes them
- No persistent DB or migration needed
- Verify at `${CADVISOR_UI_PORT}` after upgrade
