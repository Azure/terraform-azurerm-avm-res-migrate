variable "instance_type" {
  type        = string
  default     = "VMwareToAzStackHCI"
  description = "The migration instance type (VMwareToAzStackHCI or HyperVToAzStackHCI)"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Optional: The Azure region. If not specified, uses the resource group's location."
}

variable "project_name" {
  type        = string
  default     = "saif-project-012726"
  description = "The name of the Azure Migrate project"
}

variable "replication_vault_id" {
  type        = string
  default     = "/subscriptions/f6f66a94-f184-45da-ac12-ffbfd8a6eb29/resourceGroups/saif-project-012726-rg/providers/Microsoft.DataReplication/replicationVaults/saif-project-01424replicationvault"
  description = "The full resource ID of the replication vault (optional, derived from project if not provided)"
}

variable "resource_group_name" {
  type        = string
  default     = "saif-project-012726-rg"
  description = "The name of the resource group containing the Azure Migrate project"
}

variable "subscription_id" {
  type        = string
  default     = "f6f66a94-f184-45da-ac12-ffbfd8a6eb29"
  description = "The Azure subscription ID where resources will be deployed"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Test"
    Purpose     = "ReplicationJobs"
  }
  description = "Tags to apply to resources"
}
