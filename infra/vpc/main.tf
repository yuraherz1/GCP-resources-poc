locals {
  psc_resources_name = "mte-psc-postgres-data-${var.environment}"
}

### DB
# module "mysql_db" {
#   source           = "../../modules/cloudsql"
#   data_project_id  = var.data_project_id
#   db_name          = var.db_name
#   database_version = var.database_version
#   #service_account_email_address =

#   tier              = var.tier #"db-f1-micro"
#   availability_type = var.availability_type
#   ip_configuration = {
#     ipv4_enabled                  = var.ip_configuration.ipv4_enabled
#     psc_enabled                   = var.ip_configuration.psc_enabled
#     psc_allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
#   }
# }

module "postgres_data" {
  source           = "../../modules/cloudsql-postgres"
  project          = var.data_project_id
  region           = var.region
  db_name          = var.db_name
  db_user_name     = var.db_user_name
  database_version = var.database_version
  db_edition       = var.db_edition
  #service_account_email_address =

  tier              = var.tier
  availability_type = var.availability_type
  disk_size         = var.disk_size
  ip_configuration = {
    ipv4_enabled                  = var.ip_configuration.ipv4_enabled
    psc_enabled                   = var.ip_configuration.psc_enabled
    psc_allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
  }
}

module "postgres_psc_data" {
  source                      = "../../modules/psc"
  region                      = var.region
  project                     = var.data_project_id
  psc_allocated_ip_name       = local.psc_resources_name
  psc_allocated_ip            = var.data_psc_allocated_ip
  psc_subnetwork              = var.data_psc_subnetwork
  psc_forwarding_rule_name    = local.psc_resources_name
  psc_forwarding_network_name = var.data_psc_forwarding_network
  psc_target                  = module.postgres_data.service_attachment_url
  psc_dns_zone_name           = var.psc_dns_zone_name
  dns_name                    = module.postgres_data.db_dns_name
  network_url                 = data.google_compute_network.existing_network_data.self_link
  dns_record_name             = module.postgres_data.db_dns_name
}

module "postgres_psc_app" {
  source                      = "../../modules/psc"
  region                      = var.region
  project                     = var.project_id
  psc_allocated_ip_name       = local.psc_resources_name
  psc_allocated_ip            = var.app_psc_allocated_ip
  psc_subnetwork              = var.app_psc_subnetwork
  psc_forwarding_rule_name    = local.psc_resources_name
  psc_forwarding_network_name = var.app_psc_forwarding_network
  psc_target                  = module.postgres_data.service_attachment_url
  psc_dns_zone_name           = var.psc_dns_zone_name
  dns_name                    = module.postgres_data.db_dns_name
  network_url                 = data.google_compute_network.existing_network_app.self_link
  dns_record_name             = module.postgres_data.db_dns_name
}

module "bastion_host_data" {
  source             = "../../modules/compute"
  instance_name      = var.instance_name
  instance_type      = var.instance_type
  instance_zone      = var.instance_zone
  instance_image     = var.instance_image
  instance_disk_size = var.instance_disk_size
  instance_disk_type = var.instance_disk_type
  instance_network   = var.instance_network
}

# Create the Serverless VPC Access connector
resource "google_vpc_access_connector" "sql" {
  provider      = "google-beta"
  region        = var.region
  project       = var.project_id
  name          = var.vpc_connector_name
  ip_cidr_range = var.vpc_connector_ip_cidr
  network       = var.app_psc_forwarding_network
  machine_type  = var.vpc_connector_machine_type
  min_instances = var.vpc_connector_min_instances
  max_instances = var.vpc_connector_max_instances
}

