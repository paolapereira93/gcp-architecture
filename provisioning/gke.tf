resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = var.default_zone
  network  = google_compute_network.vpc_network.name  

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  name       = "node-pool"
  location   = var.default_zone
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible     = true
    machine_type    = "n1-standard-1"
    service_account = google_service_account.gke_service_account.email

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
