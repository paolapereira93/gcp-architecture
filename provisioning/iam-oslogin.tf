# resource "google_os_login_ssh_public_key" "cache" {
#   user =  "paolamartinspe@gmail.com"
#   key  = file("~/.ssh/id_rsa.pub")
# }

resource "google_project_iam_binding" "service_account_user_binding" {
    role = "roles/iam.serviceAccountUser"

    members = [
        "user:${var.user}",
    ]
}

resource "google_project_iam_binding" "os_login_binding" {
    role = "roles/compute.osLogin"

    members = [
        "user:${var.user}",
    ]
}

resource "google_project_iam_binding" "os_admin_login_binding" {
    role = "roles/compute.osAdminLogin"

    members = [
        "user:${var.user}",
    ]
}