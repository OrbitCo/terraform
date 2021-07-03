##############################
## Azure App Service - Main ##
##############################


# Create the App Service
resource "azurerm_app_service" "mliadov-01" {
  name                = "appserviceTwo"
  location            = "Central US"
  resource_group_name = "group"
 app_service_plan_id="planOne"


}
