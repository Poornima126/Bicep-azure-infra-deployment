param appServicePlanName string
param webAppName string
param location string = resourceGroup().location
param skuName string = 'F1'

resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: 'Free'
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: plan.id
  }
}

output webAppUrl string = webApp.properties.defaultHostName

