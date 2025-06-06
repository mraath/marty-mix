---
created: 2025-06-06T10:05
updated: 2025-06-06T10:08
---
## Paul 

The following issue happens

![[CORS Unity Frangular UI.png]]

## Tim

Hi guys, I believe this issue should be related to CORS not being configured or maybe wrong settings being used. Please see an example here of how we configured it. The notable ones will be the unityaiot urls you need to include in the settings.

Appsettings

[https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.API?path=/Fleet.Services.Operations.Web.API/appsettings.UK.json](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.API?path=/Fleet.Services.Operations.Web.API/appsettings.UK.json "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.api?path=/fleet.services.operations.web.api/appsettings.uk.json")

Startup
![[CORS Unity Frangular UI Solutions by Tim.png]]

## Justus

Ok so our startup file does not have that      builder.SetIsOriginAllowedToAllowWildcardSubdomains();

![[CORS Unity Frangular UI Justus 1.png]]

We also dont have any wildcards in our appsettings file..

![[CORS Unity Frangular UI Justus 2.png]]

## Zeshan

Some trials: [Pull request 125792: Update for UK URL - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/125792 "https://dev.azure.com/mixtelematics/deviceintegration/_git/mix.config.frangular.ui/pullrequest/125792")
Some more trials : [Pull request 125797: Additional allowed origins added - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/125797 "https://dev.azure.com/mixtelematics/deviceintegration/_git/mix.config.frangular.api/pullrequest/125797")
