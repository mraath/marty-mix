---
status: closed
date: 2022-11-01
comment: Test, then deploy to UAT. ON INT since 2 Nov 2022.
priority: 8
---

Date: 2022-11-01 Time: 10:33
Parent:: xxxx
Friend:: [[2022-11-01]]
JIRA:QA-5075 Detailed Trip Specific Scenario test

# QA-5075 Detailed Trip Specific Scenario test

## Image

## Deployments

- INT: [Pull request 75522: QA-5075 Fix asset last trip is earlier than last trip date - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/75522)
- 2 Nov 2022 already in Dev Test

## Test cases

- 1.  WORK
    https://uat.mixtelematics.com/DynaMiX.API/timeline/sites/-9172265539221067989/asset/1292254275467612160/textSummary?from=2022-11-01T11:18:51&to=2022-11-01T11:27:55
- 2. BROKEN (because date is old)
	- https://uat.mixtelematics.com/DynaMiX.API/timeline/sites/-9172265539221067989/asset/1292254275467612160/textSummary?from=2022-11-01T11:18:51&to=2022-11-01T11:06:50

## Workflow

- UI
- new UIModuleHyperMediaLink(TripTimelineModule.ModuleRoutes.GET_LAST_TRIP_START_ASSET.ToLinkCarrier("getAssetLastTripStart"), ConfigAdminPermissions.CAN_ACCESS_ASSET_COMMISSIONING_TECHNICIANS_DATA),
	- GetAssetLastTripStart
		- GetLastTripForAsset
			- TripsClient.GetLastTripSummaryForEntitiesAsync (Fleet Service) OR Repo...
			- TripStart
- getTextSummary
	- 

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API      |     |
| -------- | --- |
| 22.16    |     |
| INT      |     |
| NEXT UAT |     |

## Branch
Config/MR/Bug/QA-5075_Detailed_Trip_Specific_Scenario_test.22.16.ORI

## Learned

## Description

## Code sections

## Files

## Resources

## Notes

