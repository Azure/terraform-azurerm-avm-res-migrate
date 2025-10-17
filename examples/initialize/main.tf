# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
#
# Example: Initialize Replication Infrastructure
# This example demonstrates how to initialize the replication infrastructure
# for Azure Stack HCI migration
#

terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71, < 5.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.9, < 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Initialize replication infrastructure for VMware to Azure Stack HCI migration
module "initialize_replication" {
  source = "../../"

  # Operation mode
  operation_mode = "initialize"

  # Resource configuration
  resource_group_name = "rg-migrate-prod"
  location            = "eastus"
  name                = "hci-migration-init"

  # Migration project
  project_name = "contoso-migrate-project"

  # Appliance names
  source_appliance_name = "vmware-source-appliance"
  target_appliance_name = "hci-target-appliance"

  # Instance type (VMware to HCI or HyperV to HCI)
  instance_type = "VMwareToAzStackHCI"

  # Fabric IDs (obtained from Azure Migrate)
  source_fabric_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-migrate-prod/providers/Microsoft.DataReplication/replicationFabrics/vmware-fabric"
  target_fabric_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-migrate-prod/providers/Microsoft.DataReplication/replicationFabrics/hci-fabric"

  # Optional: Provide existing cache storage account
  # cache_storage_account_id = "/subscriptions/.../storageAccounts/existingcache"

  # Replication policy settings
  recovery_point_history_minutes    = 4320  # 72 hours
  crash_consistent_frequency_minutes = 60   # 1 hour
  app_consistent_frequency_minutes   = 240  # 4 hours

  tags = {
    Environment = "Production"
    Purpose     = "HCI Migration Infrastructure"
    Owner       = "IT Team"
  }
}

# Outputs
output "replication_vault_id" {
  value       = module.initialize_replication.replication_vault_id
  description = "ID of the replication vault"
}

output "replication_policy_id" {
  value       = module.initialize_replication.replication_policy_id
  description = "ID of the replication policy"
}

output "cache_storage_account_id" {
  value       = module.initialize_replication.cache_storage_account_id
  description = "ID of the cache storage account"
}

output "replication_extension_name" {
  value       = module.initialize_replication.replication_extension_name
  description = "Name of the replication extension (needed for VM replication)"
}

output "vault_identity" {
  value       = module.initialize_replication.replication_vault_identity
  description = "Managed identity principal ID of the vault"
  sensitive   = true
}
