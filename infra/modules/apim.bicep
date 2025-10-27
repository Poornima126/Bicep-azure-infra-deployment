param apimName string
param publisherEmail string
param publisherName string
param location string = resourceGroup().location

resource apim 'Microsoft.ApiManagement/service@2023-05-01-preview' = {
  name: apimName
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

output apimPortalUrl string = apim.properties.developerPortalUrl

