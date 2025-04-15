variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-database"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "cosmodb_db_name" {
  description = "Cosmos DB database name"
  type        = string
}
