---
created: 2023-04-18T07:58
updated: 2024-02-19T15:40
---
Branch: (Config/MR/DailyMerge/2024-02-19)

Daily Merge to Dev 2024-02-19


| Repo | PR |
| ---- | ---- |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996) | NA |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | NA |
|  |  |


## Try running these and see if it works, might need refining in the template:

### Client

``` cmd
git checkout Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-02-19 Development
git merge --no-ff  Integration
```

### Core

``` cmd
git checkout development; git fetch origin; git pull
git checkout integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-02-19 development
git merge --no-ff  integration
```

