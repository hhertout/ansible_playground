terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.22.2"
    }
  }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

variable "grafana_url" {
  description = "URL of the Grafana instance"
  type        = string
}

variable "grafana_auth" {
  description = "Grafana API key for authentication"
  type        = string
  sensitive   = true
}
