data "google_compute_network" "existing_network_data" {
  name    = "default"
  project = var.data_project_id #"infra-demo-dev"
}

data "google_compute_network" "existing_network_app" {
  name    = "default"
  project = var.project_id #"infra-demo-qa"
}