
provider "azurerm" {
  features {}
   
}

resource "azurerm_resource_group" "rg" {
  name     = "learnk8sResourceGroup"
  location = "northeurope"
}

resource "azurerm_resource_group" "rg2" {
  name     = "sahil"
  location = "northeurope"
}
