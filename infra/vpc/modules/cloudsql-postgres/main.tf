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
  project   = var.project
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
  project     = var.project
  secret      = google_secret_manager_secret.db_secret.id
  secret_data = random_password.db_password.result

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "google_sql_database_instance" "main" {
  project             = var.project
  name                = var.db_name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = false
  settings {
    tier              = var.tier
    edition           = var.db_edition
    availability_type = var.availability_type
    disk_size         = var.disk_size
    connection_pool_config {
      flags {
        name  = "cloudsql.iam_authentication"
        value = "on"
      }
    }
    ip_configuration {
      ipv4_enabled                                  = var.ip_configuration.ipv4_enabled
      enable_private_path_for_google_cloud_services = true
      psc_config {
        psc_enabled               = var.ip_configuration.psc_enabled
        allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
      }
    }
  }
}

resource "google_sql_user" "default" {
  project  = var.project
  name     = var.db_user_name
  instance = google_sql_database_instance.main.name
  password = random_password.db_password.result
}
