variable "region" {
  description = "The region of PSC"
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "psc_allocated_ip_name" {
  description = "(Required) Name of the resource for the reserve IP address of the PSC"
  type        = string
}

variable "psc_allocated_ip" {
  description = "The IP reserve address of the PSC"
  type        = string
}

variable "psc_subnetwork" {
  description = "The subnetwork in which to reserve the address"
  type        = string
}

variable "psc_forwarding_rule_name" {
  description = "(Required) Name of the resource for the PSC forwarding rule"
  type        = string
}

variable "psc_forwarding_network_name" {
  description = "The network for Private Service Connect forwarding rules"
  type        = string
}

variable "psc_target" {
  description = "The URL of the target resource to receive the matched traffic"
  type        = string
}

variable "psc_dns_zone_name" {
  description = "(Required) The name of DNS zone. Must be unique within the project"
  type        = string
}

variable "dns_name" {
  description = "(Required) The DNS name of this managed zone, for instance: example.com"
  type        = string
}

variable "network_url" {
  description = "(Required) The id or fully qualified URL of the VPC network to bind to"
  type        = string
}

variable "dns_record_name" {
  description = "(Required) The DNS name this record set will apply to"
  type        = string
}
