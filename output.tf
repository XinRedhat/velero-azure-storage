output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "tenant_id" {
  value = data.azurerm_subscription.current.tenant_id
}

output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "storage_account" {
  value = azurerm_storage_account.account.name
}

output "storage_container" {
  value = azurerm_storage_container.container.name
}
