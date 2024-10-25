targetScope='subscription'


param resourceGroupLocation string
param resourceGroupName string

resource StorageRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module storageAcct '3-storage.bicep' = {
  name: 'storageModule'
  scope: StorageRG
}

resource AzureFunctionRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module azureFunction '3-azureFucntion.bicep' = {
  name: 'FunctionDeployment'
  scope: AzureFunctionRG
  params: {
    location:AzureFunctionRG.location
  }
} 
