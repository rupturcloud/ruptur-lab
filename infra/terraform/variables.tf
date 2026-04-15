variable "project_id" {
  description = "Project ID existente do GCP que hospedará o estaleiro."
  type        = string
}

variable "environment" {
  description = "Rótulo de ambiente usado nos recursos."
  type        = string
  default     = "lab"
}

variable "region" {
  description = "Região principal do estaleiro."
  type        = string
  default     = "southamerica-east1"
}

variable "zone" {
  description = "Zona padrão da VM principal."
  type        = string
  default     = "southamerica-east1-b"
}

variable "network_name" {
  description = "Nome da VPC dedicada do estaleiro."
  type        = string
  default     = "ruptur-shipyard-vpc"
}

variable "subnetwork_name" {
  description = "Nome da subnet dedicada do estaleiro."
  type        = string
  default     = "ruptur-shipyard-subnet"
}

variable "subnetwork_cidr" {
  description = "CIDR da subnet dedicada do estaleiro."
  type        = string
  default     = "10.42.0.0/24"
}

variable "ssh_source_ranges" {
  description = "Lista de ranges permitidos para SSH. Definir antes do apply."
  type        = list(string)
  default     = []
}

variable "vm_name" {
  description = "Nome da VM principal do estaleiro."
  type        = string
  default     = "ruptur-shipyard-01"
}

variable "machine_type" {
  description = "Machine type da VM principal."
  type        = string
  default     = "n2-standard-4"
}

variable "boot_disk_type" {
  description = "Tipo de disco da VM principal."
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size_gb" {
  description = "Tamanho do disco de boot em GiB."
  type        = number
  default     = 250
}

variable "image_project" {
  description = "Projeto de imagens do GCE."
  type        = string
  default     = "debian-cloud"
}

variable "image_family" {
  description = "Família da imagem do sistema operacional."
  type        = string
  default     = "debian-11"
}

variable "ssh_login_user" {
  description = "Usuário Linux esperado para acesso inicial por chave pública."
  type        = string
  default     = "diego"
}

variable "ssh_public_keys" {
  description = "Lista opcional de chaves públicas para injetar na metadata da VM."
  type        = list(string)
  default     = []
}

variable "runtime_service_account_name" {
  description = "Account ID da service account anexada à VM."
  type        = string
  default     = "ruptur-shipyard-runtime"
}

variable "secret_names" {
  description = "Segredos estruturais que devem existir no Secret Manager."
  type        = list(string)
  default = [
    "shipyard-postgres-password",
    "shipyard-redis-password",
    "shipyard-n8n-db-password",
    "shipyard-n8n-encryption-key",
    "shipyard-minio-root-user",
    "shipyard-minio-root-password",
    "shipyard-traefik-dashboard-basicauth",
    "shipyard-portainer-admin-password-hash",
    "shipyard-uazapi-api-token",
    "shipyard-uazapi-webhook-secret",
  ]
}

variable "extra_labels" {
  description = "Rótulos adicionais aplicados aos recursos."
  type        = map(string)
  default     = {}
}
