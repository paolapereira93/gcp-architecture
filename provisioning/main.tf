provider "google" {
  version = "3.5.0"

  project = var.project_name
  zone    = var.default_zone
  region  = var.default_region
}

resource "google_compute_network" "vpc_network" {
  name        = "vpc-network"
  description = "po_challenge project private network"
  project     = var.project_name

  # default address range = 10.128.0.0/9 
  auto_create_subnetworks = true
  routing_mode            = "GLOBAL"
}
