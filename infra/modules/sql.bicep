param prefix string
param location string
@secure()
param sqlAdminPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: '${prefix}sqlserver132'
  location: location
  properties: {
    administratorLogin: 'sqladminuser'
    administratorLoginPassword: sqlAdminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: '${sqlServer.name}/demodb'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

