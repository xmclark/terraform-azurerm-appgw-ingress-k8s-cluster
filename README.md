The Application Gateway Ingress Controller allows the [Azure Application Gateway][azure_application_gateway] to be used as the ingress for an [Azure Kubernetes Service][azure_kubernetes_service] aka AKS cluster. As shown in the figure below, the ingress controller runs as a pod within the AKS cluster. It consumes [Kubernetes Ingress Resources][kubernetes_ingress] and converts them to an Azure Application Gateway configuration which allows the gateway to load-balance traffic to Kubernetes pods.

This module helps in deploying the necessary resources for the greenfield deployment of necessary resources for AKS cluster with Application Gateway as ingress controller.

![Azure Application Gateway + AKS][azure_agki_diagram]

## Setup
* **Greenfield Deployment**: If you are starting from scratch, refer to these [installation][docs_install_new] instructions which outlines steps to deploy an AKS cluster with Application Gateway and install application gateway ingress controller on the AKS cluster.

## Usage
Refer to the [tutorials][azure_ingress_tutorials] to understand how you can expose an AKS service over HTTP or HTTPS, to the internet, using an Azure Application Gateway.

## Usage of the module
```hcl


resource "azurerm_resource_group" "test" {
  name     = "testResourceGroup1"
  location = "West US"

  tags {
    environment = "dev"
    costcenter  = "it"
  }
}


module "appgw-ingress-k8s-cluster" {
  source                              = "Azure/appgw-ingress-k8s-cluster/azurerm"
  version                             = "0.1.0"
  resource_group_name                 = azurerm_resource_group.test.name
  location                            = "westus"
  aks_service_principal_app_id        = "<App ID of the service principal>"
  aks_service_principal_client_secret = "<Client secret of the service principal>"
  aks_service_principal_object_id     = "<Object ID of the service principal>"

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

```

## Authors
Originally created by [Vaijanath Angadihiremath](http://github.com/VaijanathB)
# Contributing
This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

[azure_application_gateway]: https://azure.microsoft.com/en-us/services/application-gateway/
[azure_kubernetes_service]: https://azure.microsoft.com/en-us/services/kubernetes-service/
[kubernetes_ingress]: https://kubernetes.io/docs/concepts/services-networking/ingress/
[azure_agki_diagram]: https://github.com/Azure/application-gateway-kubernetes-ingress/raw/master/docs/images/architecture.png
[docs_install_new]: docs/install-new.md
[azure_ingress_tutorials]: https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/tutorial.md
