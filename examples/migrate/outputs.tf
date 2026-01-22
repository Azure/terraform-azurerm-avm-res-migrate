# Outputs
output "migration_job_id" {
  description = "Async operation ID for tracking the migration job status"
  value       = module.migrate_vm.migration_job_id
}

output "migration_operation_details" {
  description = "Detailed response from the migration operation including status and properties"
  value       = module.migrate_vm.migration_operation_details
}

output "migration_protected_item_details" {
  description = "Details of the protected item before migration including state and health"
  value       = module.migrate_vm.migration_protected_item_details
}

output "protected_item_id" {
  description = "ID of the protected item being migrated"
  value       = var.protected_item_id
}
