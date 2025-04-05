variable "users" {
  type = list(object({
    "user_login" = string
    "user_name"  = string

    "user_email"    = string
    "user_password" = string
    "user_is_admin" = optional(bool, false)
  }))
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
