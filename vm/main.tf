module "worker" {
  source        = "./workers"
  count         = var.worker_count
  is_snappgroup = var.is_snappgroup

  name               = "worker-${count.index}"
  cluster_id         = var.cluster_id
  cluster_domain     = local.cluster_domain
  flavor_name        = var.openstack_worker_flavor_name
  root_volume_size   = var.openstack_worker_root_volume_size
  api_cert           = var.api_cert
  sshPublicKey       = chomp(file(var.keypair_public_key_path))
  core_password_hash = var.core_password_hash
  base_domain        = var.base_domain
  region             = var.region
  network_list       = contains(var.network_list, "private") ? ["private", "tenant"] : ["snappgroup_tenant"]

  base_image_id = module.images.fcos_33_image_id
}
