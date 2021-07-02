dynamic_tags = {
  "Environment" = "STAGE"
}

location="eastus"

namespace = "stage"

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

prefix="stage"

environment="stage"

rg-count="1"

cosmos_db_alt_location="westus"

key_vault_name="kvstagedigsec"

cosmosdb_connection_string_name="connectionStringName"

storage_account_name="ststagedigsec" 

account_name="cosmos-stage-digsec"

linkhealth_baseurl="api-gateway.linkhealth.com"

linkhealth_auth="oauth/token"

client_secret="d8bb86bb-4fe7-41c7-aab2-87a4cc22b957"

client_id="digital-security-prod"

memberSummary_url="clink-api/api/claim/summary/bymember/v1.0"

linkhealth_taf_baseurl="gateway-stage.optum.com"

linkhealth_taf_auth="auth/oauth2/cached/token"

client_taf_secret="lOzLSaKYIE9P3VeO0VfyMNOxYdjiyhIN"

client_taf_id="w6y4cF7ZG3maxuefz0s2mnTsuvNf7w5Q"

TAFCallService_url="api/alpha/clm/chy/taf-investigations/v1"

request_maxCheckCount=10

SENDGRID_API_KEY="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"

storageacc_connection_string = "DefaultEndpointsProtocol=https;AccountName=stdevdigsec;AccountKey=SGFPxzzj3OeErn5EZ7D73py5m8roDDh/UR2WnG7XY5vv4Z9arFYaL/3iDo+6oTBD7YpE8zupR6BnJ/VwBa//RA==;EndpointSuffix=core.windows.net"

pes_event_key="kSBGbZ64EaRNm8nOd2SmgsrHjHO+lD9mK6Q2lbRJa0o="
email_event_key="MfXr19tFKZ0tdk6wK6lnfPLShYCaWXS+IEzjaf2bOIA="

pes_event_endpoint="https://evgt-pescall-dev-digsec.eastus-1.eventgrid.azure.net"
email_event_endpoint="https://evgt-email-dev-digsec.eastus-1.eventgrid.azure.net"