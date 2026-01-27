resource "google_compute_instance" "main" {
  project      = var.project
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.instance_zone

  boot_disk {
    initialize_params {
      image = var.instance_image
      size  = var.instance_disk_size
      type  = var.instance_disk_type
    }
  }

  network_interface {
    network = var.instance_network
    access_config {}
  }
}