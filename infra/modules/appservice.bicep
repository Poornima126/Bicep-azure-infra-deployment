param prefix string
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${prefix}plan132'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: '${prefix}webapp132'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

