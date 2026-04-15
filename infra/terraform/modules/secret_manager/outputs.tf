output "secret_names" {
  value = [for secret in google_secret_manager_secret.this : secret.secret_id]
}
