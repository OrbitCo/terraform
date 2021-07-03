##############################
## Azure App Service - Main ##
##############################
# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "ASP-mliadov01-98e6 (P1v2: 1)"
   location            = "Central US"
  resource_group_name = "mliadov-01"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

# Create the App Service
resource "azurerm_app_service" "appservice12" {
  name                = "appserviceTwo"
  location            = "Central US"
  resource_group_name = "mliadov-01"
 app_service_plan_id = azurerm_app_service_plan.service-plan.id


}
