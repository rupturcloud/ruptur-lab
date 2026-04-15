data "google_compute_image" "os" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_address" "this" {
  name    = "${var.vm_name}-ip"
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "this" {
  name         = var.vm_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  tags         = ["shipyard", "edge", "data"]
  labels       = var.resource_labels

  boot_disk {
    initialize_params {
      image = data.google_compute_image.os.self_link
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
    auto_delete = true
  }

  network_interface {
    network    = var.network_self_link
    subnetwork = var.subnetwork_self_link

    access_config {
      nat_ip = google_compute_address.this.address
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = length(var.ssh_public_keys) > 0 ? {
    ssh-keys = join("\n", [for key in var.ssh_public_keys : "${var.ssh_login_user}:${key}"])
  } : {}

  allow_stopping_for_update = true

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}
