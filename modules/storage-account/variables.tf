variable "namespace"{
  type ="string"
  description = " Name of storage account"

}
variable "location" {
  type = "string"
  description = "location of storage account"
}

variable "resource_group_name"{
  type = "string"
  description = "resource group name"

}
variable "storage_account_name"{
  type ="string"
  description = "name of storage account"
}

# variable "primary_connection_string" {
#   type = "string"
#   description = "the connection string associated with primary location"
# }