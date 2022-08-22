variable "vm_count" {
  type        = number
}
variable "vm_flavor_name" {
  type        = string
}
variable "keypair_public_key_path" {
  type        = string
}

variable "cluster_id" {
  type        = string
}

variable "cluster_domain" {
  type        = string
}

variable "root_volume_size" {
  type        = number
}
variable "region" {
  type        = string
}
variable "base_domain" {
  type        = staging
}