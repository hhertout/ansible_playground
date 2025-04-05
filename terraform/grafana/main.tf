module "user" {
  source = "./modules/user"

  count        = length(var.users)
  grafana_auth = var.grafana_auth
  grafana_url  = var.grafana_url

  user_login    = var.users[count.index].user_login
  user_name     = var.users[count.index].user_name
  user_email    = var.users[count.index].user_email
  user_password = var.users[count.index].user_password
}
