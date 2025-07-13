variable "grafana_db_url" {
  description = "The database URL for Grafana"
  type        = string
  default     = ""
}

variable "namespace_name" {
  description = "The namespace in which to deploy the Grafana stack"
  type        = string
  default     = "grafana"
}

variable "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "CA certificate for the Kubernetes cluster"
  type        = string
  sensitive   = true
}

variable "k8s_token" {
  description = "Client token for the Kubernetes cluster"
  type        = string
  sensitive   = true
}
