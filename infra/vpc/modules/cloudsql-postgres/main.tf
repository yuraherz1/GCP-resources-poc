resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  keepers          = {}
}

resource "google_secret_manager_secret" "db_secret" {
  secret_id = "POSTGRES_DATA_PASS"
  replication {
    auto {}
  }

  # # Optional: add labels
  # labels = {
  #   environment = "dev"
  # }
}

resource "google_secret_manager_secret_version" "db_secret_version" {
  secret      = google_secret_manager_secret.db_secret.id
  secret_data = random_password.db_password.result

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_sql_database_instance" "main" {
  project          = var.data_project_id
  name             = var.db_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier #"db-custom-2-4096" #db-f1-micro db-custom-2-4096
    edition           = "ENTERPRISE"
    availability_type = var.availability_type
    disk_size         = var.disk_size
    ip_configuration {
      ipv4_enabled = var.ip_configuration.ipv4_enabled

      psc_config {
        psc_enabled               = var.ip_configuration.psc_enabled
        allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
      }
    }
  }
}

resource "google_sql_user" "users" {
  name     = "mte"
  instance = google_sql_database_instance.main.name
  password = random_password.db_password.result
}

# resource "google_sql_database_instance" "main" {
#   project          = var.data_project_id
#   name             = var.db_name
#   database_version = var.database_version
#   #service_account_email_address =

#   settings {
#     tier              = var.tier #"db-f1-micro"
#     availability_type = var.availability_type

#     ip_configuration {
#       ipv4_enabled = var.ip_configuration.ipv4_enabled

#       psc_config {
#         psc_enabled               = var.ip_configuration.psc_enabled
#         allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
#         # network_attachment_uri    = null

#         # psc_auto_connections {
#         #   consumer_network            = "projects/infra-demo-qa/global/networks/default"
#         #   consumer_service_project_id = "infra-demo-qa"
#         # }

#         # psc_auto_connections {
#         #   consumer_network            = "projects/infra-demo-dev/global/networks/default"
#         #   consumer_service_project_id = "infra-demo-dev"
#         # }
#       }
#     }
#   }
# }