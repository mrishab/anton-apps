# ─────────────────────────────────────────────────────────────────────────────
# Authentication
# ─────────────────────────────────────────────────────────────────────────────

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token (requires Zone:DNS:Edit and Zone:Zone:Edit permissions)"
  type        = string
  sensitive   = true
}

# ─────────────────────────────────────────────────────────────────────────────
# Zones
# ─────────────────────────────────────────────────────────────────────────────

variable "cloudville_zone_id" {
  description = "Cloudflare zone ID for primary (cloudville) domain"
  type        = string
}

variable "rishabmanocha_zone_id" {
  description = "Cloudflare zone ID for personal domain"
  type        = string
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
  description = "Secondary domain (blog/personal site)"
  type        = string
  default     = "<your-personal-domain>"
}

# ─────────────────────────────────────────────────────────────────────────────
# Origin Server Network Configuration
# ─────────────────────────────────────────────────────────────────────────────

variable "server_public_ip" {
  description = "Public IP address of origin server (Anton) used for DNS A records"
  type        = string
  default     = "<your-server-public-ip>"
}

# ─────────────────────────────────────────────────────────────────────────────
# Security & SSL
# ─────────────────────────────────────────────────────────────────────────────

variable "ssl_mode" {
  description = "Cloudflare SSL/TLS mode (strict, full, flexible)"
  type        = string
  default     = "strict"
}

variable "allowed_countries" {
  description = "List of allowed country codes for WAF geo-blocking (customize for your region)"
  type        = list(string)
  default     = ["US", "CA", "IN", "GB"]
}
