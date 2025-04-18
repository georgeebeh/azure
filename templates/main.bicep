param location string = 'westus3'
param storageAccountName string = 'ebehlaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'ebehlaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environmentType string


var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location 
    appServiceAppName: appServiceAppName 
    environmentType: environmentType
  }
}


output appServiceAppHostName string = appService.outputs.appServiceAppHostName
