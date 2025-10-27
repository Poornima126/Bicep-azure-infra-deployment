param prefix string
param location string = resourceGroup().location
@secure()
param sqlAdminPassword string
@secure()
param vmAdminPassword string = 'Demo@12345!'

// ────────────────────────────────
// Storage Account Module
// ────────────────────────────────
module storage 'modules/storage.bicep' = {
  name: 'storageModule'
  params: {
    prefix: prefix
    location: location
  }
}

// ────────────────────────────────
// SQL Server + Database Module
// ────────────────────────────────
module sql 'modules/sql.bicep' = {
  name: 'sqlModule'
  params: {
    prefix: prefix
    location: location
    sqlAdminPassword: sqlAdminPassword
  }
}

// ────────────────────────────────
// App Service + Plan Module
// ────────────────────────────────
module app 'modules/appservice.bicep' = {
  name: 'appModule'
  params: {
    prefix: prefix
    location: location
  }
}

// ────────────────────────────────
// Virtual Machine Module
// (now includes auto VNet + subnet fix)
// ────────────────────────────────
module vm 'modules/vm.bicep' = {
  name: 'vmModule'
  params: {
    prefix: prefix
    location: location
    adminPassword: vmAdminPassword
  }
}

// ────────────────────────────────
// API Management Module
// ────────────────────────────────
module apim 'modules/apim.bicep' = {
  name: 'apimModule'
  params: {
    prefix: prefix
    location: location
  }
}

