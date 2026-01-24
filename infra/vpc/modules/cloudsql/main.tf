
resource "google_sql_database_instance" "main" {
  project          = "infra-demo-dev"
  name             = "mysql-test-default"
  database_version = "MYSQL_8_0"
  settings {
    # tier = "db-f1-micro"
    tier = "db-custom-2-4096"
    ip_configuration {
      psc_config {
        psc_enabled               = null
        allowed_consumer_projects = []
        network_attachment_uri    = null

        psc_auto_connections {
          consumer_network            = "projects/infra-demo-qa/global/networks/default"
          consumer_network_status     = "VALID"
          consumer_service_project_id = "infra-demo-qa"
          ip_address                  = "10.186.0.5"
          status                      = "ACTIVE"
        }

        psc_auto_connections {
          consumer_network            = "projects/infra-demo-dev/global/networks/default"
          consumer_network_status     = "VALID"
          consumer_service_project_id = "infra-demo-dev"
          ip_address                  = "10.186.0.6"
          status                      = "ACTIVE"
        }

      }
    }
  }
}