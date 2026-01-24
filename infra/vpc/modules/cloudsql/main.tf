
resource "google_sql_database_instance" "main" {
  project          = "infra-demo-dev"
  name             = "mysql-test-default"
  database_version = "MYSQL_8_0"
  settings {
    # tier = "db-f1-micro"
    tier              = "db-custom-2-4096"
    availability_type = "REGIONAL"

    ip_configuration {
      ipv4_enabled = false
      psc_config {
        psc_enabled               = null
        allowed_consumer_projects = []
        network_attachment_uri    = null

        psc_auto_connections {
          consumer_network            = "projects/infra-demo-qa/global/networks/default"
          consumer_service_project_id = "infra-demo-qa"
        }

        psc_auto_connections {
          consumer_network            = "projects/infra-demo-dev/global/networks/default"
          consumer_service_project_id = "infra-demo-dev"
        }

      }
    }
  }
}