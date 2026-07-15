# Cloudflared Tunnel

This service runs Cloudflare Tunnel to expose local applications to the internet securely.

## Configuration

1. Retrieve/generate a tunnel token from the Cloudflare Zero Trust dashboard.
2. Put the token in the `.env` file under `CLOUDFLARED_TUNNEL_TOKEN`.
3. Start the service.
