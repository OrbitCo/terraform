##############################
## Azure App Service - Main ##
##############################


# Create the App Service
resource "azurerm_app_service" "app-service-two" {
  name                = "appserviceTwo"
  location            = "Central US"
  resource_group_name = "group"
 


}
