//az deployment sub create --name demo  --location uksouth --template-file main.bicep --parameters resourceGroupName=RG-AbubakarSuudy-DEV storageName=abustorageaccount

targetScope='subscription'

metadata name = 'Create: resource group, Storage, Service Principle (Contribute role)'
metadata description = 'Create resource group with storage accoutn and service principles with contributor access.'
metadata owner = 'ASUUDY'

@description('Required. Resouce Group Name.')
param resourceGroupName string

@description('Required. Location of resouce group and resouces.')
@allowed([
  'uksouth'
  'ukwest'
])

param location string

@description('Required. Name of storage account.')
@minLength(3)
@maxLength(24)
param storageName string

//poweshell :Get-AzRoleDefinition "Contributor" | ConvertTo-Json
@description('Optional. Role defintion id default to Contributor.')
param roleDefinitionResourceId string  = 'b24988ac-6180-42a0-ab88-20f7382dd24c'

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module storageResource 'storage.bicep' = {
  name: storageName
  params: {
    storageName:storageName
    roleDefinitionResourceId: roleDefinitionResourceId
  }
  scope:ResourceGroup
}
