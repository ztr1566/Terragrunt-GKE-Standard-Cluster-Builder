output "gke_nodes_sa_email" {
  description = "The email of the service account created for GKE nodes"
  value       = google_service_account.gke_nodes.email
}

output "gke_nodes_sa_name" {
  description = "The fully qualified name of the service account"
  value       = google_service_account.gke_nodes.name
}
