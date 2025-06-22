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
    config_path = "~/.kube/home_cluster.yml"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/home_cluter_admin.yml"
}
