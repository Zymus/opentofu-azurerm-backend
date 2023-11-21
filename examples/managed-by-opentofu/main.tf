terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.42.0"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}

module "opentofu-azurerm-backend" {
  source  = "github.com/Zymus/opentofu-azurerm-backend"

  resource_group_name  = "opentofu-azurerm-backend"
  location             = "westus2"
  storage_account_name = "studiohummingbirdgamestf"
  container_name       = "tfstatecontainer"
  key                  = "tfstate"
}
