# ─────────────────────────────────────────────────────────────────────────────
# DNS Records
#
# Configures Cloudflare DNS records for both domains:
#   - Wildcard A records (*.domain) and Root A records (@) with proxied = true
#   - www CNAME records with proxied = true
#   - MX records for Namecheap email forwarding
#   - TXT records for SPF / Mailgun
# ─────────────────────────────────────────────────────────────────────────────

locals {
  # MX records shared by both domains (Namecheap email forwarding)
  mx_records = {
    mx1 = { priority = 10, server = "eforward1.registrar-servers.com" }
    mx2 = { priority = 10, server = "eforward2.registrar-servers.com" }
    mx3 = { priority = 10, server = "eforward3.registrar-servers.com" }
    mx4 = { priority = 15, server = "eforward4.registrar-servers.com" }
    mx5 = { priority = 20, server = "eforward5.registrar-servers.com" }
  }
}

# ═════════════════════════════════════════════════════════════════════════════
# cloudville domain
# ═════════════════════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────────────────────
# Wildcard & Root A Records — cloudville domain
# ─────────────────────────────────────────────────────────────────────────────

# Wildcard A record: *.${var.cloudville_domain} -> Origin Public IP
resource "cloudflare_record" "cloudville_wildcard_a" {
  zone_id = var.cloudville_zone_id
  name    = "*"
  type    = "A"
  content = var.server_public_ip
  proxied = true
  ttl     = 1
}

# Root domain A record: ${var.cloudville_domain} -> Origin Public IP
resource "cloudflare_record" "cloudville_root_a" {
  zone_id = var.cloudville_zone_id
  name    = "@"
  type    = "A"
  content = var.server_public_ip
  proxied = true
  ttl     = 1
}

# www subdomain CNAME
resource "cloudflare_record" "cloudville_www_cname" {
  zone_id = var.cloudville_zone_id
  name    = "www"
  type    = "CNAME"
  content = var.cloudville_domain
  proxied = true
  ttl     = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# MX Records — cloudville domain
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_record" "cloudville_mx" {
  for_each = local.mx_records

  zone_id  = var.cloudville_zone_id
  name     = "@"
  type     = "MX"
  content  = each.value.server
  priority = each.value.priority
  proxied  = false
  ttl      = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# TXT Records — cloudville domain
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_record" "cloudville_spf" {
  zone_id = var.cloudville_zone_id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:spf.efwd.registrar-servers.com ~all"
  proxied = false
  ttl     = 1
}

# ═════════════════════════════════════════════════════════════════════════════
# personal domain
# ═════════════════════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────────────────────
# Wildcard & Root A Records — personal domain
# ─────────────────────────────────────────────────────────────────────────────

# Wildcard A record: *.${var.rishabmanocha_domain} -> Origin Public IP
resource "cloudflare_record" "rishabmanocha_wildcard_a" {
  zone_id = var.rishabmanocha_zone_id
  name    = "*"
  type    = "A"
  content = var.server_public_ip
  proxied = true
  ttl     = 1
}

# Root domain A record: ${var.rishabmanocha_domain} -> Origin Public IP
resource "cloudflare_record" "rishabmanocha_root_a" {
  zone_id = var.rishabmanocha_zone_id
  name    = "@"
  type    = "A"
  content = var.server_public_ip
  proxied = true
  ttl     = 1
}

# www subdomain CNAME
resource "cloudflare_record" "rishabmanocha_www_cname" {
  zone_id = var.rishabmanocha_zone_id
  name    = "www"
  type    = "CNAME"
  content = var.rishabmanocha_domain
  proxied = true
  ttl     = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# MX Records — personal domain
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_record" "rishabmanocha_mx" {
  for_each = local.mx_records

  zone_id  = var.rishabmanocha_zone_id
  name     = "@"
  type     = "MX"
  content  = each.value.server
  priority = each.value.priority
  proxied  = false
  ttl      = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# TXT Records — personal domain
# ─────────────────────────────────────────────────────────────────────────────

resource "cloudflare_record" "rishabmanocha_spf" {
  zone_id = var.rishabmanocha_zone_id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:spf.efwd.registrar-servers.com ~all"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "rishabmanocha_mail_spf" {
  zone_id = var.rishabmanocha_zone_id
  name    = "mail"
  type    = "TXT"
  content = "v=spf1 include:mailgun.org ~all"
  proxied = false
  ttl     = 1
}
