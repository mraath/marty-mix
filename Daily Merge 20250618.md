---
created: 2023-04-18T07:58
updated: 2025-06-18T10:39
---
Branch: (Config/MR/DailyMerge/2025-06-18)

Daily Merge to Dev 2025-06-18

| Repo                                                                                                                                                                                                                                                       | PR                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)        | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/126296)        |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0) | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/126297) |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)    | Pull Request                                                                                       |
My BE got all messed up again. First some files locked... then merge conflicts.

Daily Merge: DB, BE, UI: NA

## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-06-18 Config/Development
git merge --no-ff  Integration
```
