# ─────────────────────────────────────────────────────────────────────────────
# DNS Records
#
# Manages all DNS records for both domains:
#   - CNAME records pointing subdomains to the Cloudflare Tunnel
#   - MX records for email forwarding (Namecheap eforward)
#   - TXT records for SPF
#
# The old A records (*.cloudville.me, cloudville.me, www.cloudville.me,
# *.rishabmanocha.com, etc. → 66.183.55.122) are intentionally NOT created.
# The tunnel CNAME records replace them entirely.
# ─────────────────────────────────────────────────────────────────────────────

locals {
  tunnel_cname = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"

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
# cloudville.me
# ═════════════════════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────────────────────
# CNAME Records — cloudville.me
# ─────────────────────────────────────────────────────────────────────────────

# Per-app subdomain CNAMEs (one per app in cloudville_apps)
resource "cloudflare_record" "cloudville_app_cname" {
  for_each = local.cloudville_apps

  zone_id = var.cloudville_zone_id
  name    = each.key
  type    = "CNAME"
  content = local.tunnel_cname
  proxied = true
  ttl     = 1
}

# Root domain — catch-all returns 404 (no app served at root)
resource "cloudflare_record" "cloudville_root_cname" {
  zone_id = var.cloudville_zone_id
  name    = "@"
  type    = "CNAME"
  content = local.tunnel_cname
  proxied = true
  ttl     = 1
}

# www subdomain
resource "cloudflare_record" "cloudville_www_cname" {
  zone_id = var.cloudville_zone_id
  name    = "www"
  type    = "CNAME"
  content = local.tunnel_cname
  proxied = true
  ttl     = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# MX Records — cloudville.me
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
# TXT Records — cloudville.me
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
# rishabmanocha.com
# ═════════════════════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────────────────────
# CNAME Records — rishabmanocha.com
# ─────────────────────────────────────────────────────────────────────────────

# Root domain → Ghost (port 2368)
resource "cloudflare_record" "rishabmanocha_root_cname" {
  zone_id = var.rishabmanocha_zone_id
  name    = "@"
  type    = "CNAME"
  content = local.tunnel_cname
  proxied = true
  ttl     = 1
}

# www subdomain
resource "cloudflare_record" "rishabmanocha_www_cname" {
  zone_id = var.rishabmanocha_zone_id
  name    = "www"
  type    = "CNAME"
  content = local.tunnel_cname
  proxied = true
  ttl     = 1
}

# ─────────────────────────────────────────────────────────────────────────────
# MX Records — rishabmanocha.com
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
# TXT Records — rishabmanocha.com
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
