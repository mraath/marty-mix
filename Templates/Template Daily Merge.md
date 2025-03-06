---
created: 2023-04-18T07:58
updated: 2024-07-12T09:17
---
Branch: (Config/MR/DailyMerge/{{date}})

Daily Merge to Dev {{date}}

| Repo                                                                                                                                                                                                                                                                        | PR           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)                         | Pull Request |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)                  | Pull Request |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)                     | Pull Request |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | Pull Request |
| [API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6&targetRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6)        | Pull Request |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | Pull Request |

## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} Config/Development
git merge --no-ff  Integration
```

### Core

``` cmd
git checkout integration; git fetch origin; git pull
git checkout development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} development
git merge --no-ff  integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=Config/MR/DailyMerge/{{date}}&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679

### API

```cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} Development
git merge --no-ff  Integration

```
https://dev.azure.com/MiXTelematics/DeviceIntegration/DeviceIntegration%20Team/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Config%2fMR%2fDailyMerge%2f{{date}}&targetRef=

### Client

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/{{date}} Development
git merge --no-ff  Integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Config/MR/DailyMerge/{{date}}&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996

