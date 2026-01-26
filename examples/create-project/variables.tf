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
  default     = "eastus"
  description = "The Azure region where the Migrate project will be created"
}

variable "project_name" {
  type        = string
  default     = "my-new-migrate-project"
  description = "The name of the new Azure Migrate project to create"
}

variable "resource_group_name" {
  type        = string
  default     = "my-migrate-project-rg"
  description = "The name of the resource group where the Migrate project will be created"
}

variable "subscription_id" {
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
  description = "The Azure subscription ID where resources will be deployed"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Production"
    Purpose     = "MigrateProject"
    ManagedBy   = "Terraform"
  }
  description = "Tags to apply to the Azure Migrate project"
}
