# Replicate Example

This example demonstrates how to configure VM replication using the `replicate` operation mode.

## Prerequisites

Before running this example, you need to have:
1. An existing Azure Migrate project with discovery completed
2. Replication infrastructure initialized (see `initialize` example)
3. Target Azure Stack HCI cluster configured

## Finding Required Values

### VMware Site Name and Run-As Account

```bash
# List VMware sites in your resource group
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.OffAzure/VMwareSites?api-version=2023-06-06" \
  --query "value[].name" -o tsv

# List run-as accounts for a VMware site
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.OffAzure/VMwareSites/{site_name}/runasaccounts?api-version=2023-06-06" \
  -o json
```

### Replication Vault, Policy, and Extension Names

These are created during the `initialize` operation. You can find them from the solution:

```bash
# Get the replication solution details (contains vaultId)
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.Migrate/migrateprojects/{project_name}/solutions/Servers-Migration-ServerMigration_DataReplication?api-version=2020-06-01-preview" \
  -o json

# List replication policies in the vault
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.DataReplication/replicationVaults/{vault_name}/replicationPolicies?api-version=2024-09-01" \
  -o json

# List replication extensions in the vault
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.DataReplication/replicationVaults/{vault_name}/replicationExtensions?api-version=2024-09-01" \
  -o json
```

### Fabric Agent (DRA) Names

```bash
# List replication fabrics
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.DataReplication/replicationFabrics?api-version=2024-09-01" \
  -o json

# List fabric agents for a specific fabric
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.DataReplication/replicationFabrics/{fabric_name}/fabricAgents?api-version=2024-09-01" \
  -o json
```

### Discovered Machines

```bash
# List discovered machines from VMware site
az rest --method GET \
  --uri "https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.OffAzure/VMwareSites/{site_name}/machines?api-version=2023-06-06" \
  -o json
```
