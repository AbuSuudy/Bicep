//az bicep build --file main.bicep
metadata name = 'Kusto Cluster'
metadata description = 'This module deploys a Kusto Cluster.'
metadata owner = 'Azure/module-maintainers'

targetScope = 'resourceGroup'

@minLength(4)
@maxLength(22)
@description('Required. The name of the Kusto cluster which must be unique within Azure.')
param name string = 'adxtstcluster'

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Required. The SKU of the Kusto Cluster.')
param sku string = 'Dev(No SLA)_Standard_E2a_v4'

@description('Optional. The number of instances of the Kusto Cluster.')
param capacity int = 1

@description('Optional. The tier of the Kusto Cluster.')
param tier string  = 'Standard'

@description('Optional. The tier of the Kusto Cluster.')
param engineType string  = 'V3'

resource symbolicname 'Microsoft.Kusto/clusters@2023-08-15' = {
  name: name
  location: location
  sku: {
    capacity: capacity
    name: sku
    tier: tier
  }
  properties: {
    allowedIpRangeList: [
      '185.251.10.0/24'
      '136.228.224.0/24'
    ]
    engineType: engineType
    optimizedAutoscale: {
      isEnabled: false
      maximum: 1
      minimum: 1
      version: 1
    }
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
  }
}
