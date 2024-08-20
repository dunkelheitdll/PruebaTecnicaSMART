provider "azurerm" {
  features = {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-cicd-pipeline"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cicd-cluster"
  location            = "East US2"
  resource_group_name = "Prueba"
  dns_prefix          = "cicdpipeline"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
