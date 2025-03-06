Branch: (Config/MR/DailyMerge/2023-10-09)

Daily Merge to Dev 2023-10-09

| Repo                                                                                                                                                                                                                                                                        | PR    |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)                     | [Pull request 92212: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/92212) |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0)                  | [Pull request 92213: Daily Merge with merge issues - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/92213) |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)                         | [Pull request 92211: Daily Merge - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/92211) |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | NA |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | NA |
|                                                                                                                                                                                                                                                                             |       |

**Please note**: BE I kept what was in DEV in case of a conflict regarding nugets, knowing Justus spent a LOT of time last week to figure out this craziness :-) I did it for the following nugets:
- MiX.DeviceConfig.Api.Client
- MiX.DeviceIntegration.Common
- MiX.ConfigInternal.Api.Client

This ended up not working, as the BE was calling IsDeviceAvailableForLibraryForAEMP. This was used by Chad 6 days ago on INT. Our DEV client didn't have this in. I built a new DEV client and updates the nugets accordingly: MiX.DeviceConfig.Api.Client.2023.16.20231009.1-beta (This seems to be working)


## Try running these and see if it works, might need refining in the template:

### UI, BE, DB

``` cmd
git checkout Config/Development && git fetch origin && git pull
git checkout Integration && git fetch origin && git pull
git checkout -b Config/MR/DailyMerge/2023-10-09 Config/Development
git merge --no-ff  Integration
```

### Client

``` cmd
git checkout Development
git fetch origin
git pull
git checkout Integration
git fetch origin
git pull
git checkout -b Config/MR/DailyMerge/2023-10-09 Development
git merge --no-ff  Integration
```

### Core

``` cmd
git checkout development
git fetch origin
git pull
git checkout Integration
git fetch origin
git pull
git checkout -b Config/MR/DailyMerge/2023-10-09 development
git merge --no-ff  Integration
```

