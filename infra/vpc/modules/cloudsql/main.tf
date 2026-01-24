
resource "google_sql_database_instance" "main" {
  project          = "infra-demo-dev"
  name             = "mysql-test-default"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      psc_config {
        psc_enabled               = true
        allowed_consumer_projects = ["infra-demo-qa"] #allowed-consumer-project-name
      }
      ipv4_enabled = false
    }
    # backup_configuration {
    #   enabled            = true
    #   binary_log_enabled = true
    # }
    availability_type = "REGIONAL"
  }
}