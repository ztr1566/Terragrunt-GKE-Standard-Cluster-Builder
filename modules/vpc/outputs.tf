output "vpc_network_id" {
  value = google_compute_network.gke_network.id
}

output "vpc_subnetwork_id" {
  value = google_compute_subnetwork.gke_subnetwork.id
}
