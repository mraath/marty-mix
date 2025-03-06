---
created: 2023-04-18T07:58
updated: 2024-07-19T14:27
---
Branch: (Config/MR/DailyMerge/2024-07-19)

Daily Merge to Dev 2024-07-19

| Repo                                                                                                                                                                                                                                                                        | PR                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [Core](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=integration&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679) | NA                                                                                                             |
| [API](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6&targetRepositoryId=36ee18d7-a2fd-49ea-9124-be4893a21fa6)        | NA                                                                                                             |
| [Client](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Integration&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996)         | [Pull Request](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/106556) |
**Please Note**: Only the client changed, however, to get things in sync with INT I had to overwrite any references to eg. Beta for eg. MiX.DeviceIntegration.Common
IF you need a Beta version please re-apply to the DEVELOPMENT client
## Try running these and see if it works, might need refining in the template:


### Core

``` cmd
git checkout integration; git fetch origin; git pull
git checkout development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-07-19 development
git merge --no-ff  integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2024-07-19&targetRef=development&sourceRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679&targetRepositoryId=40eeca32-3a77-4551-91a0-402d4c96d679

### API

```cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-07-19 Development
git merge --no-ff  Integration

```
https://dev.azure.com/MiXTelematics/DeviceIntegration/DeviceIntegration%20Team/_git/DynaMiX.DeviceConfig/pullrequestcreate?sourceRef=Config%2fMR%2fDailyMerge%2f2024-07-19&targetRef=

### Client

``` cmd
git checkout Integration; git fetch origin; git pull
git checkout Development; git fetch origin; git pull
git checkout -b Config/MR/DailyMerge/2024-07-19 Development
git merge --no-ff  Integration
```
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequestcreate?sourceRef=Config/MR/DailyMerge/2024-07-19&targetRef=Development&sourceRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996&targetRepositoryId=8812dade-4c8a-4218-ba13-9c7c4eaaa996

