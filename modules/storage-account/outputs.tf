output "primary_connection_string" {
value = azurerm_storage_account.storage.primary_connection_string
}

output "resource_group_name" {
value = azurerm_storage_account.storage.resource_group_name  
}

output "saname" {
  value = azurerm_storage_account.storage.name
  }