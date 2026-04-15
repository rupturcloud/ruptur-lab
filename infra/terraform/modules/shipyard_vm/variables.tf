variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "boot_disk_type" {
  type = string
}

variable "boot_disk_size_gb" {
  type = number
}

variable "image_project" {
  type = string
}

variable "image_family" {
  type = string
}

variable "network_self_link" {
  type = string
}

variable "subnetwork_self_link" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "ssh_login_user" {
  type = string
}

variable "ssh_public_keys" {
  type = list(string)
}

variable "resource_labels" {
  type    = map(string)
  default = {}
}
