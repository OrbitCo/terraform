dynamic_tags = {
  "Environment" = "DEV"
}

location="eastus"

namespace = "dev"

static_tags = {
  "ASKID"            = "<ask id value>"
  "AssignmentGroup"  = "<assignment group>"
  "GLCode"           = "<gl code>"
  "Division"         = "<division>"
  "Portfolio"        = "<portfolio>"
  "Product"          = "<product>"
  "Component"        = "<component>"
  "ComponentVersion" = "TBD"
}

prefix="dev"

environment="development"

rg-count="0"

cosmos_db_alt_location="westus"

key_vault_name="keyvaultname"

cosmosdb_connection_string_name="connectionStringName"

storage_account_name="stdevdigsec"

linkhealth_baseurl="api-gateway-stage.linkhealth.com"

linkhealth_auth="oauth/token"

client_secret="7757c5b8-f78f-49ce-940c-98ef3f4bdc54"

client_id="clink-nprod"

management_endpoints_web_base_path="/manage"
mongodb_connection_string="mongodb://cosmos-dev-digsec:ojZtOAXle4fXEXiynejdPWMXs782sRkx6ofCruHRECPRtWNY7GjEG75KYILG3rcAjsyjXlH2aSZq45o9slHWBQ==@cosmos-dev-digsec.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@cosmos-dev-digsec@"  
mongodb_database="digsecdb"
server_port="8080"

#ehcache properties
ehCache_heapSize=10
ehCache_name="DigitalSecurityTokenCache"

memberSummary_url="clink-api/api/security/claim/v1.0"
claims_token_url="https://api-gateway-stage.linkhealth.com/oauth/token"
client_claims_id="clink-nprod"
client_claims_secret="7757c5b8-f78f-49ce-940c-98ef3f4bdc54"
claims_grant_type="client_credentials"
claims_link_url="https://api-gateway-stage.linkhealth.com/clink-api/api/security/claim/v1.0"

linkhealth_taf_baseurl="gateway-stage.optum.com"
linkhealth_taf_auth="auth/oauth2/cached/token"
client_taf_secret="lOzLSaKYIE9P3VeO0VfyMNOxYdjiyhIN"
client_taf_id="w6y4cF7ZG3maxuefz0s2mnTsuvNf7w5Q"
taf_token_endpoint="https://gateway-stage.optum.com/auth/oauth2/cached/token"

TAFCallService_url="https://gateway-stage.optum.com/api/alpha/clm/chy/taf-investigations/v1"
SENDGRID_API_KEY="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"
storageacc_connection_string = "DefaultEndpointsProtocol=https;AccountName=stdevdigsec;AccountKey=SGFPxzzj3OeErn5EZ7D73py5m8roDDh/UR2WnG7XY5vv4Z9arFYaL/3iDo+6oTBD7YpE8zupR6BnJ/VwBa//RA==;EndpointSuffix=core.windows.net"
storage_container_name = "cr-dev-email-digsec"
pes_event_key="kSBGbZ64EaRNm8nOd2SmgsrHjHO+lD9mK6Q2lbRJa0o="
email_event_key="MfXr19tFKZ0tdk6wK6lnfPLShYCaWXS+IEzjaf2bOIA="

pes_event_endpoint="https://evgt-pescall-dev-digsec.eastus-1.eventgrid.azure.net"
email_event_endpoint="https://evgt-email-dev-digsec.eastus-1.eventgrid.azure.net"

client_pes_id="w6y4cF7ZG3maxuefz0s2mnTsuvNf7w5Q"
client_pes_secret="lOzLSaKYIE9P3VeO0VfyMNOxYdjiyhIN"
token_pes_baseurl="gateway-stage-dmz.optum.com"
token_pes_auth="/auth/oauth2/cached/token"
PESCallService_url="https://gateway-stage.optum.com/api/stage/pdr/pes/registrations/v2/search"
pes_token_url = "https://gateway-stage.optum.com/auth/oauth2/cached/token"
publisherEndPoint_url="https://fn-app-core-dev-digsec-eastus.azurewebsites.net/api/security/request/workflow/v1.0"
pes_pdr_tinsearch_url="https://gateway-stage.optum.com/api/alpha/pdr/demo/tax-identification-numbers/v1/search"
pes_callcount_max=10

tin_verify_by_payment_client_id="IQM6ebslla6ZJ4XhxWuNuoZOWCH8Q4uG"
tin_verify_by_payment_client_secret="W3hLZU7FB1K4T2fkbmflqSqq6FdiqUq5"
tin_verify_by_payment_baseurl="gateway-stage.optum.com"
tin_verify_by_payment_auth="/auth/oauth2/cached/token"
tin_verify_by_payment_service_url="https://gateway-stage.optum.com/api/alpha/ext/paymentinquiryapistage/v1/search"
tin_verify_by_payment_token_url="https://gateway-stage.optum.com/auth/oauth2/cached/token"

billing_paa_tin_request_client_id="digital-security-prod"
billing_paa_tin_request_client_secret="d8bb86bb-4fe7-41c7-aab2-87a4cc22b957"
billing_paa_tin_request_baseurl="api-gateway.linkhealth.com"
billing_paa_tin_request_auth="/oauth/token"
billing_paa_tin_request_service_url="https://api-gateway.linkhealth.com/dsonprem-nonprod/security/tafValidate/v1.0"

request_maxCheckCount=10

taf_success_status_codes = "AL RL SK"
taf_failed_status_codes_newTaxID = "NS NF RJ NT"
taf_failed_status_codes_reviewStatus = "IP RO HO"

