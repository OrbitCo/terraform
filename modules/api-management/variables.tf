variable "resource_group_name" {
  description = "The resource group name which should be used for all resources"
}

variable "prefix" {
  description = "The prefix which should be used for all resources"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
}

/*variable "open_api_spec_content_format" {
    description = "The format of the content from which the API Definition should be imported. Possible values are: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl and wsdl-link."
}

variable "open_api_spec_content_value" {
    description = "The Content from which the API Definition should be imported. When a content_format of *-link-* is specified this must be a URL, otherwise this must be defined inline."
}*/

variable "environment" {
    description = "The environment in which this APIM resource should be created"
}