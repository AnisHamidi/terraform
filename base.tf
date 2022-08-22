terraform {
  required_version = "~> 0.11.8"

}

provider "openstack" {
  version = "~> 1.40.0"

  user_name           = "${var.openstack_username}"
  tenant_name         = "${var.openstack_tenant_name}"
  password            = "${var.openstack_password}"
  auth_url            = "${var.openstack_auth_url}"
  domain_name         = "${var.openstack_domain_name}"
  user_domain_name    = "${var.openstack_user_domain_name}"
  project_domain_name = "${var.openstack_project_domain_name}"
  region              = "${var.openstack_region}"
}

resource "openstack_compute_keypair_v2" "utility-ssh-access" {
  name       = "utility-ssh-access"
  public_key = "${file(var.snappcloud_utility_public_key_path)}"
}


