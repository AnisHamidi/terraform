data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

data "openstack_networking_port_v2" "port" {
  for_each   = toset(var.network_list)
  name       = "${var.cluster_id}-${var.name}-${each.value}"
  depends_on = [openstack_networking_port_v2.snappgroup_tenant, openstack_networking_port_v2.tenant, openstack_networking_port_v2.private]
}

resource "openstack_compute_instance_v2" "instance" {
  name = "${var.cluster_id}-worker-${var.name}"


  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  user_data = local.ign


  dynamic "network" {
    for_each = var.network_list
    content {
      port = data.openstack_networking_port_v2.port[network.value].id
    }
  }

  block_device {
    uuid                  = var.base_image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.root_volume_size
    # volume_type           = "okd4-worker"
  }

  tags = ["openshiftClusterID=${var.cluster_id}"]
  metadata = {
    Name               = "${var.cluster_id}-worker"
    openshiftClusterID = var.cluster_id
    role               = var.name
  }

  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = <<EOF
oc adm drain ${self.name} --ignore-daemonsets --delete-emptydir-data --force
oc delete no ${self.name}
EOF
  }

}
