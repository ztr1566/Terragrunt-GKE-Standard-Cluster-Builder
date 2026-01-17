variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "gsa_name" {
  description = "The name of the Google Service Account for the workload"
  type        = string
}

variable "ksa_name" {
  description = "The name of the Kubernetes Service Account"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace where the KSA resides"
  type        = string
  default     = "default"
}

variable "cluster_name" {
  description = "The GKE cluster name (used for ensuring GKE exists before binding)"
  type        = string
}
