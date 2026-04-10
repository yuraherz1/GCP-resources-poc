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
  project   = var.data_project_id
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
  project     = var.data_project_id
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
    tier              = var.tier
    edition           = var.db_edition #"ENTERPRISE"
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

#resource "google_sql_user" "users" {
#  project  = var.data_project_id
#  name     = var.db_user_name
#  instance = google_sql_database_instance.main.name
#  password = random_password.db_password.result
#}
