locals {
  projects = {
    var.project_id = {
      services = [
        "us-east-1",
        "sqladmin.googleapis.com",
        "networkconnectivity.googleapis.com",
        "compute.googleapis.com",
        "vpcaccess.googleapis.com",
        "dns.googleapis.com",
      ]
    }
    var.data_project_id = {
      services = [
        "sqladmin.googleapis.com",
        "networkconnectivity.googleapis.com",
        "compute.googleapis.com",
        "vpcaccess.googleapis.com",
        "dns.googleapis.com",
      ]
    }
  }
}

resource "google_project_service" "api" {
  for_each           = local.projects
  project            = each.key
  service            = each.value.services
  disable_on_destroy = false
}

resource "time_sleep" "wait_for_apis" {
  create_duration = "60s"

  depends_on = [
    google_project_service.api,
  ]
}