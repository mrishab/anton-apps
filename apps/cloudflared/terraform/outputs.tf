output "tunnel_id" {
  description = "The ID of the Cloudflare Tunnel"
  value       = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

output "tunnel_token" {
  description = "The tunnel token — set this as CLOUDFLARED_TUNNEL_TOKEN in cloudflared/.env"
  value       = cloudflare_zero_trust_tunnel_cloudflared.this.tunnel_token
  sensitive   = true
}

output "tunnel_cname" {
  description = "The CNAME target for DNS records pointing to this tunnel"
  value       = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
}
