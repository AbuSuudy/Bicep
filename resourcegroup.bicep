// bicep build --file resourcegroup.bicep

param location string

targetScope = 'subscription'
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'BicepTest'
  location: location
}


module azureFunction 'azureFucntion.bicep' = {
  name: 'FunctionDeployment'
  scope: resourceGroup
  params: {
    location:resourceGroup.location
  }
} 
