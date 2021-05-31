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

resource "azuread_application" "k8s" {
  homepage                   = "http://k8s-homepage"
  identifier_uris            = ["http://k8s-uri"]
  reply_urls                 = ["http://k8s-replyurl"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  name = "k8s"
}

resource "azuread_service_principal" "k8s" {
  application_id               = azuread_application.k8s.application_id
  app_role_assignment_required = false

  tags = ["k8s", "control-plane"]
}
