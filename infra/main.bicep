param location string = resourceGroup().location

@description('App Service Details')
param webAppName string = 'demo-webapp1234'
param appServicePlanName string = 'demo-app-plan'

@description('SQL Database Details')
param sqlServerName string = 'demo-sql-server1234'
param sqlDbName string = 'demo-db'
param administratorLogin string = 'sqladminuser'
@secure()
param administratorPassword string

@description('Storage Account')
param storageAccountName string = 'demostorage${uniqueString(resourceGroup().id)}'

@description('VM Details')
param vmName string = 'demo-vm'
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

@description('API Management')
param apimName string = 'demo-apim'
param publisherEmail string = 'admin@demo.com'
param publisherName string = 'DemoAdmin'

module storage './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module sqldb './modules/sqldb.bicep' = {
  name: 'sqldbDeploy'
  params: {
    sqlServerName: sqlServerName
    sqlDbName: sqlDbName
    administratorLogin: administratorLogin
    administratorPassword: administratorPassword
  }
}

module appservice './modules/appservice.bicep' = {
  name: 'appserviceDeploy'
  params: {
    appServicePlanName: appServicePlanName
    webAppName: webAppName
  }
}

module apim './modules/apim.bicep' = {
  name: 'apimDeploy'
  params: {
    apimName: apimName
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

module vm './modules/vm.bicep' = {
  name: 'vmDeploy'
  params: {
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

