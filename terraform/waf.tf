# ─────────────────────────────────────────────────────────────────────────────
# WAF (Web Application Firewall) Custom Rules
#
# Configures Cloudflare WAF rulesets for both domains:
#   - cloudville.me: Highly restricted zone for internal/homelab audience.
#     Aggressive blockings for non-allowed countries, bots, AI scrapers,
#     automated tools, security scanners, and threat score triggers.
#   - rishabmanocha.com: Public SEO site. Restrictions are removed and SEO
#     crawlers are explicitly allowed and prioritized for global discovery.
# ─────────────────────────────────────────────────────────────────────────────

# ═════════════════════════════════════════════════════════════════════════════
# cloudville.me — Restricted Homelab Environment (Aggressive Security)
# ═════════════════════════════════════════════════════════════════════════════

resource "cloudflare_ruleset" "cloudville_geo_blocking" {
  zone_id     = var.cloudville_zone_id
  name        = "Cloudville Aggressive Restricted Security Rules"
  description = "Block traffic not originating from allowed countries, block all crawlers/bots/AI, block automated tools and scanners, block threat traffic."
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  # Rule 1: Strict Geo-blocking
  rules {
    action      = "block"
    description = "Only allow traffic from allowed countries"
    enabled     = true
    expression  = "(not ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.allowed_countries))}}) and not (http.request.uri.path contains \"/.well-known/acme-challenge/\")"
  }

  # Rule 2: Aggressive Bot, Crawler, Indexer & AI Scraper Blocking
  rules {
    action      = "block"
    description = "Block indexing, crawling, AI, search engines, and scrapers"
    enabled     = true
    expression  = "((cf.client.bot) or (cf.verified_bot_category in {\"AI Crawler\" \"Search Engine Crawler\" \"Aggregator\"}) or (lower(http.user_agent) contains \"bot\") or (lower(http.user_agent) contains \"crawl\") or (lower(http.user_agent) contains \"spider\") or (lower(http.user_agent) contains \"index\") or (lower(http.user_agent) contains \"slurp\") or (lower(http.user_agent) contains \"scraper\")) and not (http.request.uri.path contains \"/.well-known/acme-challenge/\")"
  }

  # Rule 3: Block Automated Tools, Scripts & Headless Clients
  rules {
    action      = "block"
    description = "Block automated HTTP clients, CLI tools, and headless browsers"
    enabled     = true
    expression  = "((http.user_agent eq \"\") or (lower(http.user_agent) contains \"curl\") or (lower(http.user_agent) contains \"python\") or (lower(http.user_agent) contains \"wget\") or (lower(http.user_agent) contains \"postman\") or (lower(http.user_agent) contains \"go-http-client\") or (lower(http.user_agent) contains \"httpclient\") or (lower(http.user_agent) contains \"libwww\") or (lower(http.user_agent) contains \"headless\") or (lower(http.user_agent) contains \"puppeteer\") or (lower(http.user_agent) contains \"selenium\") or (lower(http.user_agent) contains \"phantomjs\")) and not (http.request.uri.path contains \"/.well-known/acme-challenge/\")"
  }

  # Rule 4: Threat Score & Anonymizer Protection
  rules {
    action      = "block"
    description = "Block high threat score traffic"
    enabled     = true
    expression  = "(cf.threat_score > 0) and not (http.request.uri.path contains \"/.well-known/acme-challenge/\")"
  }

  # Rule 5: Scanner & Exploitation Payload Blocking
  rules {
    action      = "block"
    description = "Block common vulnerability scanners and exploit attempts"
    enabled     = true
    expression  = "((lower(http.user_agent) contains \"nmap\") or (lower(http.user_agent) contains \"nikto\") or (lower(http.user_agent) contains \"sqlmap\") or (lower(http.user_agent) contains \"dirbuster\") or (lower(http.user_agent) contains \"gobuster\") or (lower(http.user_agent) contains \"wpscan\") or (http.request.uri.path contains \"../\")) and not (http.request.uri.path contains \"/.well-known/acme-challenge/\")"
  }
}

# ═════════════════════════════════════════════════════════════════════════════
# rishabmanocha.com — Public SEO & Discoverable Portfolio/Blog Site
# ═════════════════════════════════════════════════════════════════════════════

resource "cloudflare_ruleset" "rishabmanocha_geo_blocking" {
  zone_id     = var.rishabmanocha_zone_id
  name        = "Rishabmanocha Public SEO Optimization Rules"
  description = "Unrestricted public access with explicit encouragement for search engine crawlers and SEO discovery"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  # Rule 1: Allow & Skip Firewall Checks for Verified Search Engine Crawlers (SEO Boost)
  rules {
    action      = "skip"
    description = "Allow and prioritize verified search engine crawlers for SEO indexing"
    enabled     = true
    expression  = "(cf.verified_bot_category == \"Search Engine Crawler\")"
    logging {
      enabled = true
    }
    action_parameters {
      ruleset = "current"
    }
  }
}
