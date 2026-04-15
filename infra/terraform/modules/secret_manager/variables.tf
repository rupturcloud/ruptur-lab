variable "project_id" {
  type = string
}

variable "secret_names" {
  type = list(string)
}

variable "resource_labels" {
  type    = map(string)
  default = {}
}
