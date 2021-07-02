# Azure requires some resources to have globally unique names
# Configure a random string to use as a suffix
# for these resources

resource "random_string" "uid" {
  special = false
  upper   = false
  length  = 8
}

# Create Resource Groups for all the environments
resource "azurerm_resource_group" "digitalsecurity" {
  name     = "rg-${var.namespace}-digsec"
  location = var.location
}

module "storage-account"{
  source                    = "./modules/storage-account"
  namespace                 = var.storage_account_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.digitalsecurity.name
  storage_account_name      = var.namespace

}

module "keyvault"{
  source              = "./modules/keyvault"
  namespace           = "kv-${var.namespace}-digsec-${var.location}"
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  location            = azurerm_resource_group.digitalsecurity.location


  tags                = {
    environment = "${var.environment}"
  }


  policies = {
    full = {
      tenant_id               = var.azure-tenant-id
      object_id               = var.kv-full-object-id
      key_permissions         = var.kv-key-permissions-full
      secret_permissions      = var.kv-secret-permissions-full
      certificate_permissions = var.kv-certificate-permissions-full
      storage_permissions     = var.kv-storage-permissions-full
    }
    read = {
      tenant_id               = var.azure-tenant-id
      object_id               = var.kv-read-object-id
      key_permissions         = var.kv-key-permissions-read
      secret_permissions      = var.kv-secret-permissions-read
      certificate_permissions = var.kv-certificate-permissions-read
      storage_permissions     = var.kv-storage-permissions-read
    }
  }

  secrets                = var.kv-secrets

}

# Configure an Azure Storage Container for our Account
# This account is required by Azure to support uploading of files (e.g. blobs).
resource "azurerm_storage_container" "users" {
  name                  = "cr-${var.namespace}-digsec"
  storage_account_name  = module.storage-account.saname
    container_access_type = "private"
}

resource "azurerm_storage_container" "email" {
  name                  = "cr-${var.namespace}-email-digsec"
  storage_account_name  = module.storage-account.saname
  container_access_type = "private"
}

module "cosmos-db" {
  source              = "./modules/cosmos-db"
  namespace           = var.namespace
  alt_location        = var.cosmos_db_alt_location
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  prefix              = var.prefix
  account_name        = var.namespace
}

# Resource creation for mongodatabase
resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  name                = "digsecdb"
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  account_name        = module.cosmos-db.cosmosdb_account_name
}

#test
//resource "azurerm_cosmosdb_mongo_collection" "irsOrg" {
//  name     = (var.irsOrg)
//  resource_group_name = azurerm_resource_group.digitalsecurity.name
//  account_name        = module.cosmos-db.cosmosdb_account_name
//  database_name       = azurerm_cosmosdb_mongo_database.mongodb.name
//
//  shard_key           = "irsOrgId"
//  throughput          = 500
//   index {
//          keys   = [
//               "_id",
//            ] 
//          unique = true
//        }
//          index {
//          keys   = [
//               "irsOrgId",
//            ] 
//           unique = true 
//        }
//          index {
//          keys   = [
//               "tin",
//            ] 
//           unique = false 
//        }
//}

module "eg-topic" {
  source              = "./modules/eg-topic"
  namespace           = var.namespace
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
}

resource "azurerm_container_registry" "acr" {
  name                     = "acrdevdigseceastus"
  location                 = "eastus"
  resource_group_name      = "rg-dev-digsec"
  sku                      = "Premium"
  admin_enabled            = true
  georeplication_locations = ["westus"]
}

resource "azurerm_role_assignment" "acrpull_appservice" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_app_service.app_service_registerapi.identity.0.principal_id
}

