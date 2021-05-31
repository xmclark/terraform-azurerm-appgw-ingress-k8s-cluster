variable "client_secret" {}
variable "client_id" {}
variable "tenant_id" {}


terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "1.5.0"
    }
  }
}

provider "azuread" {
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}
