param storageLocation string
param storageName string

targetScope = 'resourceGroup'

resource storageAcct 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: storageLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  properties: {}
}
