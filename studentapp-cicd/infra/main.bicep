targetScope = 'subscription'
param location string = 'eastus'
param appServicePlanName string = 'studentapp-plan'
param appInsightsName string = 'studentapp-insights'
param webAppName string = 'studentapp-web'
param resourceGroupName string = 'studentapp-rg'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module appServicePlanModule 'appserviceplan.bicep' = {
  name: 'appServicePlanDeployment'
  scope: resourceGroup
  params: {
    appServicePlanName: appServicePlanName
    location: location
  }
}

module appInsightsModule 'appinsights.bicep' = {
  name: 'appInsightsDeployment'
  scope: resourceGroup
  params: {
    appInsightsName: appInsightsName
    location: location
  }
}

module webAppModule 'webapp.bicep' = {
  name: 'webAppDeployment'
  scope: resourceGroup
  params: {
    location: location
    appServicePlanId: appServicePlanModule.outputs.appServicePlanId
    appInsightsInstrumentationKey: appInsightsModule.outputs.appInsightsInstrumentationKey
    appInsightsConnectionString: appInsightsModule.outputs.appInsightsConnectionString
    webAppName: webAppName
  }
}
