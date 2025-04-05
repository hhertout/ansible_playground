output "user_created" {
  value = "User ${grafana_user.user.name} created with ID ${grafana_user.user.id}"
}

output "folder_created" {
  value = "Folder ${grafana_folder.user_folder.title} created with UID ${grafana_folder.user_folder.uid}"
}

output "folder_permission_created" {
  value = "Folder permission for user ${grafana_user.user.name} created"
}