# Resources for register API
resource "azurerm_app_service_plan" "app_plan_registerapi" {
  name                = "asp-${var.namespace}-registerapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "app_service_registerapi" {
  name                = "as-${var.namespace}-registerapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  app_service_plan_id = azurerm_app_service_plan.app_plan_registerapi.id
  https_only          = true

  site_config {
    linux_fx_version  = "DOCKER|${azurerm_container_registry.acr.name}.azurecr.io/register-api:${var.namespace}-latest"
    health_check_path = "/actuator/health"
    http2_enabled     = "true"
    always_on         = "true"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.name}.azurecr.io"
    DOCKER_ENABLE_CI                = "true"
    DOCKER_REGISTRY_SERVER_USERNAME = "acrdevdigseceastus"
    DOCKER_REGISTRY_SERVER_PASSWORD = "dYxeRgELLes1LR7aW29i+qhwZUZZgs2R"

    "MAIN_CLASS" = "com.optum.ds.functions.MainApplication"
    "linkhealth_baseurl" = "${var.linkhealth_baseurl}"
    "linkhealth_auth" = "${var.linkhealth_auth}"
    "client_secret" = "${var.client_secret}"
    "client_id" = "${var.client_id}"
    "memberSummary_url" = "${var.memberSummary_url}"
    "linkhealth_taf_baseurl" = "${var.linkhealth_taf_baseurl}"
    "linkhealth_taf_auth" = "${var.linkhealth_taf_auth}"
    "client_taf_secret" = "${var.client_taf_secret}"
    "client_taf_id" = "${var.client_taf_id}"
    "TAFCallService_url" = "${var.TAFCallService_url}"
    "request_maxCheckCount" = "${var.request_maxCheckCount}"
    "SENDGRID_API_KEY" = "${var.SENDGRID_API_KEY}"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.ai_registerapi.instrumentation_key}"
    "storageacc_connection_string" = "${var.storageacc_connection_string}"
    "storage_container_name" = "${var.storage_container_name}"
    "pes_event_key"= "${var.pes_event_key}"
    "email_event_key"="${var.email_event_key}"
    "pes_event_endpoint"="${var.pes_event_endpoint}"
    "email_event_endpoint"="${var.email_event_endpoint}"
    "client_pes_id"="${var.client_pes_id}"
    "client_pes_secret"="${var.client_pes_secret}"
    "token_pes_baseurl"="${var.token_pes_baseurl}"
    "token_pes_auth"="${var.token_pes_auth}"
    "PESCallService_url"="${var.PESCallService_url}"
    "pes_token_url"="${var.pes_token_url}"
    "publisherEndPoint_url"="${var.publisherEndPoint_url}"

    "management_endpoints_web_base_path"="${var.management_endpoints_web_base_path}"
    "mongodb_connection_string"="${var.mongodb_connection_string}"
    "mongodb_database"="${var.mongodb_database}"
    "server_port"="${var.server_port}"

    "ehCache_heapSize"="${var.ehCache_heapSize}"
    "ehCache_name"="${var.ehCache_name}"

    "claims_token_url"="${var.claims_token_url}"
    "client_claims_id"="${var.client_claims_id}"
    "client_claims_secret"="${var.client_claims_secret}"
    "claims_grant_type"="${var.claims_grant_type}"
    "claims_link_url"="${var.claims_link_url}"

    "taf_token_endpoint"="${var.taf_token_endpoint}"

    "tin_verify_by_payment_client_id"="${var.tin_verify_by_payment_client_id}"
    "tin_verify_by_payment_client_secret"="${var.tin_verify_by_payment_client_secret}"
    "tin_verify_by_payment_baseurl"="${var.tin_verify_by_payment_baseurl}"
    "tin_verify_by_payment_auth"="${var.tin_verify_by_payment_auth}"
    "tin_verify_by_payment_service_url"="${var.tin_verify_by_payment_service_url}"
    "tin_verify_by_payment_token_url"="${var.tin_verify_by_payment_token_url}"

    "billing_paa_tin_request_client_id"="${var.billing_paa_tin_request_client_id}"
    "billing_paa_tin_request_client_secret"="${var.billing_paa_tin_request_client_secret}"
    "billing_paa_tin_request_baseurl"="${var.billing_paa_tin_request_baseurl}"
    "billing_paa_tin_request_auth"="${var.billing_paa_tin_request_auth}"
    "billing_paa_tin_request_service_url"="${var.billing_paa_tin_request_service_url}"
    "taf_success_status_codes"="${var.taf_success_status_codes}"
    "taf_failed_status_codes_newTaxID"="${var.taf_failed_status_codes_newTaxID}"
    "taf_failed_status_codes_reviewStatus"="${var.taf_failed_status_codes_reviewStatus}"

}

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "ai_registerapi" {
  name                = "ai-${var.namespace}-registerapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  application_type    = "web"
} 

