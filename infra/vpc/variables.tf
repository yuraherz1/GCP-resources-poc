variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_id" {
  description = "The Google Cloud project ID where Firebase Hosting will be configured."
  type        = string
}

variable "data_project_id" {
  description = "The Google Cloud project ID where data workflows is stored"
  type        = string
}

variable "region" {
  description = "The region for Firebase and workflow"
  type        = string
  default     = "europe-central2"
}

###
variable "db_name" {
  description = "The name for Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "(Required) The database version to use"
  type        = string
}

variable "tier" {
  description = "The tier for the Cloud SQL instance"
  type        = string
}

variable "availability_type" {
  description = "The availability type for the master Cloud SQL instance"
  type        = string
  default     = "REGIONAL"
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

### PSC
# variable "psc_project_id" {
#   description = "The Google Cloud project ID where SPC will be located"
#   type        = string
# }

# variable "psc_allocated_ip_name" {
#   description = "The IP address of the PSC"
#   type        = string
# }

variable "app_psc_allocated_ip" {
  description = "The IP address of the PSC"
  type        = string
}

variable "app_psc_subnetwork" {
  description = "The subnetwork in which to reserve the address"
  type        = string
}

variable "data_psc_allocated_ip" {
  description = "The IP address of the PSC"
  type        = string
}

variable "data_psc_subnetwork" {
  description = "The subnetwork in which to reserve the address"
  type        = string
}

# variable "psc_forwarding_rule_name" {
#   description = "(Required) Name of the resource for the PSC forwarding rule"
#   type        = string
# }

variable "data_psc_forwarding_network" {
  description = "The network for Private Service Connect forwarding rules"
  type        = string
}

variable "app_psc_forwarding_network" {
  description = "The network for Private Service Connect forwarding rules"
  type        = string
}

# variable "psc_target" {
#   description = "The URL of the target resource to receive the matched traffic"
#   type        = string
# }

variable "psc_dns_zone_name" {
  description = "(Required) The name of DNS zone. Must be unique within the project"
  type        = string
}

# variable "dns_name" {
#   description = "(Required) The DNS name of this managed zone, for instance: example.com"
#   type        = string
# }

# variable "network_url" {
#   description = "(Required) The id or fully qualified URL of the VPC network to bind to"
#   type        = string
# }

# variable "dns_record_name" {
#   description = "(Required) The DNS name this record set will apply to"
#   type        = string
# }
