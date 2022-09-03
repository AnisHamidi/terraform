variable "name" {
  type        = string
  description = "Module name."
}

variable "cluster_domain" {
  type        = string
  description = "The identifier for the cluster."
}

variable "network_list" {
  type = list(string)
}

variable "cluster_id" {
  type        = string
  description = "The identifier for the cluster."
}
variable "region" {
  type        = string
  description = "Region name."
}

variable "base_domain" {
  type = string
}
variable "api_cert" {
  type = string
}

variable "sshPublicKey" {
  type = string
}
variable "core_password_hash" {
  type = string
}

variable "is_snappgroup" {
  type = bool
}

variable "base_image_id" {
  type        = string
  description = "The identifier of the Glance image for worker nodes."
}

variable "flavor_name" {
  type = string
}

variable "root_volume_size" {
  type        = number
  description = "The size of the volume in gigabytes for the root block device."
}
