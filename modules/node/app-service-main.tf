##############################
## Azure App Service - Main ##
##############################


# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "appserviceTwo"
  location            = azurerm_resource_group.mliadov-01.location
  resource_group_name = azurerm_resource_group.mliadov-01.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id


}
