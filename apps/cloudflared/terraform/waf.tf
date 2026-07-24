# ─────────────────────────────────────────────────────────────────────────────
# WAF (Web Application Firewall) Custom Rules
#
# Configures geo-blocking on the domains to only allow traffic from:
#   - Allowed countries defined in var.allowed_countries
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_ruleset" "cloudville_geo_blocking" {
  zone_id     = var.cloudville_zone_id
  name        = "Geo-blocking and Bot Blocking Rule"
  description = "Block traffic not originating from allowed countries and block indexing/crawling/AI bots"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    description = "Only allow traffic from allowed countries"
    enabled     = true
    expression  = "not ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.allowed_countries))}}"
  }

  rules {
    action      = "block"
    description = "Block indexing, crawling, AI, bots"
    enabled     = true
    expression  = "(cf.client.bot) or (cf.verified_bot_category in {\"AI Crawler\" \"Search Engine Crawler\" \"Aggregator\"}) or (lower(http.user_agent) contains \"bot\") or (lower(http.user_agent) contains \"crawl\") or (lower(http.user_agent) contains \"spider\") or (lower(http.user_agent) contains \"index\")"
  }
}



