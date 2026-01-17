output "workload_gsa_email" {
  description = "The email of the Google Service Account for the workload"
  value       = google_service_account.app_sa.email
}

output "workload_identity_pool" {
  description = "The workload identity pool ID"
  value       = "${var.project_id}.svc.id.goog"
}
