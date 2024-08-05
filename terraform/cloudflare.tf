locals {
  domain_name = "istaroth.cc"
}

resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone_id
  name    = local.domain_name
  value   = aws_instance.istaroth.public_ip
  type    = "A"
  ttl     = 300
  proxied = false
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = local.domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "nyx" {
  zone_id = var.cloudflare_zone_id
  name    = "nyx"
  value   = local.domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "illcow" {
  zone_id = var.cloudflare_zone_id
  name    = "illcow"
  value   = local.domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "webirc" {
  zone_id = var.cloudflare_zone_id
  name    = "webirc"
  value   = local.domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = false
}
