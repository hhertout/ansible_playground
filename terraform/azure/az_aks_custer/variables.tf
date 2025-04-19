variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-aks-cluster"
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
  default     = "France Central"
}

variable "container_registry_name" {
  description = "value for the name of the container registry"
  type        = string
  default     = "neryolab"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "neryolab-aks"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "neryolab"
}

variable "node_pool_name" {
  description = "Name of the node pool"
  type        = string
  default     = "master"
}

variable "node_pool_count" {
  description = "Number of nodes in the node pool"
  type        = number
  default     = 1
}
