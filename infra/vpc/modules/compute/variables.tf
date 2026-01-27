variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "instance_name" {
  description = "The name of Compute Instance"
  type        = string
}

variable "instance_type" {
  description = "The type of Compute Instance"
  type        = string
}

variable "instance_zone" {
  description = "The zone where Compute Instance located"
  type        = string
}

variable "instance_image" {
  description = "The image from which to initialize this disk"
  type        = string
}

variable "instance_disk_size" {
  description = "The size of the image in gigabytes"
  type        = string
}

variable "instance_disk_type" {
  description = "The GCE disk type. Such as pd-standard, pd-balanced or pd-ssd"
  type        = string
}

variable "instance_network" {
  description = "The network name where Compute Instance located"
  type        = string
}
