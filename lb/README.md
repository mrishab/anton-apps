# Anton Legacy Load Balancer (LB)

This is a legacy bastion proxy/load balancer designed for the home-server Anton. It was used when local router administration access was unavailable, utilizing a tunnel to proxy TCP traffic from an external host PC to the Anton server.

## Purpose & Architecture

The load-balancer utilizes Nginx's `stream` module for Layer 4 (TCP) stream proxying. This allows it to forward TLS traffic directly at the TCP layer to the backend reverse proxy without terminating SSL, ensuring secure end-to-end encryption.

```mermaid
graph LR
    Client["Client (Browser)"]
    FriendPC["Friend's PC (Public IP / Tunnel Endpoint)"]
    AntonLB["Anton LB Container (This App)"]
    AntonRP["Anton Reverse Proxy (Main Server)"]

    Client -->|HTTPS Traffic| FriendPC
    FriendPC -->|Port Forward Tunnel| AntonLB
    AntonLB -->|Layer 4 Stream Proxy (TCP)| AntonRP
```

## How It Works

1. **HTTP Redirect (Layer 7)**:
   - Binds Nginx HTTP to redirect all incoming port `80` traffic to `HTTPS` automatically.
2. **HTTPS Stream (Layer 4)**:
   - Uses the Nginx `stream` module in `static/etc/nginx/templates/default.conf.template` to listen on `${LB_HTTPS_PORT}` and proxy raw TCP streams (`proxy_pass`) to the Anton server's reverse proxy target (`${ANTON_HOST_IP}:${ANTON_HTTPS_PORT}`).

## Configuration

- **Ports**: 
  - `80` (Redirects to HTTPS)
  - `443` (TCP Stream proxying)
- **Environment Variables**:
  - `LB_HTTP_PORT`: Port that Nginx listens to internally for HTTP.
  - `LB_HTTPS_PORT`: Port that Nginx listens to internally for HTTPS stream.
  - `ANTON_HOST_IP`: The IP address of the target Anton server.
  - `ANTON_HTTP_PORT`: HTTP port on Anton.
  - `ANTON_HTTPS_PORT`: HTTPS port on Anton.
- **Volumes**:
  - Mounts `./static/etc/nginx/nginx.conf` and template files to configure stream behaviors dynamically.
