---
created: 2024-02-14T06:50
updated: 2024-02-14T06:50
---
[Pull request 97933: Daily Merge Client - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/97933)
- [Pull request 97934: Daily Merge Core - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/97934)

| Repo | PR |
| ---- | ---- |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996) | XXXXX |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | XXXXX |
|  |  |

## Try running these and see if it works, might need refining in the template:

### Client

``` cmd
git checkout Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-02-13 Development
git merge --no-ff  Integration
```

### Core

``` cmd
git checkout development; git fetch origin; git pull
git checkout integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-02-13 development
git merge --no-ff  integration
```
