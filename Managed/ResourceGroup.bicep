targetScope='subscription'

param resourceGroupName string
param resourceGroupLocation string
param storageLocation string
param storageName string

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module storageResource 'storage.bicep' = {
  name: storageName
  params: {
    storageLocation:storageLocation
    storageName:storageName
  }
  scope:ResourceGroup
}
