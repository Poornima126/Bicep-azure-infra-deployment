param prefix string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: '${prefix}storage132'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
