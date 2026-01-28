locals {
  services = [
    "sqladmin.googleapis.com",
    "networkconnectivity.googleapis.com",
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
    "dns.googleapis.com",
  ]
}

resource "google_project_service" "api_app" {
  for_each           = toset(local.services)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

resource "google_project_service" "api_data" {
  for_each           = toset(local.services)
  project            = var.data_project_id
  service            = each.key
  disable_on_destroy = false
}

resource "time_sleep" "wait_for_apis" {
  create_duration = "60s"

  depends_on = [
    google_project_service.api_app,
    google_project_service.api_data
  ]
}