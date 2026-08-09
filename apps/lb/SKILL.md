---
name: update-lb
description: "Procedure for updating the anton-apps load balancer (nginx)."
---

# Update Load Balancer

## How to update

1. Check latest nginx stable-alpine images at https://hub.docker.com/_/nginx/tags
2. Update `image: nginx:stable-alpine-perl` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- The LB forwards requests to the anton-server backend
- Config is in `./static/etc/nginx/nginx.conf` with templates in `./static/etc/nginx/templates/`
- The LB handles reverse-proxy routing for all apps
- Use `nginx -t` to validate config before reloading
