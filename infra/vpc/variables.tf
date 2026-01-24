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