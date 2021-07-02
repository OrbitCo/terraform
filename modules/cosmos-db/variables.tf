variable "resource_group_name" {
  description = "The resource group name which should be used for all resources"
}


variable "prefix" {
  description = "The prefix which should be used for all resources"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
}

variable "alt_location" {
  description = "The Azure Region which should be used for the alternate location for this example."
}

variable namespace {
  description = "namespace for the environment"
}

variable account_name {
  type = string
  description = "cosmos db account name"  
}