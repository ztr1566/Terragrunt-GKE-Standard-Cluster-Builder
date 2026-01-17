resource "google_container_cluster" "primary" {
  name                     = "${var.env_prefix}-gke-cluster"
  location                 = var.location
  network                  = var.vpc_network_id
  subnetwork               = var.vpc_subnetwork_id
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  deletion_protection      = false
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pod-cidr"
    services_secondary_range_name = "gke-service-cidr"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}


resource "google_container_node_pool" "primary_nodes" {
  name       = "main-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = var.node_count
  location   = var.location

  node_config {
    service_account = var.gke_nodes_sa_email
    machine_type    = "e2-medium"
    disk_size_gb    = 40
    disk_type       = "pd-standard"
    labels          = { "env" = var.env_prefix }
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
