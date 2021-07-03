##############################
## Azure App Service - Main ##
##############################


# Create the App Service
resource "azurerm_app_service" "appservice12" {
  name                = "appserviceTwo"
  location            = "Central US"
  resource_group_name = "mliadov-01"
 app_service_plan_id = azurerm_app_service_plan.service-plan.id


}
