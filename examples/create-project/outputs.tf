output "migrate_project_id" {
  description = "The resource ID of the created Azure Migrate project"
  value       = module.create_migrate_project.migrate_project_id
}

output "migrate_project_name" {
  description = "The name of the created Azure Migrate project"
  value       = var.project_name
}

output "resource_group_name" {
  description = "The resource group containing the Migrate project"
  value       = var.resource_group_name
}
