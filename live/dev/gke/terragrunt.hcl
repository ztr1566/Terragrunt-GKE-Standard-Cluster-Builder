include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_network_id    = "projects/mock/global/networks/mock-vpc"
    vpc_subnetwork_id = "projects/mock/regions/mock/subnetworks/mock-subnet"
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

dependency "iam_base" {
  config_path = "../iam-base"

  mock_outputs = {
    gke_nodes_sa_email = "mock-sa@mock-project.iam.gserviceaccount.com"
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate", "apply", "init"]
}

terraform {
  source = "../../../modules/gke"
}

inputs = {
  project_id             = local.env_vars.locals.project_id
  location               = local.env_vars.locals.location
  env_prefix             = local.env_vars.locals.env_name
  vpc_network_id         = dependency.vpc.outputs.vpc_network_id
  vpc_subnetwork_id      = dependency.vpc.outputs.vpc_subnetwork_id
  gke_nodes_sa_email     = dependency.iam_base.outputs.gke_nodes_sa_email
  node_count             = local.env_vars.locals.node_count
  master_ipv4_cidr_block = local.env_vars.locals.master_ipv4_cidr_block
}