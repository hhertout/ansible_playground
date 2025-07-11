variable "namespaces" {
  description = "List of namespaces to create in the Kubernetes cluster"
  type = list(object({
    name = string
    user = string
    quota = object({
      request_cpu    = optional(string, "4")
      request_memory = optional(string, "4Gi")
      limit_cpu      = optional(string, "8")
      limit_memory   = optional(string, "8Gi")
      limit_storage  = optional(string, "5Gi")
      pvc            = optional(string, "5")
      pods           = optional(string, "10")
    })
    limit_range = object({
      limit_cpu      = optional(string, "500m")
      limit_memory   = optional(string, "512Mi")
      request_cpu    = optional(string, "250m")
      request_memory = optional(string, "256Mi")
    })
  }))
  default = []
}


variable "cert_issuer_email" {
  description = "Email for the certificate issuer"
  type        = string
}

variable "cert_issuer_api_token" {
  description = "API token for the certificate issuer"
  type        = string
  sensitive   = true
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

variable "cluster_client_certificate" {
  description = "Client certificate for the Kubernetes cluster"
  type        = string
  sensitive   = true
}

variable "cluster_client_key" {
  description = "Client key for the Kubernetes cluster"
  type        = string
  sensitive   = true
}
