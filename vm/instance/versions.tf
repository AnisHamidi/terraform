terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.46.0"
    }
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.1"
    }
  }
}
