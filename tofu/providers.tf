terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.0"
    # }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 7.0"
    }
  }
}

# provider "aws" {
#   region     = var.aws_region
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
# }

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "oci" {
  region       = var.oracle_region
  tenancy_ocid = var.oracle_tenancy_ocid
  user_ocid    = var.oracle_user_ocid
  private_key  = var.oracle_private_key
  fingerprint  = var.oracle_fingerprint
}
