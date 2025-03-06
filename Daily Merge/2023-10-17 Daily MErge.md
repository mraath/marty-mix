---
created: 2023-10-17T09:30
updated: 2023-10-17T10:00
---
Branch: (Config/MR/DailyMerge/2023-10-17)

Daily Merge to Dev [[2023-10-17]]

| Repo                                                                                                                                                                                                                                                                        | PR    |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)                     | [Pull request 92749: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/92749) |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)                  | [Pull request 92750: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/92750) |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)                         | [Pull request 92751: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/92751) |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | NA |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | [Pull request 92748: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/92748) |
|                                                                                                                                                                                                                                                                             |       |

Files from INT to double check in DB:

```xml
<Build Include="Schemas\mobileunit\Stored Procedures\MobileUnit_GetMobileDeviceSettings.sql" />
<Build Include="Schemas\mobileunit\Stored Procedures\MobileUnit_UpdateMobileUnitUniqueIdentifier.sql" />
```
## Try running these and see if it works, might need refining in the template:

### UI, BE, DB``

``` cmd
git checkout Config/Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-17 Config/Development
git merge --no-ff  Integration
```

### Client

``` cmd
git checkout Development; git fetch origin; git pull
git checkout Integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-17 Development
git merge --no-ff  Integration
```

### Core

``` cmd
git checkout development; git fetch origin; git pull
git checkout integration; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2023-10-17 development
git merge --no-ff  integration
```

