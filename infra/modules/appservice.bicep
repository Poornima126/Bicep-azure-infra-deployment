param prefix string
param location string
param storageAccountName string

resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${prefix}-plan'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource webapp 'Microsoft.Web/sites@2022-03-01' = {
  name: '${prefix}-webapp'
  location: location
  properties: {
    serverFarmId: plan.id
  }
}

