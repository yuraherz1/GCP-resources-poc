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

# variable "ip_configuration" {
#   description = "The ip_configuration settings subblock"
#   type = object({
#     authorized_networks                           = optional(list(map(string)), [])
#     ipv4_enabled                                  = optional(bool, true)
#     private_network                               = optional(string)
#     ssl_mode                                      = optional(string)
#     allocated_ip_range                            = optional(string)
#     enable_private_path_for_google_cloud_services = optional(bool, false)
#     psc_enabled                                   = optional(bool, false)
#     psc_allowed_consumer_projects                 = optional(list(string), [])
#   })
#   default = {}
# }

#allowed-consumer-project-name

# variable "eks_cluster_name" {
#   description = "The EKS Cluster Name"
#   type        = string
#   # default     = "k8s-kira-demo1"
# }

# variable "eks_addons_version" {
#   description = "EKS Add-on versions, will be used in the EKS module for the cluster_addons"
#   type        = map(string)
# }

# variable "eks_params" {
#   description = "EKS cluster itslef parameters"
#   type = object({
#     cluster_endpoint_public_access = bool
#     cluster_enabled_log_types      = list(string)
#   })
# }

# variable "eks_managed_node_group_params" {
#   description = "EKS Managed NodeGroups setting, one item in the map() per each dedicated NodeGroup"
#   type = map(object({
#     min_size                   = number
#     max_size                   = number
#     desired_size               = number
#     instance_types             = list(string)
#     capacity_type              = string
#     taints                     = set(map(string))
#     max_unavailable_percentage = number
#   }))
# }