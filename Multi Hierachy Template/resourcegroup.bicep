targetScope='subscription'


param location string
param functionResourceGroupName string
param storageResourceGroupName string


resource StorageRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: storageResourceGroupName
  location: location
}

module storageAcct 'storageaccount.bicep' = {
  name: 'storageModule'
  scope: StorageRG
}

resource AzureFunctionRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: functionResourceGroupName
  location: location
}

module azureFunction 'azureFunction.bicep' = {
  name: 'FunctionDeployment'
  scope: AzureFunctionRG
  params: {
    location:AzureFunctionRG.location
  }
} 
