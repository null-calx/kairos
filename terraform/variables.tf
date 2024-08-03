variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "cloudflare_api_token" {
  description = "CloudFlare API token"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "CloudFlare Zone ID"
  type        = string
}
