---
status: busy
comment:
priority: 1
created: 2023-04-18T07:58
updated: 2025-12-05T10:22
---
Branch: (Config/MR/DailyMerge/2025-12-05)

Daily Merge to Dev 2025-12-05

| Repo                                                                                                                                                                                                                                                                        | PR                                                                                                                       | Note |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ---- |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/135683) |      |
| [Config API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958)           | [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/135684)                 |      |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/135685)           |      |
| [FR UI](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482&targetRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482)   | [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135687)    | done |
| [FR API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48&targetRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48) | na                                                                                                                       |      |


Daily Merge: DB, BE, UI: NA


### API (OLD and NEW), Client, FR UI, FR API

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-12-05 Development; git merge --no-ff  Integration
```

