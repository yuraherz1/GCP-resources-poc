environment     = "dev"
project_id      = "infra-demo-qa"
data_project_id = "infra-demo-dev"
#### DB
db_name           = "mte-data-dev"
db_user_name      = "mte"
db_database_name  = "mte"
database_version  = "POSTGRES_18" #"MYSQL_8_0"
disk_size         = "15"
tier              = "db-f1-micro" #"db-f1-micro" #"db-custom-2-4096" db-g1-small
db_edition        = "ENTERPRISE"
availability_type = "ZONAL" #REGIONAL
ip_configuration = {
  ipv4_enabled                  = false
  psc_enabled                   = true
  psc_allowed_consumer_projects = ["infra-demo-dev", "infra-demo-qa"]
}
### PSC
data_psc_subnetwork         = "default"
data_psc_allocated_ip       = "10.186.0.12"
data_psc_forwarding_network = "default"

app_psc_subnetwork         = "default"
app_psc_allocated_ip       = "10.186.0.17"
app_psc_forwarding_network = "default"
psc_dns_zone_name          = "mte-postgres"

vpc_connector_name          = "mte-vpc-connector-dev"
vpc_connector_ip_cidr       = "10.10.10.0/28"
vpc_connector_machine_type  = "e2-micro"
vpc_connector_min_instances = 2
vpc_connector_max_instances = 3

#bastion
instance_name      = "mte-bastion-postgres-dev"
instance_type      = "e2-medium" #"e2-micro"
instance_zone      = "europe-central2-b"
instance_image     = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
instance_disk_size = 10
instance_disk_type = "pd-balanced"
# instance_network   = "default"
