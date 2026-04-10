# resource "google_service_account" "default" {
#   account_id   = "my-custom-sa"
#   display_name = "Custom SA for VM Instance"
# }

resource "google_compute_instance" "main" {
  name         = "my-instance" #var.compute_instance_name
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}






# resource "google_compute_address" "psc_allocate_ip" {
#   name         = var.psc_allocated_ip_name
#   project      = var.psc_project_id
#   region       = var.region
#   address_type = "INTERNAL"
#   subnetwork   = var.psc_subnetwork
#   address      = var.psc_allocated_ip
# }

# resource "google_compute_forwarding_rule" "psc_allocate_ip" {
#   name                  = var.psc_forwarding_rule_name
#   project               = var.psc_project_id
#   region                = var.region
#   network               = var.psc_forwarding_network_name
#   ip_address            = google_compute_address.psc_allocate_ip.self_link
#   load_balancing_scheme = ""
#   target                = var.psc_target
# }

# resource "google_dns_managed_zone" "psc_allocate_ip" {
#   name        = var.psc_dns_zone_name
#   project     = var.psc_project_id
#   dns_name    = var.dns_name
#   description = "The DNS zone to connect to Cloud SQL"
#   visibility  = "private"

#   private_visibility_config {
#     networks {
#       network_url = var.network_url
#     }
#   }
# }

# resource "google_dns_record_set" "psc_allocate_ip" {
#   project      = var.psc_project_id
#   managed_zone = google_dns_managed_zone.psc_allocate_ip.name
#   name         = var.dns_record_name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = [var.psc_allocated_ip]
# }
