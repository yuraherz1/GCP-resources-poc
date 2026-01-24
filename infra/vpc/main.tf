# locals {
#   # full_cluster_name = "${var.eks_cluster_name}-${terraform.workspace}"

#   tags = {
#     Environment = terraform.workspace
#     Terraform   = "true"
#   }
# }

### DB
module "mysql_db" {
  source = "../../modules/cloudsql"
  # project_id  = "infra-demo-dev"
  # bucket_name = "484109-infra-demo-terraform-state"
  # region                    = var.region
}

import {
  id = "projects/infra-demo-dev/instances/mysql-test-default"
  to = module.mysql_db.google_sql_database_instance.main
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