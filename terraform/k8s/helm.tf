resource "helm_release" "example" {
  count = length(var.namespaces)

  name  = "cert-issuer"
  chart = "./cert_issuer"

  namespace        = var.namespaces[count.index].name
  create_namespace = false

  set = [
    {
      name  = "secrets.email"
      value = var.cert_issuer_email
    },
    {
      name  = "secrets.api_token"
      value = var.cert_issuer_api_token
    }
  ]
}
