variable "project_id" { type = string }
variable "location" { type = string }
variable "env_prefix" { type = string }
variable "vpc_network_id" { type = string }
variable "vpc_subnetwork_id" { type = string }
variable "gke_nodes_sa_email" { type = string }
variable "node_count" { type = number }
variable "master_ipv4_cidr_block" { type = string }
