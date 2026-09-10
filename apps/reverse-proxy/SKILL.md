---
name: update-reverse-proxy
description: "Procedure for updating the reverse-proxy stack (nginx + certbot)."
---

# Update Reverse Proxy

## How to update

1. Check latest releases:
   - nginx: https://hub.docker.com/_/nginx/tags (stable-alpine-perl)
   - certbot: https://hub.docker.com/r/certbot/certbot/tags
   - nginx-exporter: https://hub.docker.com/r/nginx/nginx-prometheus-exporter/tags
2. Update image tags in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- **certbot** runs `certonly` manually to provision/renew SSL certs
- SSL certificates persist in `${CERTIFICATES_MOUNT_DIR}`
- Nginx config is in `./static/etc/nginx/templates/` — templates are rendered at startup via nginx's `envsubst`
- New subdomains require adding a server block to the template file
- After template changes, validate: `nginx -t` inside the container
- The exporter scrapes `/stub_status` for Prometheus metrics
