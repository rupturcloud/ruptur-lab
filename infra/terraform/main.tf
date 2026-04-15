data "google_project" "current" {
  project_id = var.project_id
}

resource "google_project_service" "project_services" {
  for_each = local.project_services

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_service_account" "runtime" {
  account_id   = var.runtime_service_account_name
  display_name = "Ruptur Shipyard Runtime"
  description  = "Service account anexada à VM principal do estaleiro."
  project      = var.project_id

  depends_on = [google_project_service.project_services]
}

resource "google_project_iam_member" "runtime_project_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/secretmanager.secretAccessor",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.runtime.email}"
}

module "network" {
  source = "./modules/network"

  project_id        = var.project_id
  region            = var.region
  network_name      = var.network_name
  subnetwork_name   = var.subnetwork_name
  subnetwork_cidr   = var.subnetwork_cidr
  ssh_source_ranges = var.ssh_source_ranges
  resource_labels   = local.common_labels

  depends_on = [google_project_service.project_services]
}

module "shipyard_vm" {
  source = "./modules/shipyard_vm"

  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone
  vm_name               = var.vm_name
  machine_type          = var.machine_type
  boot_disk_type        = var.boot_disk_type
  boot_disk_size_gb     = var.boot_disk_size_gb
  image_project         = var.image_project
  image_family          = var.image_family
  network_self_link     = module.network.network_self_link
  subnetwork_self_link  = module.network.subnetwork_self_link
  service_account_email = google_service_account.runtime.email
  ssh_login_user        = var.ssh_login_user
  ssh_public_keys       = var.ssh_public_keys
  resource_labels       = local.common_labels

  depends_on = [
    module.network,
    google_project_iam_member.runtime_project_roles,
  ]
}

module "secret_manager" {
  source = "./modules/secret_manager"

  project_id      = var.project_id
  secret_names    = var.secret_names
  resource_labels = local.common_labels

  depends_on = [google_project_service.project_services]
}
