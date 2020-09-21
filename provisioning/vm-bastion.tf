resource "google_compute_address" "bastion_address" {
  project      = var.project_name
  name         = "bastion-external-address"
  address_type = "EXTERNAL"
  region       = var.default_region
}

resource "google_compute_instance" "bastion" {
  project      = var.project_name
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = var.default_zone

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  can_ip_forward = true

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = google_compute_address.bastion_address.address
    }
  }

  metadata = {
    enable-oslogin = true
  }

  service_account {
    email  = google_service_account.bastion_service_account.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
