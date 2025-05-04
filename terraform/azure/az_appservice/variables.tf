variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-appservice-fra"
}

variable "app_name" {
  type = string
}

variable "app_https_only" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(string)
}

variable "enable_ci" {
  type    = bool
  default = false
}

variable "docker_image_name" {
  type = string
}

variable "docker_registry_url" {
  type    = string
  default = "https://index.docker.io"
}

variable "docker_private_repository" {
  type    = bool
  default = false
}

variable "docker_registry_creds" {
  type = object({
    username = string
    password = string
  })

  default = {
    username = ""
    password = ""
  }
}
