
provider "azurerm" {
  features {}
    client_id      = "bcff84c6-e588-459f-9fda-39da37afb463"
    client_secret  = "Cb58Q~BEqhYcUKfO1cJUrUlc6pAQpYrAJQdAFcuU"
    tenant_id      = "e2c2296f-4b99-4a66-b84b-ce3fd333945a"
    subscription_id= "f41f9a5f-78b9-4e1f-891f-2f748f1c64ed"
}

resource "azurerm_resource_group" "rg" {
  name     = "learnk8sResourceGroup"
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "learnk8scluster"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}
