terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.1"
    }
  }
}

provider "helm" {
  kubernetes = {
    host                   = var.cluster_endpoint
    token                  = var.k8s_token
    namespace              = var.namespace_name
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}
