@description('Prefix for naming resources')
param prefix string

@description('Azure region')
param location string

@description('SQL Administrator username')
param sqlAdminUsername string = 'sqladminuser'

@secure()
@description('SQL Administrator password')
param sqlAdminPassword string

// ------------------------------
// SQL Server
// ------------------------------
resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: toLower('${prefix}-sql-${uniqueString(resourceGroup().id)}')
  location: location
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }
}

// ------------------------------
// SQL Database
// ------------------------------
resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: '${prefix}-db'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    maxSizeBytes: 2147483648
  }
  dependsOn: [
    sqlServer
  ]
}

// ------------------------------
// Firewall Rule (Allow Azure Services)
// ------------------------------
resource firewallRuleAllowAzure 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  name: 'AllowAzureServices'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
  dependsOn: [
    sqlServer
  ]
}

// ------------------------------
// Outputs
// ------------------------------
output sqlServerName string = sqlServer.name
output sqlDatabaseName string = sqlDatabase.name
output sqlServerFQDN string = sqlServer.properties.fullyQualifiedDomainName

