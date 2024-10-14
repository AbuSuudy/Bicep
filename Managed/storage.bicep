param storageLocation string
param storageName string

//poweshell script to get id
//Get-AzRoleDefinition "Contributor" | ConvertTo-Json
var roleDefinitionResourceId = 'b24988ac-6180-42a0-ab88-20f7382dd24c'

targetScope = 'resourceGroup'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'storgaeAccountManagedIdentity'
  location: resourceGroup().location
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, managedIdentity.id, roleDefinitionResourceId)
  scope: storageAccount
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: storageLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}
