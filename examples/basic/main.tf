variable "client_secret" {}
variable "client_id" {}
variable "tenant_id" {}
variable "subscription_id" {}

data "azurerm_subscription" "primary" {
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "config" {
}

terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "1.5.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.61.0"
    }
  }
}

provider "azuread" {
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

provider "azurerm" {
  features {}
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
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

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.config.object_id
}


//
//resource "azurerm_resource_group" "test" {
//  name     = "testResourceGroup1"
//  location = "West US"
//
//  tags {
//    environment = "dev"
//    costcenter  = "it"
//  }
//}
//
//module "appgw-ingress-k8s-cluster" {
//  source                              = "Azure/appgw-ingress-k8s-cluster/azurerm"
//  version                             = "0.1.0"
//  resource_group_name                 = azurerm_resource_group.test.name
//  location                            = "westus"
//  aks_service_principal_app_id        = "<App ID of the service principal>"
//  aks_service_principal_client_secret = "<Client secret of the service principal>"
//  aks_service_principal_object_id     = "<Object ID of the service principal>"
//
//  tags = {
//    environment = "dev"
//    costcenter  = "it"
//  }
//}
//
