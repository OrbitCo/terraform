output "cosmos-db-id" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.id}"
}

output "cosmos-db-endpoint" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.endpoint}"
}

output "cosmos-db-endpoints_read" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.read_endpoints}"
}

output "cosmos-db-endpoints_write" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.write_endpoints}"
}

output "cosmos-db-primary_key" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.primary_master_key}"
}

output "cosmos-db-secondary_key" {
  value = "${azurerm_cosmosdb_account.cosmosmongo.secondary_master_key}"
}

output "cosmosdb_connectionstrings" {
  value = azurerm_cosmosdb_account.cosmosmongo.connection_strings
}

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.cosmosmongo.name
}