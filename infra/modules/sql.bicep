param prefix string
param location string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: '${prefix}-sqlserver'
  location: location
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: 'admin@123'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: '${sqlServer.name}/${prefix}-sqldb'
  location: location
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  dependsOn: [
    sqlServer
  ]
}

