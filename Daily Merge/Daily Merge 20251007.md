---
wiki_ingested: 2026-05-28
created: 2023-04-18T07:58
updated: 2025-10-07T15:19
---
Branch: (Config/MR/DailyMerge/2025-10-07)

Daily Merge to Dev 2025-10-07

| Repo                                                                                                                                                                                                                                                                     | PR           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ |
| [OLD API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6&targetRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6) | Pull Request |
Daily Merge: Core, Api, Client: NA

## Try running these and see if it works, might need refining in the template:


### API (OLD and NEW)

```cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-10-07 Development
git merge --no-ff  Integration

```
https://dev.azure.com/MiXTelematics/DeviceIntegration/DeviceIntegration%20Team/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Config%2fMR%2fDailyMerge%2f2025-10-07&targetRef=
