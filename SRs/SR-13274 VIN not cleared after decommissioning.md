---
status : closed
date : 2022-07-13
comment : 
priority: 
---

Date: 2022-08-02 Time: 11:35
Friend: [[2022-08-02]]
JIRA:SR-13274
[SR-13274 VIN not cleared after decommissioning - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13274)
Similar: [[SR-13368 VIN field locked with partial date as entry_ Source CAN BUS]]

NEXT: [Pipelines - Run 22.14_2022.09.28.3 (azure.com)](https://dev.azure.com/MiXTelematics/Common/_build/results?buildId=192545&view=results)


# SR-13274 VIN not cleared after decommissioning

## Code

| BE     |     |
| ------ | --- |
| 22.14  |     |
| INT    |     |
| PR UAT |     |

- Branch: Config/MR/Bug/SR-13274_ClearVinSource.22.14.ORI

## So the issue was not with OEM
- It was for a MiX4k
- I had a look at the workflow for decommissioning
- By adding in the following it should work
```c#
fleetAsset.VinSource = VinUpdateSource.MANUAL; //<< Add this

AssetsClient.UpdateAsync(fleetAsset ...

//AssetManager.UpdateAssetData (line +- 1526)
//BEFORE RemoveAsset method
```
- 

## MORE info
- NAVISTAR OEM
- asset: 1306763486145396736
- ORG: 1586886421086112286
- VIN: 1G1PG5SB2G7118759
- https://app.logz.io/#/goto/d6e5aef1988a4e9f7e330c2747e6fb09?switchToAccountId=157279
- THIS ONE WORKED WELL AND I COMMENTED ACCORDING ON THIS STORY

## Next
- ANY occurance of: "AssetId {mobileUnitMapping.AssetId} sent to Comms for OEM Un Enrollment"
	- https://app.logz.io/#/goto/2c4d8165c8169b4f1158af52909f216a?switchToAccountId=157279
	- NONE
	- https://jira.mixtelematics.com/browse/OEM-179
	- 
- !! TEST the OEM decommissioning on INT - and see all statusses!!
	- CSO-RSA / Rudi's organisation / US Site Timezone
		- Steve's Ford
		- (spoke to Brandon about OEM)
		- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1210308123739193344&orgId=-1454670768671264798)
		- id=1210308123739193344
		- orgId=-1454670768671264798
		- Not Source: CAN Bus
	- Dynamic CAN Org 1
		- (Marvin more for CAN stuff)
		- Source: CAN Bus
		- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1296860063921340416&orgId=1586886421086112286)
		- id=1296860063921340416
		- orgId=1586886421086112286
		- VIN: 1FMPK195070012262
		- SQL
			- xxxxxxxxxx
		- LOG:
			- https://app.logz.io/#/goto/5468359c8fa1fd36fe249bc56cf3a753?switchToAccountId=157279
- Check the logs
- Previous examples
	- VIN: 1G1PG5SB2G7118759 (Already handled in a comment)
		- id=900929765877194752
		- orgId=-3715716203281666037
