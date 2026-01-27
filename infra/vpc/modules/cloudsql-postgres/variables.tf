variable "region" {
  description = "The region for Firebase and workflow"
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "db_name" {
  description = "The name for Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "(Required) The database version to use"
  type        = string
}

variable "db_edition" {
  description = "The edition of the instance, can be ENTERPRISE or ENTERPRISE_PLUS"
  type        = string
}

variable "tier" {
  description = "The tier for the master Cloud SQL instance"
  type        = string
}

variable "db_user_name" {
  description = "The username of Cloud SQL instance"
  type        = string
}

variable "availability_type" {
  description = "The availability type for the master Cloud SQL instance"
  type        = string
}

variable "disk_size" {
  description = "The tier for the master Cloud SQL instance"
  type        = string
}

variable "ip_configuration" {
  description = "The ip_configuration settings subblock"
  type = object({
    authorized_networks                           = optional(list(map(string)), [])
    ipv4_enabled                                  = optional(bool, true)
    private_network                               = optional(string)
    ssl_mode                                      = optional(string)
    allocated_ip_range                            = optional(string)
    enable_private_path_for_google_cloud_services = optional(bool, false)
    psc_enabled                                   = optional(bool, false)
    psc_allowed_consumer_projects                 = optional(list(string), [])
  })
  default = {}
}
