Branch: (Config/MR/DailyMerge/2023-10-13)

Daily Merge to Dev 2023-10-13

| Repo                                                                                                                                                                                                                                                                        | PR    |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)                     | [Pull request 92510: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/92510) |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)                  | [Pull request 92511: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/92511) |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)                         | [Pull request 92512: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/92512) |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | NA |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | NA |
|                                                                                                                                                                                                                                                                             |       |

## Try running these and see if it works, might need refining in the template:

### UI: [[MiX.Fleet.UI]], BE: [[DynaMiX.Backend]], DB: [[Database]]

``` cmd
git checkout Config/Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-13 Config/Development
git merge --no-ff  Integration
```

### Client: [[MiX.DeviceConfig]]

``` cmd
git checkout Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-13 Development
git merge --no-ff  Integration
```

### Core:  [[MiX.DeviceIntegration.Core]]

``` cmd
git checkout development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-13 development
git merge --no-ff  Integration
```

