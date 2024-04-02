resource "ibm_is_vpc" "vpc" {
  name = "my-vpc"
}

data "ibm_is_vpc_address_prefixes" "vpc-addresses" {
  vpc = ibm_is_vpc.vpc.id
}

resource "ibm_is_subnet" "subnet" {
  name                     = "my-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = var.zone_name
  total_ipv4_address_count = 256
}

resource "ibm_is_vpn_gateway" "vpn_gateway" {
  name   = "my-vpngateway"
  subnet = ibm_is_subnet.subnet.id
  mode   = var.mode
}

locals {
  cse_cidrs = ["166.8.0.0/14", "161.26.0.0/16"]
}

resource "ibm_is_vpn_gateway_connection" "vpn_conn" {
  name          = "my-vpngateway-connection"
  vpn_gateway   = ibm_is_vpn_gateway.vpn_gateway.id
  peer_address  = var.peer_address
  preshared_key = var.preshared_key
  local_cidrs   = var.mode == "route" ? null : (length(var.local_cidrs) > 0 ? var.local_cidrs : concat(local.cse_cidrs, [for ap in data.ibm_is_vpc_address_prefixes.vpc-addresses.address_prefixes: ap.cidr]))
  peer_cidrs    = var.mode == "route" ? null : var.peer_cidrs
}

resource "ibm_is_vpc_routing_table_route" "vpn_route" {
  for_each      = toset(var.mode == "route" ? var.peer_cidrs : [])
  vpc           = ibm_is_vpc.vpc.id
  routing_table = ibm_is_vpc.vpc.default_routing_table
  zone          = var.zone_name
  destination   = each.value
  action        = "deliver"
  advertise     = true
  next_hop      = ibm_is_vpn_gateway_connection.vpn_conn.gateway_connection
}

