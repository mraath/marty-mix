Date: 2022-04-22 Time: 10:35
Status: #closed  
Friend: [[DIE-485 DI Config Asset config file]]
JIRA:DIE-503
[DIE-503 Convert the Asset Config File to 18.17 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/DIE-503)

# Convert the Asset Config File to 18.17

## Repos

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang    | UI    | BE    | Client | API    | Common | DB     |
| ------- | ----- | ----- | ------ | ------ | ------ | ------ |
| 18.17   | 18.17 | 18.17 | 18.17  | 18.17  | 18.17  | 18.17  |
| ??      | 1/2   | ??    | ??     | ??     | na!    | Builds |
| Master? | ?     | ?     | move!  | Merged | moved  | Merged |
|         | PR    | PR    |        | PR     |        | PR     |


## LATEST DB

https://mixtelematics.visualstudio.com/_apis/resources/Containers/32641659/OLTP%20Deployment?itemPath=OLTP%20Deployment%2FOLTP%20Deployment.zip

## Build pipelines
![[18.17#Build pipelines 18 17]]

## Builds

DB: Success: [Pipelines - Run 18.17_2022.05.10.1 (visualstudio.com)](https://mixtelematics.visualstudio.com/Common/_build/results?serviceHost=30fedb8b-668a-453c-baae-ae0f7be166b6%20%28MiXTelematics%29&buildId=168503&view=results&j=fd490c07-0b22-5182-fac9-6d67fe1e939b)
UI: Success: [Pipelines - Run 18.17_2022.05.10.1 (visualstudio.com)](https://mixtelematics.visualstudio.com/Common/_build/results?buildId=168533&view=results)
BE: Success: [Pipelines - Run 18.17_2022.05.10.1 (visualstudio.com)](https://mixtelematics.visualstudio.com/Common/_build/results?serviceHost=30fedb8b-668a-453c-baae-ae0f7be166b6%20%28MiXTelematics%29&buildId=168532&view=results&j=fd490c07-0b22-5182-fac9-6d67fe1e939b)
API: Success: [Pipelines - Run 18.17_2022.05.10.1 (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?serviceHost=30fedb8b-668a-453c-baae-ae0f7be166b6%20%28MiXTelematics%29&buildId=168511&view=results&j=fd490c07-0b22-5182-fac9-6d67fe1e939b)



## CR

The issue:
Outdated
[issue](https://jira.mixtelematics.com/browse/DIE-503?focusedCommentId=381563&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-381563)


[CR-1373 DIE-503 Convert the Asset Config File to 18.17 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/CR-1373)
[CR-1379 OMAN: DIE-503 Convert the Asset Config File to 18.17 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/CR-1379)
[CR-1380 ALG: DIE-503 Convert the Asset Config File to 18.17 - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/CR-1380)

## Deploys

![[18.17#Deployment]]

## OMAN


[https://confluence.mixtelematics.com/display/CT/Production](https://confluence.mixtelematics.com/display/CT/Production "https://confluence.mixtelematics.com/display/ct/production")

OMN
HSOMNAPP03
Devices**

OMN
HSOMNAPP09
DIS

OMN
HSOMNMSMQ03
DIS MSMQ

OMN
**HSOMNIIS14**
Config API

OMN
**HSOMNIIS15**
Config API

OMN
**HSOMNIIS18,19**
DynaMiX API, TechTool API

## Deployment notes

DB artifact: https://mixtelematics.visualstudio.com/809964f7-75ce-4260-a0d3-d1812d16d363/_apis/build/builds/168503/artifacts?artifactName=OLTP%20Deployment&api-version=7.0&%24format=zip

https://mixtelematics.visualstudio.com/_apis/resources/Containers/32641659/OLTP%20Deployment?itemPath=OLTP%20Deployment%2FOLTP%20Deployment.zip

https://mixtelematics.visualstudio.com/Common/_build/results?buildId=169059&view=results
## Client

Client
[[18.17]] build steps...

- [x] BE: EventClassMap

C:\Projects\MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Enums\AssetConfigurationAction.cs

![](https://lh3.googleusercontent.com/pw/AM-JKLVM-r62-Xrxq1RHb0CtLVvou5dr8ClA80krbPUa8wD0ZmT1WowdHcclFcXDtqE7QtbPD9DGFezbi9RkpsJCRsB16I9hydKrbIy_FTIPuAj_vSQ24UfAAMrasAgpvGXY-YpoijHCYJPLP2yfD7AZ9pBX=w544-h257-no?authuser=0)

## Branch
Config/MR/Feature/DIE-485_DIConfigAssetconfigfile.18.17.MergeAttemps

## Stappe

- Toets rou repos
- Merge
- Toets of steeds bou