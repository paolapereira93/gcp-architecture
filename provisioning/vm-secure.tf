resource "google_compute_instance" "secure-vm" {
  project      = var.project_name
  name         = "secure-vm"
  machine_type = "n1-standard-1"
  zone         = var.default_zone
  
  tags = ["secure-vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata = {
    enable-oslogin = true
  }

  network_interface {
    network = google_compute_network.vpc_network.name
  }
  
  service_account {
    email  = google_service_account.secure_vm_service_account.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
