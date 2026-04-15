locals {
  foundation_name = "ruptur-lab"

  common_labels = merge(
    {
      managed_by  = "terraform"
      environment = var.environment
      workload    = "shipyard"
      foundation  = local.foundation_name
    },
    var.extra_labels,
  )

  project_services = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
  ])
}
