provider "azurerm" {
  features {}
}
# Resource creation for event grid topic email
resource "azurerm_eventgrid_topic" "eventgridemailtopic" {
  name                = "evgt-email-${var.namespace}-digsec"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Resource creation for event grid topic tinfetch
resource "azurerm_eventgrid_topic" "eventgridtintopic" {
  name                = "evgt-tinfetch-${var.namespace}-digsec"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Resource creation for event grid topic pescall
resource "azurerm_eventgrid_topic" "eventgridpestopic" {
  name                = "evgt-pescall-${var.namespace}-digsec"
  location            = var.location
  resource_group_name = var.resource_group_name
}
