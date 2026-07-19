# ─────────────────────────────────────────────────────────────────────────────
# WAF (Web Application Firewall) Custom Rules
#
# Configures geo-blocking on the domains to only allow traffic from:
#   - Allowed countries defined in var.allowed_countries
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_ruleset" "cloudville_geo_blocking" {
  zone_id     = var.cloudville_zone_id
  name        = "Geo-blocking Rule"
  description = "Block traffic not originating from allowed countries"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    description = "Only allow traffic from allowed countries"
    enabled     = true
    expression  = "not ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.allowed_countries))}}"
  }
}

resource "cloudflare_ruleset" "rishabmanocha_geo_blocking" {
  zone_id     = var.rishabmanocha_zone_id
  name        = "Geo-blocking Rule"
  description = "Block traffic not originating from allowed countries"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    description = "Only allow traffic from allowed countries"
    enabled     = true
    expression  = "not ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.allowed_countries))}}"
  }
}

