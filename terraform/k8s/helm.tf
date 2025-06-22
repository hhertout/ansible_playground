resource "helm_release" "example" {
  name  = "my-local-chart"
  chart = "./chart"

  namespace        = "dsmfgbl0"
  create_namespace = false
}
