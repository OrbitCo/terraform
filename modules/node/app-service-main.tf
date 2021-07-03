##############################
## Azure App Service - Main ##
##############################


# Create the App Service
resource "azurerm_app_service" "appservice12" {
  name                = "appserviceTwo"
  location            = "Central US"
  resource_group_name = "mliadov-01"
 app_service_plan_id = "e480a2a1-a59c-4b77-aa21-ffcbc8243f5f"


}
