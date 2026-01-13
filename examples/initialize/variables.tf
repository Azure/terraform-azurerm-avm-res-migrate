# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID where resources will be deployed"
  default     = "de3c4d5e-af08-451a-a873-438d86ab6f4b"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Azure Migrate project"
  default     = "saif-project-011326-rg"
}

variable "project_name" {
  type        = string
  description = "The name of the Azure Migrate project"
  default     = "saif-project-011326"
}

variable "source_appliance_name" {
  type        = string
  description = "The name of the source appliance (e.g., 'src' for VMware or HyperV). The module will automatically discover the corresponding fabric."
  default     = "src"
}

variable "target_appliance_name" {
  type        = string
  description = "The name of the target appliance (e.g., 'tgt' for Azure Stack HCI). The module will automatically discover the corresponding fabric."
  default     = "tgt"
}

variable "app_consistent_frequency_minutes" {
  type        = number
  description = "Application-consistent snapshot frequency in minutes"
  default     = 240
}

variable "crash_consistent_frequency_minutes" {
  type        = number
  description = "Crash-consistent snapshot frequency in minutes"
  default     = 60
}

variable "recovery_point_history_minutes" {
  type        = number
  description = "Recovery point history retention in minutes"
  default     = 4320
}

variable "instance_type" {
  type        = string
  description = "The migration instance type (VMwareToAzStackHCI or HyperVToAzStackHCI)"
  default     = "VMwareToAzStackHCI"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    Environment = "Production"
    Purpose     = "HCI Migration Infrastructure"
    Owner       = "IT Team"
  }
}
