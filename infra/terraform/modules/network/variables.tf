variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnetwork_name" {
  type = string
}

variable "subnetwork_cidr" {
  type = string
}

variable "ssh_source_ranges" {
  type = list(string)
}

variable "resource_labels" {
  type    = map(string)
  default = {}
}
