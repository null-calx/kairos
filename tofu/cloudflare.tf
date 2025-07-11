locals {
  org_domain = "istaroth.org"
  cc_domain  = "istaroth.cc"
}

resource "cloudflare_record" "root_org" {
  zone_id = var.cloudflare_org_zone_id
  name    = local.org_domain
  content = aws_instance.istaroth_instance.public_ip
  type    = "A"
  ttl     = 300
  proxied = false
}

resource "cloudflare_record" "www_org" {
  zone_id = var.cloudflare_org_zone_id
  name    = "www"
  content = local.org_domain
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "root_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = local.cc_domain
  content = aws_instance.istaroth_instance.public_ip
  type    = "A"
  ttl     = 300
  proxied = false
}

resource "cloudflare_record" "www_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = "www"
  content = local.cc_domain
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "nyx_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = "nyx"
  content = local.cc_domain
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "navi_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = "navi"
  content = local.cc_domain
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "webirc_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = "webirc"
  content = local.cc_domain
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

