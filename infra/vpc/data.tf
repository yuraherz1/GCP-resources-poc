data "google_compute_network" "existing_network_dev" {
  name    = "default"
  project = "infra-demo-dev"
}

# data "google_compute_network" "existing_network_qa" {
#   name    = "default"
#   project = "infra-demo-qa"
# }