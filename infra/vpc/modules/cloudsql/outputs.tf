output "mysql_dns_name" {
  description = "The DNS name of the DB instance."
  value       = google_sql_database_instance.main.dns_name
}

output "service_attachment_url" {
  description = "The URI that points to the service attachment of the instance."
  value       = google_sql_database_instance.main.psc_service_attachment_link
}

# output "ip_psc_auto_connection" {
#   description = "The IP address of the consumer endpoint."
#   # value = google_sql_database_instance.main.private_ip_address
#   # value       = values(google_sql_database_instance.main)[*].settings.ip_configuration.psc_config.psc_auto_connections.ip_address
#   # value = google_sql_database_instance.main.settings["ip_configuration"].psc_config.psc_auto_connections.ip_address
#   # value = google_sql_database_instance.main.settings[0].ip_configuration[0].psc_config[0].psc_auto_connections.ip_address
#   value = google_sql_database_instance.main.settings.0.ip_configuration.0.psc_config.0.psc_auto_connections.1.ip_address
#   # value = google_sql_database_instance.main.settings.ip_configuration.psc_config.psc_auto_connections.ip_address
#   # value       = google_sql_database_instance.main.settings.ip_configuration.psc_config.psc_auto_connections.ip_address

# }
