# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

output "migration_status" {
  description = "Status of the migration operation"
  value       = module.migrate_vm.migration_status
}

output "migration_protected_item_details" {
  description = "Information about the protected item before migration"
  value       = module.migrate_vm.migration_protected_item_details
}

output "migration_validation_warnings" {
  description = "Any warnings detected before migration"
  value       = module.migrate_vm.migration_validation_warnings
}

output "migration_operation_details" {
  description = "Details of the migration operation including headers"
  value       = module.migrate_vm.migration_operation_details
}

# Derived outputs for migration readiness assessment
output "migration_readiness" {
  description = "Pre-migration readiness assessment"
  value = {
    protected_item_id   = var.protected_item_id
    shutdown_configured = var.shutdown_source_vm
    vm_name             = try(module.migrate_vm.migration_protected_item_details.name, "N/A")
    protection_state    = try(module.migrate_vm.migration_protected_item_details.protection_state, "Unknown")
    replication_health  = try(module.migrate_vm.migration_protected_item_details.replication_health, "Unknown")
    can_migrate         = try(module.migrate_vm.migration_protected_item_details.can_perform_migration, false)
    allowed_operations  = try(module.migrate_vm.migration_protected_item_details.allowed_jobs, [])
    warnings_count      = try(length(module.migrate_vm.migration_validation_warnings), 0)
    is_ready_for_migration = try(
      module.migrate_vm.migration_protected_item_details.can_perform_migration &&
      module.migrate_vm.migration_protected_item_details.replication_health == "Normal" &&
      length(module.migrate_vm.migration_validation_warnings) == 0,
      false
    )
  }
}
