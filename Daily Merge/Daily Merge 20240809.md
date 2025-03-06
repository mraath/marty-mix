---
created: 2023-04-18T07:58
updated: 2024-08-09T10:36
---
Branch: (Config/MR/DailyMerge/2024-08-09)

Daily Merge to Dev 2024-08-09

| Repo                                                                                                                                                                                                                                                       | PR                                                                                                                                                             |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [DB](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291)        | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/108046)<br>DEV had many duplicates<br>Used INT, copied in missing DEV refs |
| [BE](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0&targetRepositoryId=0c9dafba-9e19-4319-886b-c0129c70b7d0) | [Pull Request](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/108047)                                                             |
| [UI](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequestcreate?sourceRef=Integration&targetRef=Config/Development&sourceRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033&targetRepositoryId=50990761-1b3a-4829-ada1-584fd7f03033)    | NA                                                                                                                                                             |
|                                                                                                                                                                                                                                                            |                                                                                                                                                                |


## Try running these and see if it works, might need refining in the template:

### DB, BE, UI

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Config/Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-08-09 Config/Development
git merge --no-ff  Integration
```

## Conflicts

### DB

In DEV, not in INT

```txt
861:
<Build Include="Schemas\mobileunit\Stored Procedures\MobileUnit_GetDefaultEventIdsByMobileDeviceType.sql" />
892:
<Build Include="Schemas\library\Stored Procedures\Locations_GetLibraryLocation.sql" />
<Build Include="Schemas\library\Stored Procedures\Locations_GetLibraryLocationByDmxLocationId.sql" />
<Build Include="Schemas\library\Stored Procedures\Locations_InsertLibraryLocation.sql" />
<Build Include="Schemas\library\Stored Procedures\Locations_UpdateLibraryLocationsByDmxLocationId.sql" />
980:
<Build Include="Schemas\definition\Stored Procedures\Events_GetDefaultEventsActionsAndConditions.sql" />
```


"C:\Projects\Database\DeviceConfiguration\Schemas\mobileunit\Stored Procedures\GetDefaultEventIdsByMobileDeviceType.sql" does not exist.

##[_error_]C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\Microsoft.Common.CurrentVersion.targets(5128,5): _Error_ MSB3030: Could not copy the file "D:\b\1\_work\2808\s\DeviceConfiguration\Scripts\DeploymentScripts\Data\DeviceScriptsData.xml" because it was not found.

```txt
DeviceConfiguration\Scripts\DeploymentScripts\Data\DeviceScriptsData.xml
```

### BE

MiX.ConfigInternal.Api.Client.2024.13.20240730.3-beta
MiX.DeviceIntegration.Common.2024.13.20240730.2