# Resources for access API
resource "azurerm_app_service_plan" "app_plan_accessapi" {
  name                = "asp-${var.namespace}-accessapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "app_service_accessapi" {
  name                = "as-${var.namespace}-accessapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  app_service_plan_id = azurerm_app_service_plan.app_plan_accessapi.id
  https_only          = true

  site_config {
    linux_fx_version  = "DOCKER|${azurerm_container_registry.acr.name}.azurecr.io/access-api:${var.namespace}-latest"
    health_check_path = "/actuator/health"
    http2_enabled     = "true"
    always_on         = "true"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.name}.azurecr.io"
    DOCKER_ENABLE_CI                = "true"
    DOCKER_REGISTRY_SERVER_USERNAME = "acrdevdigseceastus"
    DOCKER_REGISTRY_SERVER_PASSWORD = "dYxeRgELLes1LR7aW29i+qhwZUZZgs2R"

    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.ai_accessapi.instrumentation_key}"
    "management_endpoints_web_base_path"="${var.management_endpoints_web_base_path}"
    "mongodb_connection_string"="${var.mongodb_connection_string}"
    "mongodb_database"="${var.mongodb_database}"
    "server_port"="${var.server_port}"  

    "client_pes_id"="${var.client_pes_id}"
    "client_pes_secret"="${var.client_pes_secret}"
    "pes_token_url"="${var.pes_token_url}"
    "pes_pdr_tinsearch_url"="${var.pes_pdr_tinsearch_url}"
    "pes_callcount_max"="${var.pes_callcount_max}"

    "ehCache_heapSize"="${var.ehCache_heapSize}"
    "ehCache_name"="${var.ehCache_name}"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "ai_accessapi" {
  name                = "ai-${var.namespace}-accessapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  application_type    = "web"
}

# Resources for User Management API
resource "azurerm_app_service_plan" "app_plan_usermanagementapi" {
  name                = "asp-${var.namespace}-usermanagementapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "app_service_usermanagementapi" {
  name                = "as-${var.namespace}-usermanagementapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  app_service_plan_id = azurerm_app_service_plan.app_plan_usermanagementapi.id
  https_only          = true

  site_config {
    linux_fx_version  = "DOCKER|${azurerm_container_registry.acr.name}.azurecr.io/user-management-api:${var.namespace}-latest"
    health_check_path = "/actuator/health"
    http2_enabled     = "true"
    always_on         = "true"
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.name}.azurecr.io"
    DOCKER_ENABLE_CI                = "true"
    DOCKER_REGISTRY_SERVER_USERNAME = "acrdevdigseceastus"
    DOCKER_REGISTRY_SERVER_PASSWORD = "dYxeRgELLes1LR7aW29i+qhwZUZZgs2R"

    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.ai_usermanagementapi.instrumentation_key}"
    "management_endpoints_web_base_path"="${var.management_endpoints_web_base_path}"
    "mongodb_connection_string"="${var.mongodb_connection_string}"
    "mongodb_database"="${var.mongodb_database}"
    "server_port"="${var.server_port}"

	"SENDGRID_API_KEY" = "${var.SENDGRID_API_KEY}"
    
    # "ehCache_heapSize"="${var.ehCache_heapSize}"
    # "ehCache_name"="${var.ehCache_name}"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "ai_usermanagementapi" {
  name                = "ai-${var.namespace}-usermanagementapi-digsec-${var.location}"
  location            = azurerm_resource_group.digitalsecurity.location
  resource_group_name = azurerm_resource_group.digitalsecurity.name
  application_type    = "web"
} 
