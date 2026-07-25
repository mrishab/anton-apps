# ─────────────────────────────────────────────────────────────────────────────
# Cloudflare Direct Reverse Proxy Architecture
#
# Configures Cloudflare as DNS resolver and first-line defense (Orange Cloud).
# Traffic is proxied directly to the home server's public IP address.
# TLS termination is performed on the origin server (Traefik / Nginx) using
# Cloudflare Full (Strict) SSL mode.
# ─────────────────────────────────────────────────────────────────────────────

terraform {
  backend "s3" {
    bucket  = "cloudville-state"
    key     = "anton-apps/cloudflare-proxy.tfstate"
    region  = "ca-central-1"
    profile = "mrishab"
    encrypt = true
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# SSL/TLS Configuration — Full (Strict) Mode
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_zone_settings_override" "cloudville" {
  zone_id = var.cloudville_zone_id

  settings {
    ssl = var.ssl_mode
  }
}

resource "cloudflare_zone_settings_override" "rishabmanocha" {
  zone_id = var.rishabmanocha_zone_id

  settings {
    ssl = var.ssl_mode
  }
}
