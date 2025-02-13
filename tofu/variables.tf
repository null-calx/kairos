variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "cloudflare_api_token" {
  description = "CloudFlare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_cc_zone_id" {
  description = "CloudFlare Zone ID for .cc domain"
  type        = string
}

variable "cloudflare_org_zone_id" {
  description = "CloudFlare Zone ID for .org domain"
  type        = string
}
