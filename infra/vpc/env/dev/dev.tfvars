environment     = "dev"
project_id      = "infra-demo-qa"
data_project_id = "infra-demo-dev"
#### DB
db_name          = "mte-data-dev"
database_version = "POSTGRES_18"           #"MYSQL_8_0"
disk_size        = "15"
tier             = "db-g1-small" #"db-f1-micro" #"db-custom-2-4096"
ip_configuration = {
  ipv4_enabled                  = false
  psc_enabled                   = true
  psc_allowed_consumer_projects = ["infra-demo-dev", "infra-demo-qa"]
}
### PSC
data_psc_subnetwork         = "default"
data_psc_allocated_ip       = "10.186.0.11"
data_psc_forwarding_network = "default"

app_psc_subnetwork         = "default"
app_psc_allocated_ip       = "10.186.0.16"
app_psc_forwarding_network = "default"
psc_dns_zone_name          = "sql-zone4"

vpc_connector_name    = "vpc-connector-qa"
vpc_connector_ip_cidr = "10.10.10.0/28"



vpc_connector_machine_type  = "e2-micro" # Default machine type, you can specify a different one
vpc_connector_min_instances = 2          # Minimum number of instances in the autoscaling group
vpc_connector_max_instances = 3          # Maximum number of instances in the autoscaling group
