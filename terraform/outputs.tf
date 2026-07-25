output "cloudville_zone_id" {
  description = "Zone ID for cloudville.me"
  value       = var.cloudville_zone_id
}

output "cloudville_wildcard_dns" {
  description = "Wildcard DNS record for cloudville.me"
  value       = cloudflare_record.cloudville_wildcard_a.hostname
}

output "rishabmanocha_zone_id" {
  description = "Zone ID for rishabmanocha.com"
  value       = var.rishabmanocha_zone_id
}

output "rishabmanocha_wildcard_dns" {
  description = "Wildcard DNS record for rishabmanocha.com"
  value       = cloudflare_record.rishabmanocha_wildcard_a.hostname
}

output "server_public_ip" {
  description = "Configured public IP for origin A records"
  value       = var.server_public_ip
}

output "ssl_mode" {
  description = "Cloudflare SSL/TLS mode"
  value       = var.ssl_mode
}