```sql
--Search VIN, then paste BASE org and assetid
DECLARE @assetId BIGINT = 900929765877194752;
DECLARE @orgId BIGINT = -3715716203281666037;
DECLARE @deviceId BIGINT = -7567965444832338102;

-- ORG INFO
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId IN (@orgId)
DECLARE @liOrgID INT = (SELECT OrganisationId FROM FMOnlineDB.dynamix.Organisations WHERE GroupId IN (@orgId))

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @liOrgID
DECLARE @sDB NVARCHAR(250) = (SELECT sConnectDatabase
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @liOrgID)

-- ASSET INFO
USE INTERNALMiXNorthAmerica_2014;												--<< CHANGE HERE
SELECT VinNumber, * FROM dynamix.Assets WHERE AssetId IN (@assetId)
SELECT * FROM dbo.Vehicles WHERE iVEhicleID IN (SELECT VehicleId FROM dynamix.Assets WHERE AssetId IN (@assetId))

-- MOBILE INFO
USE DeviceConfiguration;
SELECT * FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId
SELECT * FROM mobileunit.AssetMobileUnits WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId)
SELECT * FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId)
--Loaded config: 5907119
SELECT * FROM mobileunit.MobileUnits WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId)
SELECT * FROM definition.MobileDevices WHERE DeviceKey IN (SELECT DISTINCT MobileDeviceKey FROM mobileunit.MobileUnits WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId))
SELECT * FROM template.ConfigurationGroups WHERE ConfigurationGroupKey in (SELECT DISTINCT ConfigurationGroupKey FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId))
Select * from definition.ConfigurationStatuses Where ConfigurationStatus IN (SELECT DISTINCT ConfigurationStatus FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitKey in (SELECT Distinct MobileUnitKey FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = @assetId))
--Select * from definition.DeviceTypes WHERE DeviceType = 1

--ENABLED
DECLARE @IsEnabled bit = 
  (SELECT 
        CASE WHEN md.[TemplateDeviceKey] IS NOT NULL THEN md.[IsEnabled] ELSE td.[IsEnabled] END
    FROM [mobileunit].MobileUnits mu 
    INNER JOIN [mobileunit].[AssetMobileUnits] amu ON amu.[MobileUnitKey] = mu.[MobileUnitKey]
    INNER JOIN [template].[ConfigurationGroups] cg ON mu.[ConfigurationGroupKey] = cg.[ConfigurationGroupKey]
    INNER JOIN [template].[Devices] td ON cg.[MobileDeviceTemplateKey] = td.[MobileDeviceTemplateKey]
    INNER JOIN [definition].[Devices] dd ON dd.DeviceKey = td.DeviceKey
    LEFT JOIN [mobileunit].[OverridenDevices] md ON mu.[MobileUnitKey] = md.[MobileUnitKey] AND td.[TemplateDeviceKey] = md.[TemplateDeviceKey]
    WHERE
      amu.AssetId = @assetId
      AND dd.DeviceId = @deviceId)
SELECT ISNULL(@IsEnabled, 0)

--DP
USE [DeviceConfiguration.DataProcessing];
Select * FROM state.MobileUnitState WHERE MobileUnitId = @assetId
Select * FROM state.MobileUnitStateHistory WHERE MobileUnitId = @assetId
Select * FROM state.MobileUnitMessage WHERE MobileUnitId = @assetId
Select * FROM state.MobileUnitMessageStateHistory WHERE MobileUnitId = @assetId

--WHERE LegacyVehicleId = 2 AND LegacyOrgId = 1 --@assetId
```
- 
	- Log
		- VIN: 1G1PG5SB2G7118759
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/18/2022 2:08:56 PM |CorrelationId:**1296983758620848128** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 500 (Error occured at Route:/api/assets |Date:8/27/2022 7:06:35 PM |CorrelationId:**1300320143290494976** |Error:System.Exception: Vin 1G1PG5SB2G7118759 already exists. Asset 900929765877194752 (Org: -3715716203281666037) cannot be updated because the duplicate vin exists on asset 7035371199503677719 (Org: INTERNAL - MiX North America) at MiX.Fleet.Services.Logic.Assets.AssetsManager.ApplyDuplicateVinCheck
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/27/2022 7:08:12 PM |CorrelationId:**1300320565608054784** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/27/2022 7:08:44 PM |CorrelationId:**1300320697449160704** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/27/2022 7:09:28 PM |CorrelationId:**1300320878171783168** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/27/2022 7:10:37 PM |CorrelationId:**1300321172403757056** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 400 (Bad Request,Error occured at Route:/api/assets |Date:8/27/2022 7:11:42 PM |CorrelationId:**1300321442908172288** |Error:System.ArgumentNullException: Value cannot be null. (Parameter 'additionalValueFields')
			- EXCEPTION! Response status code does not indicate success: 500 (Error occured at Route:/api/assets |Date:8/30/2022 9:03:41 AM |CorrelationId:**1301255587168653312** |Error:System.Exception: Vin 1G1PG5SB2G7118759 already exists. Asset 900929765877194752 (Org: -3715716203281666037) cannot be updated because the duplicate vin exists on asset/s ( 7035371199503677719,441987069674261039) (Org: INTERNAL - MiX North America) at MiX.Fleet.Services.Logic.Assets.AssetsManager.ApplyDuplicateVinCheck
			- id=900929765877194752
				- Same as above
			- orgId=-3715716203281666037
				- Wont check - will be too many
			- https://app.logz.io/#/goto/624ce068b09ad30f931f7480f1e7e38c?switchToAccountId=157279


	- VIN: 1FT8W3BT2KEE59613 (Will investigate logs now)
		- Search:  1 Result
			- NexTier Oilfield Solutions. NOT Commissioned. VIN NOT editable. Reason: CAN Bus.
		- app.logz.io: 1FT8W3BT2KEE59613
			- na
		- id=-4662459113601922099
			- na
		- orgId=1802434762588041337 (x) -5527124774436478549
			- na
		- ON Servers
			- \\hsviriis43\L$\WebServices\
			- \\hsviriis39\L$\WebServices\
			- \\hsviriis21\L$\WebServices\
			- \\hsviriis20\L$\WebServices\
			- none of them
		- More LOG searches on Logz and Servers
			- The mobile unit you are trying to change, could not be found
			- Unsupported device type
			- Executed ForceRefreshMobileUnitMapping for mobile unit id: -4662459113601922099
			- sent to Comms for OEM Un Enrollment
		- DB
			- Nothing found in DB
```sql
-- ORG INFO
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId IN (-5527124774436478549)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = 898

-- ASSET INFO
USE CJEnergyServices_2017;
SELECT top 10 VinNumber, * FROM dynamix.Assets WHERE AssetId IN (-4662459113601922099)
SELECT top 10 * FROM dbo.Vehicles WHERE iVEhicleID = 1728

-- MOBILE INFO
USE DeviceConfiguration;
SELECT TOP 10 * FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = -4662459113601922099
SELECT top 10 * FROM mobileunit.AssetMobileUnits WHERE MobileUnitKey = 104627
SELECT TOP 10 * FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitKey = 104627
--Loaded config: 5907119
SELECT TOP 10 * FROM mobileunit.MobileUnits WHERE MobileUnitKey = 104627
SELECT TOP 10 * FROM definition.MobileDevices WHERE DeviceKey = 1105
SELECT TOP 10 * FROM template.ConfigurationGroups WHERE ConfigurationGroupKey = 10013
Select * from definition.ConfigurationStatuses Where ConfigurationStatus IN (1, 5)
--Select * from definition.DeviceTypes WHERE DeviceType = 1

--

--DP
USE [DeviceConfiguration.DataProcessing];
Select TOP 10 * FROM state.MobileUnitState WHERE MobileUnitId = -4662459113601922099
Select TOP 10 * FROM state.MobileUnitStateHistory WHERE MobileUnitId = -4662459113601922099
Select TOP 10 * FROM state.MobileUnitMessage WHERE MobileUnitId = -4662459113601922099
Select TOP 10 * FROM state.MobileUnitMessageStateHistory WHERE MobileUnitId = -4662459113601922099

--WHERE LegacyVehicleId = 2 AND LegacyOrgId = 1 ---4662459113601922099
```
			- 
- Current examples
	- VIN: 1G1PG5SB2G7118759
		- Search: 1 Result
			- INTERNAL - MiX North America Other. Commissioned as FM. VIN NOT editable. Reason: CAN Bus.
	- VIN: 3WKDD40X8BF284090
		- Search: 2 results
			- COL CUMANDES LAP. Commissioned as FM. VIN editable.
			- COL CUMANDES ICOLTRANS. Commissioned as FM. VIN editable.
	- VIN: 9BGJP7520LB104300
		- Search: 2 Results
			- MIXTEL BR - DELLA VOLPE (789). Commission as FM. VIN NOT editable. Reason: CAN Bus
			- MIXTEL BR - DELLA VOLPE (688). Commission as FM. VIN NOT editable. Reason: CAN Bus

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Branch
Config/MR/Bug/SR-13274 VIN not cleared after decommissioning.xx.xx.ORI

## Learned

## Description
- FORD OEM asset
- VIN field on the asset page is locked
- source is set to CAN bus

DeleteAssetMobileUnit > Decommission > Remove VIN (FleetServicesDataClient.Assets.RemoveVinAsync)

Child::![[OEM Decommissioning.excalidraw]]
Child:: ![[Decommissioning MiX4000.excalidraw]]

UI:
removeMobileDeviceTemplate (save)

BE:
ModuleRoutes.REMOVE_MOBILE_DEVICE
RemoveMobileDevice
	- if (sqlRepo.DoesAssetHaveDeviceEnabled(assetId, MiX.DeviceIntegration.Common.Constants.LogicalDevices.OEM_Logical))
	- -7567965444832338102L
	- [mobileunit].[MobileUnit_DoesAssetHaveDeviceEnabled]

Client:
DeviceConfigApi.DeviceConfigClient.MobileUnits.OEMUnEnrollment

API:
mobile-units/oem-unenrollment
mum.OEMUnEnrollment

DB:
[mobileunit].[MobileUnit_UpdateConfigurationStatus]
[mobileunit].[MobileUnits].[ConfigurationStatus] = 18

```c#
// BE
//sqlRepo.DoesAssetHaveDeviceEnabled(assetId, MiX.DeviceIntegration.Common.Constants.LogicalDevices.OEM_Logical
//TODO: MR: CHECK: IF this is actually on the device mentioned

// API
//?mobileUnitMapping.IsNull OR string.IsNullOrEmpty(mobileUnitMapping.UniqueIdentifier
//LOG: The mobile unit you are trying to change, could not be found
//TODO: MR: CHECK: If UniqueIdentifier is filled in

//?deviceType = GetThirdpartyOEMDevice(mobileUnitMapping.MobileDeviceType);
//if (deviceType == ErrorMessages.ConfigAdmin.UNSUPPORTED_DEVICE_TYPE)
// LOG: Unsupported device type
//TODO: MR: CHECK: Log for this message for this asset for that time

//?
// nativeDeviceIdentifier = ...mobileUnitMapping.UniqueIdentifier
//TODO: MR: CHECK: Seems to be already covered previously

//Send the unenrollment request to Thirdparty Comms
ThirdPartyConnectClient.Enrollment.RequestUnenrollmentAsync(nativeDeviceIdentifier, correlationId.ToString()).ConfigureAwait(false).GetAwaiter().GetResult();
ForceRefreshMobileUnitMapping(mobileUnitMapping.MobileUnitId, mobileUnitMapping.UniqueIdentifier);
//LOG: Executed ForceRefreshMobileUnitMapping for mobile unit id:
// LOG: "AssetId {mobileUnitMapping.AssetId} sent to Comms for OEM Un Enrollment.", LogLevel.Production);
//TODO: MR: CHECK: IF this log for this asset is present in that time

// Update the Config status to Pending Unenrollment.
//...UpdateConfigurationStatus(...ConfigurationStatus.PendingUnenrollment);
//TODO: MR: CHECK: If this status is ever found in the DB (audit)?

```


More info:
configurationStatuses
<status id="18">Pending unenrollment</status>

DeviceConfigApi.DeviceConfigClient.MobileUnits.OEMUnEnrollment




==Jeremy==:
My understanding of VIN for OEM is the following:
-   The **VIN** field on Asset page is **Locked** to read-only after the **commissioning** process is complete
-   The only way to change the VIN is from the Mobile Asset tab - **change mobile device** button.
-   **Decommissioning** is not a one step process, there is a **workflow** involving the OEM's API
-   when requesting decommission, the VIN is not cleared, 
	- but the **state** is marked as **decommissioning** and 
	- a **request** is sent (via Comms) to OEM (de-enrolment)
-   only after receiving the **result** back from OEM should 
	- the Asset be moved to the full **Decommissioned** state, 
	- **and the VIN cleared**.

-   Note: The Asset **Delete** is also blocked until the decommissioning/de-enrolment is complete for OEMs

## Investigate
- Unit type (Form OEM?)
- VIN cleared? (or locked in UI)
- source is set to CAN bus
- Unit state? (commissioned, decommissioning, (comms > OEM) decommissioned)
- Examples:



	- id=-4662459113601922099&orgId=1802434762588041337
	- id=-4662459113601922099&orgId=-5527124774436478549
		- 1FT8W3BT2KEE59613 **NEXT**
		- 1 Decommissioned
		- INTERNALMiXNorthAmerica_2014
		- VIN: Not clear
		- Loaded config: 5907119
		- Config Group: HD-03: HOS, Rovi II, J1939 250kbps, I1-Brakes >6v, I2-PTO <6v, OS-70, HA-7, HB-7.5, OR-3500 - FM
		- Unit Type:  FM 3807i/3817i
			- - Org: Archrock - Site: Boca Raton
			- id=-4662459113601922099
			- orgId=1802434762588041337
			- 1FT8W3BT2KEE59613
			- [https://us.mixtelematics.com/#/fleet-admin/asset/details?id=-4662459113601922099&orgId=1802434762588041337](https://us.mixtelematics.com/#/fleet-admin/asset/details?id=-4662459113601922099&orgId=1802434762588041337)




	- id=7035371199503677719&orgId=-3715716203281666037
		- 1G1PG5SB2G7118759 (**ALREADY HANDLED IN COMMENTS**)
		- 2 Decommissioned, 1 Available
		- INTERNALMiXNorthAmerica_2014
		- VIN: Not clear
		- Loaded Config: NULL
		- Config Group: AH - Rovi II, HOS, ELD, I1-Brakes, I2-Headlights I3-Comms- 3807i
		- Unit Type:  FM 3807i/3817i
			- Org: Archrock - Site: X - Decommissioned
			- id=7035371199503677719
			- orgId=-5716196979005910921
			- 1G1PG5SB2G7118759
			- [https://us.mixtelematics.com/#/fleet-admin/asset/details?id=7035371199503677719&orgId=-5716196979005910921](https://us.mixtelematics.com/#/fleet-admin/asset/details?id=7035371199503677719&orgId=-5716196979005910921)

	


## Code sections

```sql
-- ORG INFO
SELECT *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId IN (-3715716203281666037)

SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = 421

-- ASSET INFO
USE INTERNALMiXNorthAmerica_2014;
SELECT top 10 VinNumber, * FROM dynamix.Assets WHERE AssetId IN (7035371199503677719)
SELECT top 10 * FROM dbo.Vehicles WHERE iVEhicleID = 2

-- MOBILE INFO
USE DeviceConfiguration;
SELECT TOP 10 * FROM audit.mobileunit_AssetMobileUnits_CT WHERE AssetId = 7035371199503677719
SELECT top 10 * FROM mobileunit.AssetMobileUnits WHERE AssetId = 7035371199503677719
SELECT TOP 10 * FROM audit.mobileunit_MobileUnits_CT WHERE MobileUnitKey = 166803
--Loaded config: 5907119
SELECT TOP 10 * FROM mobileunit.MobileUnits WHERE MobileUnitKey = 166803
SELECT TOP 10 * FROM definition.MobileDevices WHERE DeviceKey = 1105
SELECT TOP 10 * FROM template.ConfigurationGroups WHERE ConfigurationGroupKey = 3432
Select * from definition.ConfigurationStatuses Where ConfigurationStatus IN (1, 5)
--Select * from definition.DeviceTypes WHERE DeviceType = 1

USE [DeviceConfiguration.DataProcessing];
Select TOP 10 * FROM state.MobileUnitState WHERE MobileUnitId = 7035371199503677719
Select TOP 10 * FROM state.MobileUnitStateHistory WHERE MobileUnitId = 7035371199503677719
Select TOP 10 * FROM state.MobileUnitMessage WHERE MobileUnitId = 7035371199503677719
Select TOP 10 * FROM state.MobileUnitMessageStateHistory WHERE MobileUnitId = 7035371199503677719

--WHERE LegacyVehicleId = 2 AND LegacyOrgId = 1 --7035371199503677719



```

## Files

## Resources

## Notes

