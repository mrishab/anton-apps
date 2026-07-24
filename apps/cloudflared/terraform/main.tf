# ─────────────────────────────────────────────────────────────────────────────
# Cloudflare Tunnel — "Anton Apps"
#
# Creates a remotely-managed tunnel and configures ingress rules that replace
# the local Nginx reverse-proxy. Each subdomain routes HTTP traffic directly
# to the origin service on the Docker bridge gateway (172.17.0.1).
#
# NOTE: The Jenkins agent/slave port (50000) is TCP, not HTTP. Cloudflare
# Tunnel public hostname ingress only handles HTTP(S). If Jenkins agents need
# external connectivity, consider Cloudflare WARP or a direct port forward.
# ─────────────────────────────────────────────────────────────────────────────


# ─────────────────────────────────────────────────────────────────────────────
# Backend
# ─────────────────────────────────────────────────────────────────────────────

terraform {
  backend "s3" {
    bucket  = "cloudville-state"
    key     = "anton-apps/cloudlfare.tfstate"
    region  = "ca-central-1"
    profile = "mrishab"
    encrypt = true
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# Tunnel
# ─────────────────────────────────────────────────────────────────────────────

resource "random_id" "tunnel_secret" {
  byte_length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = var.cloudflare_account_id
  name       = var.tunnel_name
  secret     = random_id.tunnel_secret.b64_std
  config_src = "cloudflare"
}

# ─────────────────────────────────────────────────────────────────────────────
# Application Definitions
#
# Derived from the Nginx reverse-proxy templates:
#   - domain-1-reverse-proxy.conf.template  (cloudville.me)
#   - domain-2-reverse-proxy.conf.template  (rishabmanocha.com)
#
# connect_timeout is set for apps that previously used timeout-params.conf
# (proxy_read_timeout / proxy_connect_timeout = 1800s → 30m).
#
# Websocket support is handled natively by Cloudflare Tunnel — no special
# origin_request config is needed for apps that previously included
# websocket.conf.
# ─────────────────────────────────────────────────────────────────────────────

locals {
  # Domain 1 (cloudville.me) application routes
  # subdomain → { port, connect_timeout (optional) }
  cloudville_apps = {
    adguardhome   = { port = 3000, path = null }
    affine        = { port = 3010, path = null }
    airflow       = { port = 2364, path = null }
    bazarr        = { port = 6767, path = null }
    bentopdf      = { port = 8085, path = null }
    calibre       = { port = 8081, path = null }
    calibre-web   = { port = 8083, path = null }
    deluge        = { port = 8112, path = null }
    duplicati     = { port = 8200, path = null }
    epg           = { port = 30000, path = null }
    ghost         = { port = 2368, path = null }
    grafana       = { port = 3000, path = null }
    hermes        = { port = 9119, path = null }
    homarr        = { port = 7575, path = null }
    immich        = { port = 2283, path = null }
    jellyfin      = { port = 8096, path = null }
    jenkins       = { port = 8888, path = null }
    jupyter       = { port = 2705, path = null }
    kibana        = { port = 5601, path = null }
    lazylibrarian = { port = 5299, path = null }
    lidarr        = { port = 8686, path = null }
    n8n           = { port = 5678, path = null }
    nextcloud     = { port = 8765, path = null }
    nexus         = { port = 4634, path = null }
    nzbget        = { port = 6789, path = null }
    ollama        = { port = 11434, path = null }
    ombi          = { port = 3579, path = null }
    open-webui    = { port = 11435, path = null }
    ovpn          = { port = 8386, path = null }
    pgadmin       = { port = 3487, path = null }
    plex          = { port = 32400, path = null }
    postiz        = { port = 5000, path = null }
    prowlarr      = { port = 9696, path = null }
    radarr        = { port = 7878, path = null }
    registry      = { port = 5000, path = null }
    rss           = { port = 4523, path = null }
    sftpgo        = { port = 9393, path = null }
    sonarr        = { port = 8989, path = null }
    sonarqube     = { port = 3124, path = null }
    stirlingpdf   = { port = 8086, path = null }
    tautulli      = { port = 8181, path = null }
    threadfin     = { port = 34400, path = null }
    upsnap        = { port = 8090, path = null }
    vscode        = { port = 2342, path = null }
    wikijs        = { port = 3123, path = null }
  }

  # Build a flat list of all ingress rules for the tunnel config
  ingress_rules = concat(
    # Domain 1 — cloudville.me subdomains
    [for subdomain, app in local.cloudville_apps : {
      hostname        = "${subdomain}.${var.cloudville_domain}"
      service         = "http://${var.origin_ip}:${app.port}"
      connect_timeout = try(app.connect_timeout, null)
      path            = try(app.path, null)
    }],
    # Domain 2 — rishabmanocha.com
    [
      # Forbidden path /ghost on @ root domain
      {
        hostname        = var.rishabmanocha_domain
        path            = "/ghost.*"
        service         = "http_status:403"
        connect_timeout = null
      },
      # Root domain routing (excluding /ghost as it matched above)
      {
        hostname        = var.rishabmanocha_domain
        path            = null
        service         = "http://${var.origin_ip}:2368"
        connect_timeout = null
      }
    ]
  )
}

# ─────────────────────────────────────────────────────────────────────────────
# Tunnel Configuration (Published Application Routes / Ingress Rules)
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id

  config {
    warp_routing {
      enabled = true
    }

    # Application ingress rules — one per subdomain
    dynamic "ingress_rule" {
      for_each = local.ingress_rules
      content {
        hostname = ingress_rule.value.hostname
        path     = ingress_rule.value.path
        service  = ingress_rule.value.service

        dynamic "origin_request" {
          for_each = ingress_rule.value.connect_timeout != null ? [1] : []
          content {
            connect_timeout = ingress_rule.value.connect_timeout
          }
        }
      }
    }

    # Catch-all rule (required — must be the last ingress rule)
    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "cloudflare_zero_trust_tunnel_route" "home_network" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
  network    = "192.168.1.0/24"
  comment    = "Private network route for home LAN (replaces DockOVPN)"
}
