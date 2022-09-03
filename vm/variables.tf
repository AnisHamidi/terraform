
variable "base_domain" {
  type = string
}
variable "region" {
  type = string
}
variable "cluster_id" {
  type = string
}

variable "is_snappgroup" {
  type = bool
}
variable "network_list" {
  type = list(string)
}

variable "openstack_worker_root_volume_size" {
  type        = number
  default     = null
  description = "The size of the volume in gigabytes for the root block device of worker nodes."
}

variable "openstack_worker_flavor_name" {
  type        = string
  description = "Instance size for the worker node(s)."
}

variable "worker_count" {
  type        = number
  description = "Number of masters"
}

variable "keypair_public_key_path" {
  type = string
}

#### ips

variable "core_password_hash" {
  type        = string
  description = "Password of 'core' user for fcos VMs"
}

####

variable "api_cert" {
  type        = string
  description = "export TF_VAR_api_cert=$(cat ~/ignition-configs/master.ign  | jq '.ignition.security.tls.certificateAuthorities[0].source')"

}
