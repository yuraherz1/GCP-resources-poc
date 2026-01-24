# locals {
#   # full_cluster_name = "${var.eks_cluster_name}-${terraform.workspace}"

#   tags = {
#     Environment = terraform.workspace
#     Terraform   = "true"
#   }
# }

# project_id  = "infra-demo-dev"
# bucket_name = "484109-infra-demo-terraform-state"
# region                    = var.region


### DB
module "mysql_db" {
  source = "../../modules/cloudsql"
}

# import {
#   id = "projects/infra-demo-dev/instances/mysql-test-default"
#   to = module.mysql_db.google_sql_database_instance.main
# }

resource "google_compute_address" "psc_infra_demo" {
  name         = "ip-psc-infra-demo-dev"
  region       = "europe-central2"
  address_type = "INTERNAL"
  subnetwork   = "default"
  address      = "10.186.0.10"
}

resource "google_compute_forwarding_rule" "psc_infra_demo" {
  name                  = "psc-sql-endpoint-infra-demo-dev"
  region                = "europe-central2"
  network               = "default"
  ip_address            = google_compute_address.psc_infra_demo.self_link
  load_balancing_scheme = ""
  target                = module.mysql_db.service_attachment_url
}

### DNS
resource "google_dns_managed_zone" "mysql_private_zone" {
  name        = "sql-zone3"
  dns_name    = module.mysql_db.mysql_dns_name
  description = "zone to connect to cloud sql in different vpc"
  # labels = {
  #   foo = "foo"
  # }
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = data.google_compute_network.existing_network_dev.self_link
    }
  }
}

# import {
#   id = "projects/infra-demo-dev/managedZones/sql-zone3"
#   to = google_dns_managed_zone.mysql_private_zone
# }

resource "google_dns_record_set" "mysql_private_zone" {
  project      = "infra-demo-dev"
  managed_zone = google_dns_managed_zone.mysql_private_zone.name
  name         = module.mysql_db.mysql_dns_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["10.186.0.10"] #10.186.0.6 qa: 10.186.0.5
}


########## APP ##########

resource "google_compute_address" "psc_infra_demo_qa" {
  name         = "ip-psc-infra-demo-qa"
  project      = "infra-demo-qa"
  region       = "europe-central2"
  address_type = "INTERNAL"
  subnetwork   = "default"
  address      = "10.186.0.15"
}

resource "google_compute_forwarding_rule" "psc_infra_demo_qa" {
  name                  = "psc-sql-endpoint-infra-demo-qa"
  project               = "infra-demo-qa"
  region                = "europe-central2"
  network               = "default"
  ip_address            = google_compute_address.psc_infra_demo_qa.self_link
  load_balancing_scheme = ""
  target                = module.mysql_db.service_attachment_url
}

### DNS
resource "google_dns_managed_zone" "mysql_private_zone_qa" {
  name        = "sql-zone3"
  project     = "infra-demo-qa"
  dns_name    = module.mysql_db.mysql_dns_name
  description = "zone to connect to cloud sql in different vpc"
  # labels = {
  #   foo = "foo"
  # }
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "projects/infra-demo-qa/global/networks/default" #data.google_compute_network.existing_network_qa.self_link
    }
  }
}

# import {
#   id = "projects/infra-demo-dev/managedZones/sql-zone3"
#   to = google_dns_managed_zone.mysql_private_zone
# }

resource "google_dns_record_set" "mysql_private_zone_qa" {
  project      = "infra-demo-qa"
  managed_zone = google_dns_managed_zone.mysql_private_zone_qa.name
  name         = module.mysql_db.mysql_dns_name
  type         = "A"
  ttl          = 300
  rrdatas      = ["10.186.0.15"] #10.186.0.6 qa: 10.186.0.5
}



















# resource "google_compute_instance" "vm_instance" {
#   name         = "terraform-instance"
#   machine_type = "e2-micro"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     # A default network is created for all GCP projects
#     network = "default"
#     access_config {
#     }
#   }
# }