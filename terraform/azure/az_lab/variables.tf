variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-lab"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "vm_username" {
  description = "value for the username"
  type        = string
}

variable "vm_password" {
  description = "value for the password"
  type        = string
}

variable "vm_autoshutdown_enabled" {
  description = "enabling the automatic shutdown of the vm"
  type        = bool
  default     = false
}

variable "vm_autoshutdown_notification_enabled" {
  description = "enabling the notification when the vm shutdown"
  type        = bool
  default     = false
}

variable "vm_autoshutdown_webhook" {
  description = "webhook url"
  type        = string
  default     = ""
}
