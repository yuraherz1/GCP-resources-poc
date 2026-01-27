output "db_dns_name" {
  description = "The DNS name of the DB instance"
  value       = google_sql_database_instance.main.dns_name
}

output "db_connection_name" {
  description = "The connection name of the instance"
  value       = google_sql_database_instance.main.connection_name
}

# output "db_password_secret_name" {
#   value = google_secret_manager_secret.db_secret.name
# }

output "service_attachment_url" {
  description = "The URI that points to the service attachment of the instance"
  value       = google_sql_database_instance.main.psc_service_attachment_link
}
