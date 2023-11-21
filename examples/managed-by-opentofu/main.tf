terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.81.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.42.0"
    }
  }
}

module "opentofu-azurerm-backend" {
  source  = "github.com/Zymus/opentofu-azurerm-backend"
  version = "0.0.1"

  name = "opentofu-azurerm-backend"
}
