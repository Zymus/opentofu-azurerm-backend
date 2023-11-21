terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.42.0, < 6"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
  use_msi                    = true
}

provider "github" {
  
}

resource "azurerm_resource_group" "azurerm-backend" {
  name     = var.resource_group_name
  location = var.location

  tags     = var.tags
}

resource "azurerm_storage_account" "azurerm-backend" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.azurerm-backend.name
  location                 = azurerm_resource_group.azurerm-backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags                     = var.tags
}

resource "azurerm_storage_container" "azurerm-backend" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.azurerm-backend.name
}

resource "azurerm_storage_blob" "tfstate" {
  name                   = var.key
  storage_account_name   = azurerm_storage_account.azurerm-backend.name
  storage_container_name = azurerm_storage_container.azurerm-backend.name
  type                   = "Block"
}

resource "azurerm_role_definition" "opentofu-azurerm-backend-contributor" {
  name  = "OpenTofu azurerm Backend Contributor"
  scope = azurerm_storage_blob.tfstate.id

  permissions {
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write"
    ]
  }
}
