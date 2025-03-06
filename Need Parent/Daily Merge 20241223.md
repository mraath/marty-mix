---
created: 2023-04-18T07:58
updated: 2024-12-23T08:07
---
Branch: (Config/MR/DailyMerge/2024-12-23)

Daily Merge to Dev 2024-12-23

| Repo                                                                                                                                                                                                                                                                        | PR           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | Pull Request |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | Pull Request |

## Try running these and see if it works, might need refining in the template:

### Core

``` cmd
git checkout integration; git fetch origin; git pull
git checkout development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-12-23 development
git merge --no-ff  integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2024-12-23&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679


### Client

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-12-23 Development
git merge --no-ff  Integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2024-12-23&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996

