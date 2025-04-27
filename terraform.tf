terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Configure the Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "f2b10cce-5416-4954-a546-cecc424e44f3"
  tenant_id       = "cc3f5785-8ad7-4b29-b216-e322fc4fb1b9"
}


# Create a resource group
resource "azurerm_resource_group" "acr_rg" {
  name     = "rg-acr-example"
  location = "East US"    # Change region if needed
}

# Create Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "youracrname"    # Must be globally unique, only lowercase letters and numbers
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = azurerm_resource_group.acr_rg.location
  sku                 = "Basic"           # Options: Basic, Standard, Premium
  admin_enabled       = true              # Set true to enable admin username/password login
}
