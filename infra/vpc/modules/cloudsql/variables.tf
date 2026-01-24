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