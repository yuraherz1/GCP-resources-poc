output "mysql_dns_name" {
  description = "The DNS name of the DB instance."
  value       = google_sql_database_instance.main.dns_name
}

# output "ip_address_psc_" {
#   description = "The DNS name of the DB instance."
#   value       = google_sql_database_instance.main.dns_name
# }
# settings.ip_configuration.psc_config.psc_auto_connections.ip_address
