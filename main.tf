provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.bucket}_velero_rg"
  location = var.resource_group_location

  tags = {
    environment = var.bucket
  }
}

resource "azurerm_storage_account" "account" {
  name                     = "${var.bucket}velero"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind = "BlobStorage"
  access_tier = "Hot"
  enable_https_traffic_only = "true"
  allow_blob_public_access = true

  tags = {
    environment = var.bucket
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.bucket
  storage_account_name  = azurerm_storage_account.account.name
  container_access_type = "private"
}

#Create service principal
data "azurerm_subscription" "current" {
}

resource "local_file" "credentials-velero" {
    content     = templatefile("templates/credentials-velero.tpl",
      {
        AZURE_SUBSCRIPTION_ID = data.azurerm_subscription.current.subscription_id
        AZURE_TENANT_ID = data.azurerm_subscription.current.tenant_id
        AZURE_RESOURCE_GROUP = azurerm_resource_group.rg.name
        AZURE_CLIENT_ID = var.CLIENT_ID
        AZURE_CLIENT_SECRET = var.CLIENT_SECRET
        AZURE_STORAGE_ACCOUNT_ID = azurerm_storage_account.account.name
        STORAGE_ACCOUNT_ACCESS_KEY = azurerm_storage_account.account.primary_access_key
      }
    )
    filename = "credentials-velero"
}