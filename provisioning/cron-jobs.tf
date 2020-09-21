resource "google_cloud_scheduler_job" "scale_node_pool_up" {
  name             = "test-job"
  description      = "test http job"
  schedule         = "0 7 * * 1-5"
  time_zone        = "America/Sao_Paulo"

  http_target {
    http_method = "POST"
    uri         = "https://container.googleapis.com/v1beta1/projects/${var.project_name}/zones/${var.default_zone}/clusters/${google_container_cluster.primary.name}/nodePools/${google_container_node_pool.node_pool.name}/setSize"

    oauth_token {
      service_account_email = google_service_account.scheduler_service_account.email
    }

    body = base64encode(<<-EOT
    {
      "nodeCount": "3"
    }
    EOT
    )
  }
}

resource "google_cloud_scheduler_job" "scale_node_pool_down" {
  name             = "scale-down"
  description      = "test http job"
  schedule         = "0 19 * * 1-5"
  time_zone        = "America/Sao_Paulo"

  http_target {
    http_method = "POST"
    uri         = "https://container.googleapis.com/v1beta1/projects/${var.project_name}/zones/${var.default_zone}/clusters/${google_container_cluster.primary.name}/nodePools/${google_container_node_pool.node_pool.name}/setSize"

    oauth_token {
      service_account_email = google_service_account.scheduler_service_account.email
    }

    body = base64encode(<<-EOT
    {
      "nodeCount": "0"
    }
    EOT
    )
  }

}