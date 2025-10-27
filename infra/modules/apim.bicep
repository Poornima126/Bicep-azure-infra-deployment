param prefix string
param location string

resource apim 'Microsoft.ApiManagement/service@2023-05-01-preview' = {
  name: '${prefix}-apim'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: 'admin@demo.com'
    publisherName: 'Demo Admin'
  }
}

