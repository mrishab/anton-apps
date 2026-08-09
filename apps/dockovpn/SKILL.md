---
name: update-dockovpn
description: "Procedure for updating Dockovpn (OpenVPN) Docker container."
---

# Update Dockovpn

## How to update

1. Check latest release at https://github.com/dockovpn/dockovpn/releases
2. Update `image: alekslitvinenk/openvpn:vX.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Client configs are generated fresh on each start — existing `.ovpn` files may need re-export
- VPN data (generated certs/configs) persists in `${OVPN_MOUNT_DIR}`
- The `HOST_ADDR` env var must match the public IP/DNS clients use to connect
