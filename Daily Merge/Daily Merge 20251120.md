---
wiki_ingested: 2026-05-28
created: 2023-04-18T07:58
updated: 2025-11-20T08:46
---
Branch: (Config/MR/DailyMerge/2025-11-20)

Daily Merge to Dev 2025-11-20

| Repo                                                                                                                                                                                                                                                       | PR                                                                              | Note |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ---- |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)        | https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/134627     |      |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0) | na                                                                              |      |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)    | https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/134628 |      |


Daily Merge: DB, BE, UI: NA
Daily Merge: Core, Api, Client: NA

## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-11-20 Config/Development
git merge --no-ff  Integration
```
