terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "terraform-estate"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-estate"
}
