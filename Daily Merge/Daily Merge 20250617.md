---
created: 2023-04-18T07:58
updated: 2025-06-17T16:08
---
Branch: (Config/MR/DailyMerge/2025-06-17)

Daily Merge to Dev 2025-06-17

| Repo                                                                                                                                                                                                                                                       | PR                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)        | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/126227)        |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0) | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/126232) |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)    | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/126234)    |
For the BE issues... I kept:
MiX.ConfigInternal.Api.Client.2025.11.20250611.1-beta



Daily Merge: DB, BE, UI: NA

## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2025-06-17 Config/Development
git merge --no-ff  Integration
```

From the BE, what I can see.... 

I kept the following, assuming a DEV needs this and the latter one was just nice to have.

- ⁠MiX.ConfigInternal.Api.Client.2025.11.20250611.1-beta