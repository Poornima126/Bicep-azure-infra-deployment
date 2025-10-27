param prefix string
param location string = resourceGroup().location
@secure()
param sqlAdminPassword string

// Storage
module storage 'modules/storage.bicep' = {
  name: 'storageModule'
  params: {
    prefix: prefix
    location: location
  }
}

// SQL
module sql 'modules/sql.bicep' = {
  name: 'sqlModule'
  params: {
    prefix: prefix
    location: location
    sqlAdminPassword: sqlAdminPassword
  }
}

// App Service
module app 'modules/appservice.bicep' = {
  name: 'appModule'
  params: {
    prefix: prefix
    location: location
  }
}

// Virtual Machine
module vm 'modules/vm.bicep' = {
  name: 'vmModule'
  params: {
    prefix: prefix
    location: location
  }
}

// API Management
module apim 'modules/apim.bicep' = {
  name: 'apimModule'
  params: {
    prefix: prefix
    location: location
  }
}

