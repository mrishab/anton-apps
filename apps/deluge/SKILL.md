---
name: update-deluge
description: "Procedure for updating Deluge torrent client Docker container (with VPN)."
---

# Update Deluge

## How to update

1. Check latest Deluge linuxserver image at https://hub.docker.com/r/linuxserver/deluge/tags
2. Check latest OpenVPN client image at https://github.com/dperson/openvpn-client
3. Update image tags in `docker-compose.yml`:
   - `vpn`: `ghcr.io/utkuozdemir/dperson-openvpn-client:alpine-X.Y.Z-openvpn-A.B.C`
   - `deluge`: `ghcr.io/linuxserver/deluge:X.Y.Z-lsN`
4. `docker compose pull && docker compose up -d`

## Notes

- Deluge runs in `network_mode: service:vpn` — all traffic goes through VPN
- VPN config is in `./services/deluge_vpn/vpn/vpn.conf`
- Verify VPN connects before testing Deluge web UI
- The VPN client uses the `REMOTE_USERNAME`/`REMOTE_PASSWORD` env vars
