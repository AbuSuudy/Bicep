//Create managementGroup and subscriptions
targetScope = 'managementGroup'

param resourceGroupName string
param resourceGroupLocation string
param storageName string

resource rootMG 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Root'
  scope: tenant()
  properties: {
    displayName: 'string'
  }
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

module resouceGrourp '2-ResourceGroup.bicep' = {
  name: 'ResourceGroup'
  params: {
    resourceGroupLocation:resourceGroupLocation 
    resourceGroupName: resourceGroupName
    storageName: storageName
    
  }
  scope: subscription(sub.name)
}
