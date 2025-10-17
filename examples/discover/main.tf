# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
#
# Example: Discover Servers from VMware/HyperV
# This example demonstrates how to use the module to discover servers
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

# Discover all servers in a VMware site
module "discover_vmware_servers" {
  source = "../../"

  # Operation mode
  operation_mode = "discover"

  # Resource configuration
  resource_group_name = "rg-migrate-prod"
  location            = "eastus"
  name                = "vmware-discovery"

  # Discovery configuration
  project_name        = "contoso-migrate-project"
  source_machine_type = "VMware"
  appliance_name      = "contoso-vmware-appliance"

  # Optional: Filter by display name
  # display_name = "web-server-01"

  tags = {
    Environment = "Production"
    Purpose     = "Migration Discovery"
    Owner       = "IT Team"
  }
}

# Output discovered servers
output "discovered_servers" {
  value       = module.discover_vmware_servers.discovered_servers
  description = "List of discovered servers with their properties"
}

output "total_servers_found" {
  value       = module.discover_vmware_servers.discovered_servers_count
  description = "Total number of servers discovered"
}

# Example: Process discovered servers
locals {
  # Filter servers by OS
  windows_servers = [
    for server in module.discover_vmware_servers.discovered_servers :
    server if can(regex("Windows", server.os_name))
  ]

  linux_servers = [
    for server in module.discover_vmware_servers.discovered_servers :
    server if can(regex("Linux|Ubuntu|CentOS|RedHat", server.os_name))
  ]
}

output "windows_servers_count" {
  value       = length(local.windows_servers)
  description = "Number of Windows servers discovered"
}

output "linux_servers_count" {
  value       = length(local.linux_servers)
  description = "Number of Linux servers discovered"
}

