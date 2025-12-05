---
created: 2023-04-18T07:58
updated: 2025-11-25T06:58
---
Branch: (Config/MR/DailyMerge/{{date}})

Daily Merge to Dev {{date}}

| Repo                                                                                                                                                                                                                                                                        | PR           | Note |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ---- |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)                         | Pull Request |      |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)                  | Pull Request |      |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)                     | Pull Request |      |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | Pull Request |      |
| [Config API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958)           | Pull Request |      |
| [OLD API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6&targetRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6)    | Pull Request | NA   |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | Pull Request |      |
| [FR UI](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482&targetRepositoryId=03d31640-4d3a-403e-b223-acef8eb64482)   | Pull Request |      |
| [FR API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48&targetRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48) | Pull Request |      |


Daily Merge: DB, BE, UI: NA
Daily Merge: Core, Api, Client: NA

## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} Config/Development; git merge --no-ff  Integration
```

### Core

``` cmd
git checkout integration; git fetch origin; git pull
git checkout development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} development; git merge --no-ff  integration
```

### API (OLD and NEW), Client, FR UI, FR API

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} Development; git merge --no-ff  Integration
```

