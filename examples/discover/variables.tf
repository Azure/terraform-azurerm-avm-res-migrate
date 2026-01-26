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

variable "project_name" {
  type        = string
  default     = "my-migrate-project"
  description = "The name of the Azure Migrate project"
}

variable "resource_group_name" {
  type        = string
  default     = "my-migrate-project-rg"
  description = "The name of the resource group containing the Azure Migrate project"
}

variable "subscription_id" {
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
  description = "The Azure subscription ID where resources will be deployed"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Test"
    Purpose     = "Discovery"
  }
  description = "Tags to apply to all resources"
}
