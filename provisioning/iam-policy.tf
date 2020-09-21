resource "google_project_iam_binding" "monitoring_viwer_role" {
    role = "roles/monitoring.viewer"

    members = [
        "serviceAccount:${google_service_account.gke_service_account.email}",
    ]
}

resource "google_project_iam_binding" "monitoring_metric_writer_role" {
    role = "roles/monitoring.metricWriter"

    members = [
      "serviceAccount:${google_service_account.gke_service_account.email}",
      "serviceAccount:${google_service_account.bastion_service_account.email}",
      "serviceAccount:${google_service_account.secure_vm_service_account.email}"
    ]
}

resource "google_project_iam_binding" "monitoring_log_writer_role" {
    role = "roles/logging.logWriter"

    members = [
      "serviceAccount:${google_service_account.gke_service_account.email}",
    ]
}

resource "google_project_iam_binding" "scheduler_policy" {
    role = "roles/container.clusterAdmin"

    members = [
        "serviceAccount:${google_service_account.scheduler_service_account.email}",
    ]
}

resource "google_project_iam_binding" "bastion_admin" {
  role    = "roles/iam.securityAdmin"
  members  = ["serviceAccount:${google_service_account.bastion_service_account.email}"]
}
