variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-database"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "value for the username"
  sensitive   = true
  type        = string
}

variable "db_password" {
  description = "value for the password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "value for the database name"
  type        = string
  sensitive   = true
  default     = "mydb"
}
