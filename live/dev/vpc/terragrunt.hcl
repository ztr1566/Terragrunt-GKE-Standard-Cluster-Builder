include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/vpc"
}

locals {
  env_vars  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  network_name       = "${local.env_vars.locals.env_name}-gke-network"
  subnetwork_name    = "${local.env_vars.locals.env_name}-gke-subnet"
  ip_cidr_range      = local.env_vars.locals.ip_cidr_range
  region             = local.env_vars.locals.region
  pod_cidr_range     = local.env_vars.locals.pod_cidr_range
  service_cidr_range = local.env_vars.locals.service_cidr_range
}