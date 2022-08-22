locals {
  region_domain             = "${var.region}.${var.base_domain}"
  cluster_domain            = "${var.cluster_id}.${var.region}.${var.base_domain}"
}
