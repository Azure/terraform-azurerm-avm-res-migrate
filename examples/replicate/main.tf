# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
#
# Example: Create VM Replication
# This example demonstrates how to create replication for a VM to Azure Stack HCI
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

# Create replication for a specific VM
module "replicate_vm" {
  source = "../../"

  # Operation mode
  operation_mode = "replicate"

  # Resource configuration
  resource_group_name = "rg-migrate-prod"
  location            = "eastus"
  name                = "vm-replication"

  # Machine to replicate
  machine_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-migrate-prod/providers/Microsoft.OffAzure/VMwareSites/vmware-site/machines/web-server-01"

  # Target configuration
  target_vm_name          = "web-server-01-migrated"
  target_storage_path_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-hci/providers/Microsoft.AzureStackHCI/storagecontainers/storage-path-01"
  target_resource_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-migrated-vms"

  # VM sizing
  target_vm_cpu_cores = 4
  target_vm_ram_mb    = 8192
  is_dynamic_memory_enabled = false
  hyperv_generation   = "2"

  # Replication configuration
  replication_vault_id      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-migrate-prod/providers/Microsoft.DataReplication/replicationVaults/vault-name"
  policy_name               = "vault-nameVMwareToAzStackHCIpolicy"
  replication_extension_name = "vmware-fabric-hci-fabric-MigReplicationExtn"

  # Fabric and DRA configuration
  source_fabric_agent_name = "vmware-source-dra"
  target_fabric_agent_name = "hci-target-dra"
  run_as_account_id        = "/subscriptions/.../runAsAccounts/vcenter-account"

  # Custom location and HCI cluster
  custom_location_id  = "/subscriptions/.../customLocations/hci-custom-location"
  target_hci_cluster_id = "/subscriptions/.../clusters/hci-cluster-01"

  # Disks to include (power user mode)
  disks_to_include = [
    {
      disk_id          = "disk-001"
      disk_size_gb     = 127
      disk_file_format = "VHDX"
      is_os_disk       = true
      is_dynamic       = true
    },
    {
      disk_id          = "disk-002"
      disk_size_gb     = 500
      disk_file_format = "VHDX"
      is_os_disk       = false
      is_dynamic       = true
    }
  ]

  # NICs to include
  nics_to_include = [
    {
      nic_id            = "nic-001"
      target_network_id = "/subscriptions/.../logicalnetworks/hci-network-01"
      test_network_id   = "/subscriptions/.../logicalnetworks/hci-test-network"
      selection_type    = "SelectedByUser"
    }
  ]

  # Source VM metadata
  source_vm_cpu_cores = 2
  source_vm_ram_mb    = 4096
  instance_type       = "VMwareToAzStackHCI"

  tags = {
    Environment = "Production"
    Purpose     = "VM Migration"
    SourceVM    = "web-server-01"
  }
}

# Outputs
output "protected_item_id" {
  value       = module.replicate_vm.protected_item_id
  description = "ID of the protected item (replicated VM)"
}

output "replication_state" {
  value       = module.replicate_vm.replication_state
  description = "Current replication state"
}

output "target_vm_name" {
  value       = module.replicate_vm.target_vm_name_output
  description = "Name of the target VM"
}

# Example: Default user mode (simplified configuration)
module "replicate_vm_simple" {
  source = "../../"

  operation_mode      = "replicate"
  resource_group_name = "rg-migrate-prod"
  location            = "eastus"
  name                = "simple-vm-replication"

  machine_id          = "/subscriptions/.../machines/app-server-01"
  target_vm_name      = "app-server-01-migrated"
  target_storage_path_id  = "/subscriptions/.../storagecontainers/storage-path-01"
  target_resource_group_id = "/subscriptions/.../resourceGroups/rg-migrated-vms"

  # Use default user mode with single OS disk and virtual switch
  os_disk_id              = "disk-os-001"
  target_virtual_switch_id = "/subscriptions/.../logicalnetworks/hci-network-01"

  replication_vault_id       = "/subscriptions/.../replicationVaults/vault-name"
  policy_name                = "migration-policy"
  replication_extension_name = "replication-extn"

  tags = {
    Environment = "Production"
    MigrationType = "Simple"
  }
}
