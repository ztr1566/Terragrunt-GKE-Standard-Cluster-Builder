locals {
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project_id  = local.env_vars.locals.project_id
  region      = local.env_vars.locals.region
  bucket_name = local.env_vars.locals.bucket_name
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "${local.project_id}"
  region  = "${local.region}"
}
EOF
}

remote_state {
  backend = "gcs"
  config = {
    bucket   = "${local.bucket_name}"
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    project  = "${local.project_id}"
    location = "${local.region}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}