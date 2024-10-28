targetScope = 'resourceGroup'

resource storageAcct 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${uniqueString(resourceGroup().id)}Storage'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  properties: {}
}

