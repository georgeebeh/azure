resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'ebehlaunchstorage'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: 'ebehlaunchplan'
  location: 'eastus'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'ebehlaunchapp'
  location: 'eastus'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true 
  }
}

