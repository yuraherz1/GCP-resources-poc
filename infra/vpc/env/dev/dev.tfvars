environment     = "dev"
project_id      = "infra-demo-qa"
data_project_id = "infra-demo-dev"

db_name          = "mysql-test-default"
database_version = "MYSQL_8_0"
tier             = "db-custom-2-4096"
ip_configuration = {
  ipv4_enabled                  = false
  psc_enabled                   = true
  psc_allowed_consumer_projects = ["infra-demo-dev", "infra-demo-qa"]
}


# eks_cluster_name = "k8s-kira-demo"
# eks_addons_version = {
#   coredns                = ""
#   kube_proxy             = ""
#   vpc_cni                = ""
#   eks-pod-identity-agent = ""

#   karpenter                    = "1.8.2"
#   aws_ebs_csi_driver           = "v1.53.0-eksbuild.1"
#   aws_load_balancer_controller = "1.16.0"
#   secrets_store_csi_driver     = "1.5.4"
#   vertical_pod_autoscaler      = "4.10.0"
#   external_dns                 = "v0.19.0-eksbuild.3"
# }