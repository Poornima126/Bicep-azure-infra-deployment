param location string = resourceGroup().location
param prefix string = 'demo'

module storage './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    prefix: prefix
    location: location
  }
}

module sqlModule './modules/sql.bicep' = {
  name: 'sqlDeploy'
  params: {
    prefix: prefix
    location: location
    sqlAdminPassword: sqlAdminPassword
  }
}

module appservice './modules/appservice.bicep' = {
  name: 'appServiceDeploy'
  params: {
    prefix: prefix
    location: location
    storageAccountName: storage.outputs.storageAccountName
  }
}

module vm './modules/vm.bicep' = {
  name: 'vmDeploy'
  params: {
    prefix: prefix
    location: location
  }
}

module apim './modules/apim.bicep' = {
  name: 'apimDeploy'
  params: {
    prefix: prefix
    location: location
  }
}
