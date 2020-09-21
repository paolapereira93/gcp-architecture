resource "google_compute_firewall" "bastion_ingress_vpc_firewall" {
  name    = "frontend-ingress-vpc-firewall"
  project = var.project_name
  network = google_compute_network.vpc_network.name
  direction = "INGRESS"
  
  target_tags = ["bastion"]

  source_ranges = ["10.250.0.0/16", "191.240.220.21"]

  priority = 900

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_firewall" "secure_vm_bastion_comunication_rule" {
  name    = "internal-frontend-vpc-firewall"
  project = var.project_name
  network = google_compute_network.vpc_network.name
  direction = "INGRESS"
  
  target_tags = ["secure-vm"]
  source_tags = ["bastion"]

  priority = 900

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}
