# ─────────────────────────────────────────────────────────────────────────────
# Authentication
# ─────────────────────────────────────────────────────────────────────────────

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token (requires Account:Cloudflare Tunnel:Edit and Zone:DNS:Edit permissions)"
  type        = string
  sensitive   = true
}

# ─────────────────────────────────────────────────────────────────────────────
# Zones
# ─────────────────────────────────────────────────────────────────────────────

variable "cloudville_zone_id" {
  description = "Cloudflare zone ID for the primary domain"
  type        = string
}

variable "rishabmanocha_zone_id" {
  description = "Cloudflare zone ID for the secondary domain"
  type        = string
}

# ─────────────────────────────────────────────────────────────────────────────
# Tunnel
# ─────────────────────────────────────────────────────────────────────────────

variable "tunnel_name" {
  description = "Name of the Cloudflare Tunnel"
  type        = string
  default     = "Anton Apps"
}

variable "origin_ip" {
  description = "Origin IP address that cloudflared uses to reach local services (Docker bridge gateway)"
  type        = string
  default     = "172.17.0.1"
}

# ─────────────────────────────────────────────────────────────────────────────
# Domains
# ─────────────────────────────────────────────────────────────────────────────

variable "cloudville_domain" {
  description = "Primary domain for homelab apps"
  type        = string
  default     = "<your-cloudville-domain>"
}

variable "rishabmanocha_domain" {
  description = "Secondary domain (personal site, blog, and apps)"
  type        = string
  default     = "<your-personal-domain>"
}

variable "github_pages_target" {
  description = "Target hostname for GitHub Pages custom domain (e.g. username.github.io)"
  type        = string
  default     = "mrishab.github.io"
}

# ─────────────────────────────────────────────────────────────────────────────
# WAF
# ─────────────────────────────────────────────────────────────────────────────

variable "allowed_countries" {
  description = "List of allowed country codes"
  type        = list(string)
  default     = ["US", "CA", "IN"]
}

