resource "google_compute_network" "this" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "this" {
  name                     = var.subnetwork_name
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.this.self_link
  ip_cidr_range            = var.subnetwork_cidr
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_ssh" {
  count = length(var.ssh_source_ranges) > 0 ? 1 : 0

  name    = "${var.network_name}-allow-ssh"
  project = var.project_id
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["shipyard"]
}

resource "google_compute_firewall" "allow_web" {
  name    = "${var.network_name}-allow-web"
  project = var.project_id
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["shipyard", "edge"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "${var.network_name}-allow-internal"
  project = var.project_id
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.subnetwork_cidr]
  target_tags   = ["shipyard", "data", "edge"]
}
