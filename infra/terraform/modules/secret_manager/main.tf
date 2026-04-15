resource "google_secret_manager_secret" "this" {
  for_each = toset(var.secret_names)

  project   = var.project_id
  secret_id = each.value
  labels    = var.resource_labels

  replication {
    auto {}
  }
}
