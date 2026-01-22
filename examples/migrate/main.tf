# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
#
# Example: Migrate (Planned Failover) a Protected VM
# This example demonstrates how to perform a planned failover (migration) of a replicated VM to Azure Stack HCI
#

terraform {
  required_version = ">= 1.5"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.9, < 3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71, < 5.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Perform planned failover (migration) of a protected VM
module "migrate_vm" {
  source = "../../"

  name                = "vm-migration"
  resource_group_name = var.resource_group_name
  operation_mode      = "migrate"
  protected_item_id   = var.protected_item_id
  instance_type       = var.instance_type
  shutdown_source_vm  = var.shutdown_source_vm
  tags                = var.tags
}
