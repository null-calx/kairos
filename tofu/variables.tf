# AWS

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

# SSH

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

# Cloudflare

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

# Oracle

variable "oracle_region" {
  description = "Oracle private key path"
  type        = string
}

variable "oracle_tenancy_ocid" {
  description = "Oracle Tenancy OCID"
  type        = string
  sensitive   = true
}

variable "oracle_user_ocid" {
  description = "Oracle User OCID"
  type        = string
  sensitive   = true
}

variable "oracle_private_key" {
  description = "Oracle private key"
  type        = string
  sensitive   = true
}

variable "oracle_fingerprint" {
  description = "Oracle fingerprint"
  type        = string
}

variable "oracle_root_compartment_id" {
  description = "Oracle Root Compartment ID"
  type        = string
}
