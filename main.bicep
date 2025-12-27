
@description('Azure region for all resources')
param location string = 'Norway East'

@description('Admin username for the Linux VM')
param adminUsername string = 'azureuser'

@description('Enterprise Virtual Network')
resource vnet 'Microsoft.Network/virtualNetworks@2022-09-01' = {
  name: 'vnet-secure'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'web'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsgWeb.id
          }
        }
      }
      {
        name: 'app'
        properties: {
          addressPrefix: '10.0.2.0/24'
          networkSecurityGroup: {
            id: nsgApp.id
          }
        }
      }
      {
        name: 'mgmt'
        properties: {
          addressPrefix: '10.0.3.0/24'
        }
      }
    ]
  }
}

       
resource nsgWeb 'Microsoft.Network/networkSecurityGroups@2022-09-01' = {
  name: 'nsg-web'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHTTP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          destinationPortRange: '80'
        }
      }
      {
        name: 'AllowHTTPS'
        properties: {
          priority: 110
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
        }
      }
    ]
  }
}

@description('NSG for App subnet')
resource nsgApp 'Microsoft.Network/networkSecurityGroups@2022-09-01' = {
  name: 'nsg-app'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowFromWeb'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '10.0.1.0/24'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

@description('Secure NIC without Public IP')
resource nic 'Microsoft.Network/networkInterfaces@2022-09-01' = {
  name: 'nic-secure'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          subnet: {
            id: vnet.properties.subnets[1].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

@description('Secure Linux VM (No Public IP)')
resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: 'vm-secure'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: 'securevm'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
    }
  }
}

        
