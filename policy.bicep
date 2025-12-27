targetScope = 'subscription'

@description('Deny creation of Public IP addresses')
resource denyPublicIP 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'deny-public-ip'
  properties: {
    displayName: 'Deny Public IP creation'
    description: 'Prevents creation of Public IP addresses across the subscription'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Network/publicIPAddresses'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
