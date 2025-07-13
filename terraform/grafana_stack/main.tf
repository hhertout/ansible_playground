resource "helm_release" "example" {
  name  = "grafana"
  chart = "./grafana"

  namespace        = "robsgbl0"
  create_namespace = false

  set = [
    {
      name  = "grafana.secret_name"
      value = "grafana-secret"
    },
    {
      name  = "namespace"
      value = var.namespace_name
    },
    {
      name  = "secrets.grafana.db_url"
      value = base64encode(var.grafana_db_url)
    }
  ]
}
