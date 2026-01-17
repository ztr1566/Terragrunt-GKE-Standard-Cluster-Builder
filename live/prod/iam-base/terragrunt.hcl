include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/iam-base"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  project_id   = local.env_vars.locals.project_id
  account_id   = "gke-nodes-sa"
  display_name = "GKE Nodes Service Account"
}