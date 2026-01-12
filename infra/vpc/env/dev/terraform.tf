terraform {
  required_version = "~> 1.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.15.0" # Pin provider version to avoid breaking changes
    }
  }

  backend "gcs" {
    bucket = "484109-infra-demo-terraform-state"
    prefix = "dev/infra-demo-terraform.tfstate"
  }
}

provider "google" {
  project = "infra-demo-484109"
  region  = "europe-central2"
  zone    = "europe-central2-a"
}


###
# terraform {
#   required_version = "~> 1.12"

#   backend "s3" {
#     bucket       = "978450107068-terraform-state"
#     key          = "eks-demo/terraform.tfstate"
#     region       = "us-east-1"
#     encrypt      = true
#     use_lockfile = true # Enable native S3 state locking
#     # dynamodb_table = "your-dynamodb-table" # No longer required with use_lockfile = true
#   }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 3.1.1"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.38"
#     }
#     kubectl = {
#       source  = "alekc/kubectl"
#       version = ">= 2.1.3"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = ">= 3.7.2"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
# }

# provider "helm" {
#   kubernetes = {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#     exec = {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#     }
#   }
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }

# provider "kubectl" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   load_config_file       = false
#   # apply_retry_count      = 5
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }