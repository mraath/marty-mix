---
created: 2023-04-18T07:58
updated: 2025-05-22T12:16
---
Branch: (Config/MR/DailyMerge/2025-05-22)

Daily Merge to Dev 2025-05-22

| Repo                                                                                                                                                                                                                                                                        | PR           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | na           |
| [Config API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958)           | na           |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | Pull Request |

Daily Merge: Core, API, Client: NA

## Try running these and see if it works, might need refining in the template:

### Client

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-05-22 Development
git merge --no-ff  Integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2025-05-22&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996

