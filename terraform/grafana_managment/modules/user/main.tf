resource "grafana_user" "user" {
  email    = var.user_email
  name     = var.user_name
  login    = var.user_login
  password = var.user_password
  is_admin = var.user_is_admin
}

resource "grafana_folder" "user_folder" {
  title = var.user_name
}

resource "grafana_folder_permission" "folder_permission" {
  folder_uid = grafana_folder.user_folder.uid

  permissions {
    permission = "Edit"
    user_id    = grafana_user.user.id
  }
}
