# Create New Azure Migrate Project

This example demonstrates how to create a new Azure Migrate project using the module.

## Key Features

- Creates a new Azure Migrate project in the specified resource group
- Configures the project with appropriate tags
- Uses the `create_migrate_project = true` flag to enable project creation

## Prerequisites

- An existing Azure resource group
- Appropriate permissions to create Azure Migrate projects in the subscription

## Important Notes

- Set `create_migrate_project = true` to create a new project
- If set to `false` (default), the module will query an existing project
- The project name must be unique within the resource group
