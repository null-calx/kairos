variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "CloudFlare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "CloudFlare Zone ID"
  type        = string
  sensitive   = true
}
