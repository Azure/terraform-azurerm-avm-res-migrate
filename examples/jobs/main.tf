# Example: Get Replication Jobs
# This example demonstrates how to retrieve replication job status
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

# Get replication jobs
module "replication_jobs" {
  source = "../../"

  name                = "replication-jobs"
  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  instance_type       = var.instance_type
  location            = var.location
  operation_mode      = "jobs"
  project_name        = var.project_name
  # Use explicit vault ID
  replication_vault_id = var.replication_vault_id
  tags                 = var.tags
}

