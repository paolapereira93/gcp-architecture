resource "google_service_account" "gke_service_account" {
  account_id   = "gke-sa"
  display_name = "GKE service account"
}

resource "google_service_account" "scheduler_service_account" {
  account_id   = "scheduler-sa"
  display_name = "Scheduler service account"
}

resource "google_service_account" "bastion_service_account" {
  account_id   = "bastion-sa"
  display_name = "Bastion service account"
}

resource "google_service_account" "secure_vm_service_account" {
  account_id   = "secure-vm-sa"
  display_name = "Secure (internal) vms service account"
}
