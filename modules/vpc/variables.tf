variable "pod_cidr_range" {
  type        = string
  description = "Range for Kubernetes Pods"
}

variable "service_cidr_range" {
  type        = string
  description = "Range for Kubernetes Services"
}

variable "network_name" {
  type        = string
  description = "Name for the VPC network"
}

variable "subnetwork_name" {
  type        = string
  description = "Name for the VPC subnetwork"
}

variable "ip_cidr_range" {
  type        = string
  description = "Range for the VPC subnetwork"
}

variable "region" {
  type        = string
  description = "Region for the VPC subnetwork"
}