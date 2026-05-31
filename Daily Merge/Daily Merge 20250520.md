---
wiki_ingested: 2026-05-28
created: 2023-04-18T07:58
updated: 2025-05-20T14:59
---
Branch: (Config/MR/DailyMerge/2025-05-20)

Daily Merge to Dev 2025-05-20

| Repo                                                                                                                                                                                                                                                                        | PR           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | na           |
| [Config API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958)           | Pull Request |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | na           |

- [x] Config API to be decided: ✅ 2025-05-20

Option 1: [Pull requests - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958 "https://dev.azure.com/mixtelematics/deviceintegration/_git/config.api/pullrequestcreate?sourceref=integration&targetref=development&sourcerepositoryid=40493b38-c5e0-420a-8728-10dfcd7ea958&targetrepositoryid=40493b38-c5e0-420a-8728-10dfcd7ea958")
Option 2: [Pull requests - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2025-05-20&targetRef=Development&sourceRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958&targetRepositoryId=40493b38-c5e0-420a-8728-10dfcd7ea958 "https://dev.azure.com/mixtelematics/deviceintegration/_git/config.api/pullrequestcreate?sourceref=config/mr/dailymerge/2025-05-20&targetref=development&sourcerepositoryid=40493b38-c5e0-420a-8728-10dfcd7ea958&targetrepositoryid=40493b38-c5e0-420a-8728-10dfcd7ea958")

## Try running these and see if it works, might need refining in the template:

### API (OLD and NEW)

```cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-05-20 Development
git merge --no-ff  Integration

```
https://dev.azure.com/MiXTelematics/DeviceIntegration/DeviceIntegration%20Team/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Config%2fMR%2fDailyMerge%2f2025-05-20&targetRef=

