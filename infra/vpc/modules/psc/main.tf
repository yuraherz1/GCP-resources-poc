resource "google_compute_address" "psc_allocate_ip" {
  name         = var.psc_allocated_ip_name
  project      = var.psc_project_id
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = var.psc_subnetwork
  address      = var.psc_allocated_ip
}

resource "google_compute_forwarding_rule" "psc_allocate_ip" {
  name                  = var.psc_forwarding_rule_name
  project               = var.psc_project_id
  region                = var.region
  network               = var.psc_forwarding_network_name
  ip_address            = google_compute_address.psc_allocate_ip.self_link
  load_balancing_scheme = ""
  target                = var.psc_target
}

resource "google_dns_managed_zone" "psc_allocate_ip" {
  name        = var.psc_dns_zone_name
  project     = var.psc_project_id
  dns_name    = var.dns_name
  description = "The DNS zone to connect to Cloud SQL"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = var.network_url
    }
  }
}

resource "google_dns_record_set" "psc_allocate_ip" {
  project      = var.psc_project_id
  managed_zone = google_dns_managed_zone.psc_allocate_ip.name
  name         = var.dns_record_name
  type         = "A"
  ttl          = 300
  rrdatas      = [var.psc_allocated_ip]
}
