
provider "azurerm" {
  features {}
   
}

resource "azurerm_resource_group" "rg" {
  name     = "learnk8sResourceGroup"
  location = "northeurope"
}

