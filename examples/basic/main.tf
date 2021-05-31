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

resource "azuread_application" "example" {
  homepage                   = "http://homepage"
  identifier_uris            = ["http://uri"]
  reply_urls                 = ["http://replyurl"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  name = "example"
}

resource "azuread_service_principal" "example" {
  application_id               = azuread_application.example.application_id
  app_role_assignment_required = false

  tags = ["example", "tags", "here"]
}
