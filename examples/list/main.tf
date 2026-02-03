# Example: List Protected Items
# This example demonstrates how to list all protected (replicating) VMs in a vault
#

terraform {
  required_version = ">= 1.5"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.9, < 3.0"
    }
  }
}

provider "azapi" {
  subscription_id = var.subscription_id
}

# List all protected items in the vault
module "list_protected_items" {
  source = "../../"

  name                = "list-protected-items"
  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  instance_type       = var.instance_type
  operation_mode      = "list"
  # List by project name (vault auto-discovered)
  project_name = var.project_name
  tags         = var.tags
}

