resource "openstack_compute_instance_v2" "vm" {
  name              = "vm-${count.index}"
  count             = "${var.vm_count}"
  flavor_name       = "${var.vm_flavor_name}"
  sshPublicKey       = chomp(file(var.keypair_public_key_path))
  security_groups   = ["internal-access"]
  availability_zone = "nova"
  network{
    uuid = $(openstack_networking_port_v2.private.id)
  }
  block_device {
    uuid                 = "${data.openstack_images_image_v2.centos7.id}"
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.root_volume_size
  }
}

data "openstack_networking_network_v2" "private_network" {
  name = "private"
}

resource "openstack_networking_port_v2" "private" {
  name                  = "${var.cluster_id}-${openstack_compute_instance_v2.vm.name}-private"
  admin_state_up        = "true"
  network_id            = data.openstack_networking_network_v2.private_network.id
  port_security_enabled = false
  extra_dhcp_option {
    name  = "domain-search"
    value = var.cluster_domain
  }
}


