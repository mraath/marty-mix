Date: 2022-08-01 Time: 14:12
Status: 
Friend: [[2022-08-01]]
Parent:: [[AC]]
JIRA:AC-357
[AC-357 New endpoint to be added to find and assign the default config group - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/AC-357)

# AC-357 Find and assign the default config group

## Image
Child:: ![[Change Config.excalidraw]]

## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| DB     | Client | API    |
| ------ | ------ | ------ |
| 22.13  | 22.13  | 22.13  |
| DEV    | DEV    | DEV    |
| PR INT | PR INT | PR INT |

## PRs

- API: DEV: [Pull request 72424: AC-357: Fixed some "connection closed" and "FK Constraints" by using differe... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/72424)
- API: INT: [Pull request 72465: AC-357: Merging to INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/72465)
- DB: DEV:   Config/MR/AC-357_DEV_NA > Dev
- D: INT: [Pull request 72464: AC-357: Get the default config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/72464)
- Client: DEV: [Pull request 72439: AC-357: merge to dev - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/72439)
- Client: INT: [Pull request 72466: AC-357: Merge to INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/72466)

into

Config/Development


## CODE

- DB: [template].[Template_GetDefaultConfigurationGroupId]
- 

## Branch
Config/MR/Bug/AC-357_Find_and_assign_default_config_group.22.13.ORI

## Testing notes

Notebook test: xxxxxxxx

Auth: Get
GroupId: 6392271753943902318
AssetId: 1295898026999439360
Profile: easy

- [x] Convert this to Jupiternotebook test: curl -X PUT --header 'Accept: application/json' 'http://localhost/DynaMiX.DeviceConfig.Services.API/api/dynamic-can/groups/6392271753943902318/assets/6392271753943902318/installation-profiles/easy/set-default-config-group?authToken=53cd9044-2ce2-4235-aa02-c148b8cacb01'

Bench Units 2020
assetid=1154902265568632832
orgId=3222089765699420885

http://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1154902265568632832&orgId=3222089765699420885

## ERROR

The INSERT statement conflicted with the FOREIGN KEY constraint "FK_AssetMobileUnits_MobileUnits". The conflict occurred in database "DeviceConfiguration", table "mobileunit.MobileUnits", column 'MobileUnitKey'.
The statement has been terminated.

## Testing

- Create new asset WITHOUT adding it to a config group
- Run unit test
- Test to see if in DB
```sql
USE DeviceConfiguration

SELECT TOP 5  * FROM mobileunit.AssetMobileUnits WHERE MobileUnitKey = 0 OR AssetId = 1299395021392613376

SELECT TOP 5  * FROM mobileunit.MobileUnits WHERE MobileUnitKey = 57204
```

## Learned

DB: DeviceIntegration: ConfigurationGroups: IsDefault

```xml
<device id="-5678077773610990815" type="0" systemName="MobileDevice.MiX3000">
<device id="6183256567829462590" type="0" systemName="MobileDevice.MiX4000">
```

```sql
DECLARE @GroupId BIGINT = 6392271753943902318; --5373602768183155046
DECLARE @DeviceId BIGINT = -5678077773610990815; --MiX3K

DECLARE @ConfigurationGroupId BIGINT;
DECLARE @MiX3000 BIGINT = -5678077773610990815;
DECLARE @MiX4000 BIGINT = 6183256567829462590;

DECLARE @ConfigGroups TABLE (
	DeviceId BIGINT,
	ConfigurationGroupId BIGINT
)

INSERT INTO @ConfigGroups
	SELECT 
		dd.DeviceId,
		tcg.ConfigurationGroupId
	FROM [definition].[Devices] dd WITH (NOLOCK)
	INNER JOIN [template].[MobileDeviceTemplates] tmdt WITH (NOLOCK)
		ON tmdt.MobileDeviceKey = dd.DeviceKey
	INNER JOIN template.ConfigurationGroups tcg WITH (NOLOCK)
		ON tcg.MobileDeviceTemplateKey = tmdt.MobileDeviceTemplateKey
	WHERE dd.DeviceId IN (@MiX3000, @MiX4000)
	AND tcg.IsDefault = 1
	AND tcg.LibraryKey = (
			SELECT LibraryKey
			FROM [library].[Libraries] WITH (NOLOCK)
			WHERE GroupId = @GroupId)

--SELECT * FROM @ConfigGroups --REMOVE

SET @ConfigurationGroupId = (
	SELECT ConfigurationGroupId 
	FROM @ConfigGroups
	WHERE DeviceId = @DeviceId
	)

if (@ConfigurationGroupId IS NULL
	AND @DeviceId <> @MiX4000)
	BEGIN
		SET @ConfigurationGroupId = (
			SELECT ConfigurationGroupId 
			FROM @ConfigGroups
			WHERE DeviceId = @MiX4000
			)
	END

SELECT @ConfigurationGroupId ConfigurationGroupId

----------------------------------------------------
--Singular below... can ignore for the simpler above
----------------------------------------------------

--MiX3K, MiX4K
SELECT * 
FROM [definition].[Devices] 
WHERE DeviceId in (-5678077773610990815, 6183256567829462590)

SELECT TOP 10 * 
FROM [definition].[MobileDevices]
WHERE DeviceKey in (10119, 323)


SELECT top 10 * 
FROM template.ConfigurationGroups
WHERE IsDefault = 1
AND MobileDeviceTemplateKey IN (
	SELECT MobileDeviceTemplateKey
	FROM [template].[MobileDeviceTemplates]
	WHERE MobileDeviceKey in (10119, 323)
	AND LibraryKey = @LibraryKey)


/*
SELECT * 
FROM [template].[MobileDeviceTemplates]
WHERE MobileDeviceTemplateKey IN (33118, 33128)

--DeviceId
SELECT TOP 5 * FROM [definition].[Devices] WHERE SystemName like '%3000%'
SELECT TOP 5 * FROM [library].[Devices]
SELECT TOP 5 * FROM [template].[Devices]
*/

--Set one as default
UPDATE template.ConfigurationGroups 
SET IsDefault = 1
WHERE ConfigurationGroupId = -8126655682067440340
```

## Description

I will try to find a default for MiX300, if not found, 
	get the one or MiX4000, if still not, 
		return error

It depends on: [AC-364 Flag default config group as default - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/AC-364)

AssetId
Install Type

## Code sections

## Files

## Resources
- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
	- UpdateAssetConfigGroup
- Fleet Services
	- [AssetCommsDetails - Search Code - Search (azure.com)](https://dev.azure.com/MiXTelematics/Fleet/_search?action=contents&text=AssetCommsDetails&type=code&lp=code-Project&filters=ProjectFilters%7BFleet%7DRepositoryFilters%7BFleet.Services%7D&pageSize=25&result=DefaultCollection/Fleet/Fleet.Services/GBIntegration//MiX.Fleet.Services.Api.Client/Repositories/AssetsRepository.cs)

## Notes

