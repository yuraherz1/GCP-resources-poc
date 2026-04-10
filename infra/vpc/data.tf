data "google_compute_network" "existing_network_data" {
  name    = "default"
  project = "infra-demo-dev"
}

data "google_compute_network" "existing_network_app" {
  name    = "default"
  project = "infra-demo-qa"
}