provider "azurerm" {
  features {}
}
# Resource creation for cosmodb
resource "azurerm_cosmosdb_account" "cosmosmongo" {
  name                = "cosmos-${var.namespace}-digsec"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      capabilities
    ]
  }
  capabilities {
    name = "MongoDBv3.4"
  }
  consistency_policy {
    consistency_level       = "Strong"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }
  geo_location {
    location          = var.location
    failover_priority = 0
  }
}