# resource "google_compute_instance" "main" {
#   project      = "infra-demo-dev"
#   name         = "tf-instance-via-resource"
#   machine_type = "e2-micro"
#   zone         = "europe-central2-a"

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
#       size  = 10
#       type  = "pd-balanced"
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {
#       # This block assigns an ephemeral external IP address
#     }
#   }

#   # Optional: apply tags to the instance for firewall rules
#   # tags = ["web-server", "allow-http"]
# }


# resource "google_sql_database_instance" "main_instance" {
#   name             = "postgresql-test-dev"
#   database_version = "POSTGRES_18"
#   region           = "europe-central2"

#   settings {
#     # Second-generation instance tiers are based on machine type (e.g., db-f1-micro, db-n1-standard-1).
#     tier              = "db-custom-2-4096" #db-f1-micro db-custom-2-4096
#     edition           = "ENTERPRISE"
#     availability_type = "REGIONAL"
#     disk_size         = 15
#     # ip_configuration {
#     #   ipv4_enabled = var.ip_configuration.ipv4_enabled

#     #   psc_config {
#     #     psc_enabled               = var.ip_configuration.psc_enabled
#     #     allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
#     #   }
#     # }
#   }
# }

# resource "google_compute_instance" "main" {
#   project      = "infra-demo-dev"
#   name         = "instance-20260126-192026" #var.compute_instance_name
#   machine_type = "e2-custom-2-1024"
#   zone         = "europe-central2-a"

#   # tags = ["foo", "bar"]

#   boot_disk {
#     initialize_params {
#       image = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20260117"
#       # labels = {
#       #   my_label = "value"
#       # }
#     }
#   }

#   // Local SSD disk
#   # scratch_disk {
#   #   interface = "NVME"
#   # }

#   network_interface {
#     network = "default"

#     access_config {
#       // Ephemeral public IP
#     }
#   }

#   metadata                   = {

#     "enable-osconfig" = "TRUE"
#   }
#   # metadata = {
#   #   foo = "bar"
#   # }

#   # metadata_startup_script = "echo hi > /test.txt"

#   # service_account {
#   #   # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#   #   email  = google_service_account.default.email
#   #   scopes = ["cloud-platform"]
#   # }
# }

# import {
#   id = "projects/infra-demo-dev/zones/europe-central2-a/instances/instance-20260126-192026"
#   to = google_compute_instance.main
# }
#####################################################
# import {
#   id = "projects/infra-demo-dev/instances/mysql-test-default"
#   to = module.mysql_db.google_sql_database_instance.main
# }

# resource "google_compute_address" "psc_infra_demo" {
#   name         = "ip-psc-infra-demo-dev"
#   region       = "europe-central2"
#   address_type = "INTERNAL"
#   subnetwork   = "default"
#   address      = "10.186.0.10"
# }

# resource "google_compute_forwarding_rule" "psc_infra_demo" {
#   name                  = "psc-sql-endpoint-infra-demo-dev"
#   region                = "europe-central2"
#   network               = "default"
#   ip_address            = google_compute_address.psc_infra_demo.self_link
#   load_balancing_scheme = ""
#   target                = module.mysql_db.service_attachment_url
# }

# ### DNS
# resource "google_dns_managed_zone" "mysql_private_zone" {
#   name        = "sql-zone3"
#   dns_name    = module.mysql_db.mysql_dns_name
#   description = "zone to connect to cloud sql in different vpc"
#   # labels = {
#   #   foo = "foo"
#   # }
#   visibility = "private"

#   private_visibility_config {
#     networks {
#       network_url = data.google_compute_network.existing_network_dev.self_link
#     }
#   }
# }

# # import {
# #   id = "projects/infra-demo-dev/managedZones/sql-zone3"
# #   to = google_dns_managed_zone.mysql_private_zone
# # }

# resource "google_dns_record_set" "mysql_private_zone" {
#   project      = "infra-demo-dev"
#   managed_zone = google_dns_managed_zone.mysql_private_zone.name
#   name         = module.mysql_db.mysql_dns_name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = ["10.186.0.10"] #10.186.0.6 qa: 10.186.0.5
# }


########## APP ##########

# resource "google_compute_address" "psc_infra_demo_qa" {
#   name         = "ip-psc-infra-demo-qa"
#   project      = "infra-demo-qa"
#   region       = "europe-central2"
#   address_type = "INTERNAL"
#   subnetwork   = "default"
#   address      = "10.186.0.15"
# }

# resource "google_compute_forwarding_rule" "psc_infra_demo_qa" {
#   name                  = "psc-sql-endpoint-infra-demo-qa"
#   project               = "infra-demo-qa"
#   region                = "europe-central2"
#   network               = "default"
#   ip_address            = google_compute_address.psc_infra_demo_qa.self_link
#   load_balancing_scheme = ""
#   target                = module.mysql_db.service_attachment_url
# }

# ### DNS
# resource "google_dns_managed_zone" "mysql_private_zone_qa" {
#   name        = "sql-zone3"
#   project     = "infra-demo-qa"
#   dns_name    = module.mysql_db.mysql_dns_name
#   description = "zone to connect to cloud sql in different vpc"
#   # labels = {
#   #   foo = "foo"
#   # }
#   visibility = "private"

#   private_visibility_config {
#     networks {
#       network_url = data.google_compute_network.existing_network_qa.self_link
#     }
#   }
# }

# import {
#   id = "projects/infra-demo-dev/managedZones/sql-zone3"
#   to = google_dns_managed_zone.mysql_private_zone
# }

# resource "google_dns_record_set" "mysql_private_zone_qa" {
#   project      = "infra-demo-qa"
#   managed_zone = google_dns_managed_zone.mysql_private_zone_qa.name
#   name         = module.mysql_db.mysql_dns_name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = ["10.186.0.15"] #10.186.0.6 qa: 10.186.0.5
# }


# # Enable the vpcaccess API
# resource "google_project_service" "vpcaccess_api" {
#   service            = "vpcaccess.googleapis.com"
#   disable_on_destroy = false
# }

# Define a dedicated /28 subnet for the connector (required)
# resource "google_compute_subnetwork" "connector_subnet_qa" {
#   project       = "infra-demo-qa"
#   name          = "sub-vpc-connector-qa"
#   ip_cidr_range = "10.10.10.0/28"
#   region        = "europe-central2" # Must match the connector region
#   network       = data.google_compute_network.existing_network_qa.self_link
# }
