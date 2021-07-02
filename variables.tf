variable "rg_names" {
  description = "Create Resource Groups with these names"
  type        = list(string)
  default     = ["dev", "qa", "prod"]
}

variable "location" {
  description = "The Azure Region in which all resources groups should be created."
}

variable "prefix" {
  description = "The prefix which should be used for all resources"
}

variable "rg-count" {
  description = "The count represents the resource group such as dev, qa, prod."
}

variable "environment" {
  description = "The environment in which the resources should be created"
}

variable "cosmos_db_alt_location" {
  description = "This is the alternate location for the cosmos DB failover"
}

variable key_vault_name {
  description = "Name of the key vault to store the secrets"
}

variable cosmosdb_connection_string_name {
  description = "Name of the connection string for the cosmos db"
}

variable storage_account_name {
  description = "Name of the storage account name"
}

variable namespace {
  description = "namespace for the environment"
}

variable linkhealth_baseurl {
  description = "Base URL for Linkhealth"
}

variable linkhealth_auth {
  description = "Linkhealth Auth URL"
}

variable client_secret {
  description = "Client secret for Linkhealth Auth"
}

variable client_id {
  description = "client ID for Linkhealth Auth"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "kv-full-object-id" {
  type        = string
  description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for FULL access to the Azure Key Vault"
  default     = ""
}


variable "kv-read-object-id" {
  type        = string
  description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for READ access to the Azure Key Vault"
  default     = ""
}

variable "kv-key-permissions-full" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey"
  default     = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
    "recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey" ]
}


variable "kv-secret-permissions-full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]
}


variable "kv-certificate-permissions-full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = [ "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
    "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore" ]
}


variable "kv-storage-permissions-full" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default     = [ "backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
    "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update" ]
}


variable "kv-key-permissions-read" {
  type        = list(string)
  description = "List of read key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey"
  default     = [ "get", "list" ]
}

variable "kv-secret-permissions-read" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = [ "get", "list" ]
}


variable "kv-certificate-permissions-read" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = [ "get", "getissuers", "list", "listissuers" ]
}


variable "kv-storage-permissions-read" {
  type        = list(string)
  description = "List of read storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default     = [ "get", "getsas", "list", "listsas" ]
}

variable "kv-secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default     = {}
}

variable "account_name" {
  description = "name of the cosmos db account"
  
}

variable "memberSummary_url" {
  description = "memberSummary_url"
}

variable "SENDGRID_API_KEY" {
  description = "SENDGRID_API_KEY"
}

variable "linkhealth_taf_baseurl" {
  description = "linkhealth_taf_baseurl"
}

variable "linkhealth_taf_auth" {
  description = "linkhealth_taf_auth"
}

variable "client_taf_secret" {
  description = "client_taf_secret"
}

variable "client_taf_id" {
  description = "client_taf_id"
}

variable "request_maxCheckCount" {
  description ="request_maxCheckCount"
}

variable "TAFCallService_url" {
  description = "TAFCallService_url"
}

variable "storageacc_connection_string" {
  description = "storageacc_connection_string"
}

variable "storage_container_name" {
  description = "storage_container_name"
}

variable "pes_event_key" {
  description = "pes_event_key"
}

variable "email_event_key" {
  description = "email_event_key"
}

variable "pes_event_endpoint" {
  description = "pes_event_endpoint"
}

variable "email_event_endpoint" {
  description = "email_event_endpoint"
}

variable "client_pes_id" {
  description = "client_pes_id"
}

variable "client_pes_secret" {
  description = "client_pes_secret"
}

variable "token_pes_baseurl" {
  description = "token_pes_baseurl"
}

variable "token_pes_auth" {
  description = "token_pes_auth"
}

variable "PESCallService_url" {
  description = "PESCallService_url"
}

variable "pes_token_url" {
  description = "pes_token_url"
}

variable "publisherEndPoint_url" {
  description = "publisherEndPoint_url"
}

variable "pes_pdr_tinsearch_url" {
  description = "pes_pdr_tinsearch_url"
}

variable "pes_callcount_max" {
  description = "pes_callcount_max"
}

variable "management_endpoints_web_base_path" {
  description = "management_endpoints_web_base_path"
}

variable "mongodb_connection_string" {
  description = "mongodb_connection_string"
}

variable "mongodb_database" {
  description = "mongodb_database"
}

variable "server_port" {
  description = "server_port"
}

variable "ehCache_heapSize" {
  description = "ehCache_heapSize"
}

variable "ehCache_name" {
  description = "ehCache_name"
}

variable "claims_token_url" {
  description = "claims_token_url"
}

variable "client_claims_id" {
  description = "client_claims_id"
}

variable "client_claims_secret" {
  description = "client_claims_secret"
}

variable "claims_grant_type" {
  description = "claims_grant_type"
}

variable "claims_link_url" {
  description = "claims_link_url"
}

variable "taf_token_endpoint" {
  description = "taf_token_endpoint"
}

variable "tin_verify_by_payment_client_id" {
  description = "tin_verify_by_payment_client_id"
}

variable "tin_verify_by_payment_client_secret" {
  description = "tin_verify_by_payment_client_secret"
}

variable "tin_verify_by_payment_baseurl" {
  description = "tin_verify_by_payment_baseurl"
}

variable "tin_verify_by_payment_auth" {
  description = "tin_verify_by_payment_auth"
}

variable "tin_verify_by_payment_service_url" {
  description = "tin_verify_by_payment_service_url"
}

variable "tin_verify_by_payment_token_url" {
  description = "tin_verify_by_payment_token_url"
}

variable "billing_paa_tin_request_client_id" {
  description = "billing_paa_tin_request_client_id"
}

variable "billing_paa_tin_request_client_secret" {
  description = "billing_paa_tin_request_client_secret"
}

variable "billing_paa_tin_request_baseurl" {
  description = "billing_paa_tin_request_baseurl"
}

variable "billing_paa_tin_request_auth" {
  description = "billing_paa_tin_request_auth"
}

variable "billing_paa_tin_request_service_url" {
  description = "billing_paa_tin_request_service_url"
}

variable "taf_success_status_codes" {
  description = "taf_success_status_codes"
}

variable "taf_failed_status_codes_newTaxID" {
  description = "taf_failed_status_codes_newTaxID"
}

variable "taf_failed_status_codes_reviewStatus" {
  description = "taf_failed_status_codes_reviewStatus"
}

variable "irsOrg" {
  description = "List of Cosmos collections."
  default     = "irsOrg"
}


