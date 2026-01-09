locals {
  org_domain = "istaroth.org"
  cc_domain  = "istaroth.cc"

  # public_ip = "192.0.2.0"
  public_ip = oci_core_instance.istaroth.public_ip
  ttl       = 300
}

resource "cloudflare_dns_record" "root_org" {
  zone_id = var.cloudflare_org_zone_id
  name    = local.org_domain
  content = local.public_ip
  type    = "A"
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "www_org" {
  zone_id = var.cloudflare_org_zone_id
  name    = "www"
  content = local.org_domain
  type    = "CNAME"
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "root_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = local.cc_domain
  content = local.public_ip
  type    = "A"
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "star_cc" {
  zone_id = var.cloudflare_cc_zone_id
  name    = "*"
  content = local.cc_domain
  type    = "CNAME"
  ttl     = local.ttl
  proxied = false
}

