environment     = "dev"
project_id      = "infra-demo-qa"
data_project_id = "infra-demo-dev"
####
db_name          = "mysql-test-default"
database_version = "MYSQL_8_0"
tier             = "db-custom-2-4096"
ip_configuration = {
  ipv4_enabled                  = false
  psc_enabled                   = true
  psc_allowed_consumer_projects = ["infra-demo-dev", "infra-demo-qa"]
}
###
data_psc_subnetwork   = "default"
data_psc_allocated_ip = "10.186.0.10"
data_psc_forwarding_network = "default"

app_psc_subnetwork    = "default"
app_psc_allocated_ip  = "10.186.0.15"
data_psc_forwarding_network = "default"
psc_dns_zone_name     = "sql-zone4"
