output "project_number" {
  description = "Número do projeto GCP usado pelo estaleiro."
  value       = data.google_project.current.number
}

output "runtime_service_account_email" {
  description = "Service account anexada à VM principal."
  value       = google_service_account.runtime.email
}

output "network_name" {
  description = "Nome da VPC dedicada do estaleiro."
  value       = module.network.network_name
}

output "subnetwork_name" {
  description = "Nome da subnet dedicada do estaleiro."
  value       = module.network.subnetwork_name
}

output "shipyard_static_ip" {
  description = "IP público estático reservado para a VM principal."
  value       = module.shipyard_vm.static_ip
}

output "shipyard_instance_name" {
  description = "Nome da VM principal do estaleiro."
  value       = module.shipyard_vm.instance_name
}

output "ansible_host_hint" {
  description = "Linha útil para preencher o inventory do Ansible."
  value       = format("shipyard_lab ansible_host=%s ansible_user=%s", module.shipyard_vm.static_ip, var.ssh_login_user)
}

output "secret_names" {
  description = "Lista de segredos estruturais criados no Secret Manager."
  value       = module.secret_manager.secret_names
}
