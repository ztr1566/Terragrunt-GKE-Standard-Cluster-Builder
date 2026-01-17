resource "google_compute_network" "gke_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.gke_network.id
  region        = var.region

  depends_on = [google_compute_network.gke_network]
  secondary_ip_range {
    range_name    = "gke-pod-cidr"
    ip_cidr_range = var.pod_cidr_range
  }

  secondary_ip_range {
    range_name    = "gke-service-cidr"
    ip_cidr_range = var.service_cidr_range
  }
}

resource "google_compute_router" "gke_router" {
  name       = "${var.network_name}-router"
  region     = var.region
  network    = google_compute_network.gke_network.id
  depends_on = [google_compute_subnetwork.gke_subnetwork]
}

resource "google_compute_router_nat" "gke_nat" {
  name                               = "${var.network_name}-nat"
  router                             = google_compute_router.gke_router.name
  region                             = var.region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
  depends_on                         = [google_compute_router.gke_router]
}


resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.network_name}-pip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.gke_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.gke_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  lifecycle {
    prevent_destroy = false
  }
}
