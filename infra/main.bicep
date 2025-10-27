param location string = resourceGroup().location

@secure()
param sqlAdminPassword string = 'Password@12345'  // Change or override via pipeline
@secure()
param vmAdminPassword string = 'VmPassword@12345'

// Define resource names explicitly
var storageAccountName = 'demostorage132'
var sqlServerName = 'demosqlserver132'
var sqlDatabaseName = 'demodb132'
var sqlAdminUsername = 'demoAdmin'
var appServicePlanName = 'demoplan132'
var webAppName = 'demowebapp132'
var vmName = 'demovm132'
var vmAdminUsername = 'demoadmin'

// 🌩️ Storage Account
module storage 'modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

// 💾 SQL Server + Database
module sql 'modules/sql.bicep' = {
  name: 'sqlDeployment'
  params: {
    sqlServerName: sqlServerName
    sqlDatabaseName: sqlDatabaseName
    sqlAdminUsername: sqlAdminUsername
    sqlAdminPassword: sqlAdminPassword
    location: location
  }
  dependsOn: [storage]
}

// ⚙️ App Service
module appservice 'modules/appservice.bicep' = {
  name: 'appserviceDeployment'
  params: {
    appServicePlanName: appServicePlanName
    webAppName: webAppName
    location: location
    storageAccountName: storageAccountName
  }
  dependsOn: [sql]
}

// 🖥️ Virtual Machine
module vm 'modules/vm.bicep' = {
  name: 'vmDeployment'
  params: {
    vmName: vmName
    location: location
    adminUsername: vmAdminUsername
    adminPassword: vmAdminPassword
  }
  dependsOn: [appservice]
}

