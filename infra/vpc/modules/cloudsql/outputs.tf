output "mysql_dns_name" {
  description = "The DNS name of the DB instance."
  value       = google_sql_database_instance.main.dns_name
}

output "ip_address_psc_" {
  description = "The IP address of the consumer endpoint."
  value       = values(google_sql_database_instance.main)[*].settings.ip_configuration.psc_config.psc_auto_connections.ip_address

  # value       = google_sql_database_instance.main.settings.ip_configuration.psc_config.psc_auto_connections.ip_address

}
