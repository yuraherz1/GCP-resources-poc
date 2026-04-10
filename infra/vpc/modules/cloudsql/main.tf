
resource "google_sql_database_instance" "main" {
  project          = var.data_project_id
  name             = var.db_name
  database_version = var.database_version
  #service_account_email_address =

  settings {
    tier              = var.tier #"db-f1-micro"
    availability_type = var.availability_type

    ip_configuration {
      ipv4_enabled = var.ip_configuration.ipv4_enabled

      psc_config {
        psc_enabled               = var.ip_configuration.psc_enabled
        allowed_consumer_projects = var.ip_configuration.psc_allowed_consumer_projects
        # network_attachment_uri    = null

        # psc_auto_connections {
        #   consumer_network            = "projects/infra-demo-qa/global/networks/default"
        #   consumer_service_project_id = "infra-demo-qa"
        # }

        # psc_auto_connections {
        #   consumer_network            = "projects/infra-demo-dev/global/networks/default"
        #   consumer_service_project_id = "infra-demo-dev"
        # }
      }
    }
  }
}