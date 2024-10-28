//https://wmatthyssen.com/2021/04/29/azure-governance-how-to-change-the-default-management-group-for-new-subscriptions/
//az deployment mg create  --location uksouth --management-group-id testmg --template-file main.bicep --parameter functionResourceGroupName=funcRG storageResourceGroupName=StoreageRG location=uksouth

targetScope = 'managementGroup'

@description('Required.Resource group name for azure function.')
param functionResourceGroupName string

@description('Required.Resource group name for storage account.')
param storageResourceGroupName string


@description('Required. Location of resouce group and resouces.')
@allowed([
  'uksouth'
  'ukwest'
])
param location string

resource rootMG 'Microsoft.Management/managementGroups@2023-04-01' existing  = {
  name: 'Tenant Root Group'
  scope: tenant()
}

resource subMG 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'SubMG'
  scope: tenant()
  properties: {
    details: {
      parent: {
        id: rootMG.id
      }
    }
    displayName: 'string'
  }
}

resource sub 'Microsoft.Management/managementGroups/subscriptions@2021-04-01' = {
  name: 'string'
  parent: subMG
}

module resouceGroup 'resourcegroup.bicep' = {
  name: 'ResourceGroup'
  params: {
    location:location 
    functionResourceGroupName: functionResourceGroupName
    storageResourceGroupName : storageResourceGroupName
    
  }
  scope: subscription(sub.name)
}
