include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "gke" {
  config_path = "../gke"

  mock_outputs = {
    cluster_name = "mock-cluster-dev"
  }

  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs_allowed_terraform_commands = ["plan", "validate", "apply", "init"]
}

terraform {
  source = "../../../modules/iam-workload"
}

inputs = {
  project_id   = local.env_vars.locals.project_id
  gsa_name     = local.env_vars.locals.gsa_name
  ksa_name     = local.env_vars.locals.ksa_name
  namespace    = local.env_vars.locals.namespace
  cluster_name = dependency.gke.outputs.cluster_name
}