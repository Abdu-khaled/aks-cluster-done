terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-rg"
    storage_account_name = "tfstateaksdone404"
    container_name       = "tfstate"
    key                  = "aks-prod.tfstate"
  }
}