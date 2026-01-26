# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

variable "instance_type" {
  type        = string
  default     = "VMwareToAzStackHCI"
  description = "The migration instance type (VMwareToAzStackHCI or HyperVToAzStackHCI)"
}

variable "location" {
  type        = string
  default     = null
  description = "Optional: The Azure region. If not specified, uses the resource group's location."
}

variable "protected_item_id" {
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/Microsoft.DataReplication/replicationVaults/my-vault/protectedItems/my-vm"
  description = "The full resource ID of the protected item (replicated VM) to migrate"
}

variable "resource_group_name" {
  type        = string
  default     = "my-migrate-project-rg"
  description = "Name of the resource group containing the Azure Migrate project"
}

variable "shutdown_source_vm" {
  type        = bool
  default     = true
  description = "Whether to shutdown the source VM before migration (recommended for production migrations)"
}

variable "subscription_id" {
  type        = string
  default     = null
  description = "Azure subscription ID"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Purpose     = "Migration"
  }
  description = "Tags to apply to all resources"
}
