data "openstack_networking_network_v2" "private_network" {
  name = "private"
}
data "openstack_networking_subnet_v2" "private_subnet" {
  name = "private"
}
data "openstack_networking_network_v2" "tenant_network" {
  name = var.is_snappgroup ? "snappgroup_tenant" : "tenant"
}
data "openstack_networking_subnet_v2" "tenant_subnet" {
  name = var.is_snappgroup ? "snappgroup_tenant" : "tenant"
}

resource "openstack_networking_port_v2" "private" {
  name                  = "${var.cluster_id}-${var.name}-private"
  count                 = var.is_snappgroup ? 0 : 1
  admin_state_up        = "true"
  network_id            = data.openstack_networking_network_v2.private_network.id
  port_security_enabled = false
  tags                  = ["openshiftClusterID=${var.cluster_id}"]
  extra_dhcp_option {
    name  = "domain-search"
    value = var.cluster_domain
  }

  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.private_subnet.id
  }
}

resource "openstack_networking_port_v2" "tenant" {
  name                  = "${var.cluster_id}-${var.name}-tenant"
  count                 = var.is_snappgroup ? 0 : 1
  admin_state_up        = "true"
  network_id            = data.openstack_networking_network_v2.tenant_network.id
  port_security_enabled = false
  tags                  = ["openshiftClusterID=${var.cluster_id}"]
  extra_dhcp_option {
    name  = "domain-search"
    value = var.cluster_domain
  }
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.tenant_subnet.id
  }
}
resource "openstack_networking_port_v2" "snappgroup_tenant" {
  name                  = "${var.cluster_id}-${var.name}-snappgroup_tenant"
  count                 = var.is_snappgroup ? 1 : 0
  admin_state_up        = "true"
  network_id            = data.openstack_networking_network_v2.tenant_network.id
  port_security_enabled = false
  tags                  = ["openshiftClusterID=${var.cluster_id}"]
  extra_dhcp_option {
    name  = "domain-search"
    value = var.cluster_domain
  }
  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.tenant_subnet.id
  }
}
