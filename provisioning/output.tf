output "bastion_ip" {
    value = google_compute_address.bastion_address.address
}