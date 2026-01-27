# variable "environment" {
#   description = "Environment name"
#   type        = string
# }

# variable "project_id" {
#   description = "The Google Cloud project ID where data workflows is stored"
#   type        = string
# }

variable "data_project_id" {
  description = "The Google Cloud project ID where data workflows is stored"
  type        = string
}

variable "region" {
  description = "The region for Firebase and workflow"
  type        = string
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
  description = "The tier for the master Cloud SQL instance"
  type        = string
}

variable "availability_type" {
  description = "The availability type for the master Cloud SQL instance"
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

variable "disk_size" {
  description = "The tier for the master Cloud SQL instance"
  type        = string
}

# variable "project_id" {
#   description = "The GCP project ID where the bucket will be created."
#   type        = string
# }

# variable "bucket_name" {
#   description = "The name of the storage bucket."
#   type        = string
# }

# variable "location" {
#   description = "The location of the bucket."
#   type        = string
#   default     = "europe-west2"
# }

# variable "storage_class" {
#   description = "The storage class of the bucket."
#   type        = string
#   default     = "STANDARD"
# }

# variable "versioning" {
#   description = "Enable versioning for the bucket."
#   type        = bool
#   default     = true
# }

# variable "lifecycle_rule_age" {
#   description = "The age of objects to retain before applying lifecycle rules."
#   type        = number
#   default     = 365
# }

# variable "bucket_sa_iam_role_bindings_map" {
#   description = "Map of roles binded to service accounts"
#   type        = map(list(string))
#   default     = {}
# }


# var.project_id_consumers