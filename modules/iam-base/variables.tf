variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "account_id" {
  description = "The service account ID for GKE nodes"
  type        = string
  default     = "gke-nodes-sa"
}

variable "display_name" {
  description = "The display name for the GKE nodes service account"
  type        = string
  default     = "GKE Nodes Service Account"
}
