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
    client_certificate     = base64decode(var.cluster_client_certificate)
    client_key             = base64decode(var.cluster_client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  client_certificate     = base64decode(var.cluster_client_certificate)
  client_key             = base64decode(var.cluster_client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}
