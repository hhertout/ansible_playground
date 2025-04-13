variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "cosmodb_db_name" {
  description = "Cosmos DB database name"
  type        = string
}
