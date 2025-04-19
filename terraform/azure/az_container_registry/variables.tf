variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-img-regisry"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "container_registry_name" {
  description = "value for the name of the container registry"
  type        = string
  default     = "neryolab"
}

variable "registry_user" {
  description = "value for the name of the registry user"
  type        = string
  sensitive   = true
}

variable "registry_password" {
  description = "value for the name of the registry password"
  type        = string
  sensitive   = true
}
