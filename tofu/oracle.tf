locals {
  image_shape = "VM.Standard.E2.1.Micro"
}

data "oci_identity_availability_domains" "ava_domain" {
  compartment_id = var.oracle_tenancy_ocid
}

data "oci_core_images" "instance_image" {
  compartment_id           = var.oracle_tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = local.image_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_identity_compartment" "istaroth" {
  compartment_id = var.oracle_tenancy_ocid
  description    = "compartment for all istaroth resources"
  name           = "istaroth"
}

resource "oci_core_vcn" "vcn" {
  compartment_id = oci_identity_compartment.istaroth.id
  display_name   = "istaroth vcn"

  cidr_blocks = [
    "10.0.0.0/16"
  ]
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.istaroth.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "istaroth igw"
}

resource "oci_core_route_table" "rt" {
  compartment_id = oci_identity_compartment.istaroth.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "istaroth rt"

  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination_type  = "CIDR_BLOCK"
    destination       = "0.0.0.0/0"
    description       = "allow all"
  }
}

resource "oci_core_network_security_group" "nsg" {
  compartment_id = oci_identity_compartment.istaroth.id
  vcn_id = oci_core_vcn.vcn.id
  display_name = "istaroth nsg"
}

resource "oci_core_network_security_group_security_rule" "nsgsr_http" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction = "INGRESS"
  protocol = 6
  description = "http tcp"
  source_type = "CIDR_BLOCK"
  source = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nsgsr_https" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction = "INGRESS"
  protocol = 6
  description = "https tcp"
  source_type = "CIDR_BLOCK"
  source = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_security_list" "sl" {
  compartment_id = oci_identity_compartment.istaroth.id
  vcn_id = oci_core_vcn.vcn.id
  display_name = "istaroth sl"

  egress_security_rules {
    description = "all internet"
    destination = "0.0.0.0/0"
    protocol = "all"
  }

  ingress_security_rules {
    description = "ssh tcp"
    source = "0.0.0.0/0"
    protocol = 6

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    description = "http tcp"
    source = "0.0.0.0/0"
    protocol = 6

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    description = "https tcp"
    source = "0.0.0.0/0"
    protocol = 6

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    description = "wireguard tcp"
    source = "0.0.0.0/0"
    protocol = 6

    tcp_options {
      min = 51820
      max = 51820
    }
  }

  ingress_security_rules {
    description = "wireguard udp"
    source = "0.0.0.0/0"
    protocol = 17

    udp_options {
      min = 51820
      max = 51820
    }
  }
}

resource "oci_core_subnet" "subnet" {
  compartment_id             = oci_identity_compartment.istaroth.id
  vcn_id                     = oci_core_vcn.vcn.id
  display_name               = "istaroth subnet"
  route_table_id             = oci_core_route_table.rt.id
  prohibit_public_ip_on_vnic = false
  cidr_block                 = "10.0.1.0/24"
  security_list_ids = [
    oci_core_security_list.sl.id
  ]
}

resource "oci_core_instance" "istaroth" {
  compartment_id      = oci_identity_compartment.istaroth.id
  availability_domain = data.oci_identity_availability_domains.ava_domain.availability_domains[0].name
  display_name        = "istaroth"
  shape               = local.image_shape

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
    display_name     = "istaroth"
    nsg_ids = [
      oci_core_network_security_group.nsg.id
    ]
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.instance_image.images[0].id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
