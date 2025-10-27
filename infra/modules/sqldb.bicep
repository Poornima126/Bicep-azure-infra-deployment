param sqlServerName string
param sqlDbName string
param administratorLogin string
@secure()
param administratorPassword string
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorPassword
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: '${sqlServer.name}/${sqlDbName}'
  location: location
  properties: {
    maxSizeBytes: 268435456000
  }
  sku: {
    name: 'Basic'
  }
}

output sqlServerName string = sqlServer.name
output sqlDbConnectionString string = 'Server=tcp:${sqlServer.name}.database.windows.net,1433;Initial Catalog=${sqlDb.name};User ID=${administratorLogin};Password=${administratorPassword};'

