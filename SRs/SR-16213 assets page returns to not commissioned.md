---
status: busy
date: 2023-08-29
comment: 
priority: 1
created: 2023-08-29T13:41
updated: 2024-02-01T16:56
---

# SR-16213 assets page returns to not commissioned

Date: 2023-08-29 Time: 13:41
Parent:: [[Compile]]
Friend:: [[2023-08-29]]
JIRA:SR-16213 assets page returns to not commissioned
[SR-16213 MiX 4000 when commissioned and config compiled from assets page returns to not commissioned - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-16213)

## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## BRANCH

- Config/MR/Bug/SR-16213_returns_to_not_commissioned.23.12.ORI


## Description

- It MIGHT be related to: (NOPE)
	- [CONFIG-2694 REG: Change mobile device on Mesa units - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-2694)

**Descr:** 

Periodically AU region have noted that when **commissioning** a new vehicle and **compiling** config from the assets page it 
	**starts to compile** then 
	**reverts** back to ==not commissioned==. 
This is an example of one such instance.  
I have not been able to replicate and it doesn’t seemingly do it all the time.  
example from config audits show it happen here too… is is in date desc order
FULL VEHICLE DETAILS AS EXAMPLE  

|   |   |
|---|---|
|Ignition State|OFF|
|Organisation Name|Fleet Integrations - AU Projects|
|Dealer|AU-Fleet Integrations-Australia|
|Vehicleid|644|
|Site Name|John Holland Group|

## Image

![[SR-16213 Commissioned returns to not commissioned after config compile]]

## Audit Table EG IMG

![[SR-16213 assets page returns to not commissioned Audit Table.png]]


## Potential steps of Configuration Status changes

<mark class="hltr-red">Not commissioned</mark>

<mark class="hltr-orange">Configuration changed</mark>
<mark class="hltr-yellow">Compile requested</mark>
<mark class="hltr-green">Compiling</mark>

<mark class="hltr-red">Not commissioned</mark>

<mark class="hltr-yellow">Compile requested</mark>
<mark class="hltr-green">Compiling</mark>
<mark class="hltr-cyan">Ready for upload</mark>
<mark class="hltr-blue">Upload requested</mark>
<mark class="hltr-purple">Configuration accepted</mark>

## SQL for above

- [MiX Telematics - Assets](https://au.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1426140713474596864&orgId=510433273378299525)
- id=1426140713474596864
- orgId=510433273378299525

![[SR-16213 assets page returns to not commissioned.sql]]

## Paul mentioned Nicole

Yay! Found it. 

## Nicole Schneider 

29 October 2021 at 11:16

PO Notes:

When an asset does not have an IMEI associated and user compiles config then compile and set the status back to Not commissioned and only store the config snapshot. Add the following warning in the Config compile status: No IMEI associated to Asset. Please assign IMEI on Mobile device settings page and recompile config. Pending config file saved.

SR-11614 Perform a check against the Device Config API to determine if a MESA unit has no IMEI set and then we only store the ConfigSnapShot for the sales wors peeps.


## SR Comment

On 29 October 2021 at 11:16, Nicole Schneider made the following PO Note:

When an asset does not have an IMEI associated and user compiles config then compile and set the status back to Not commissioned and only store the config snapshot. Add the following warning in the Config compile status: No IMEI associated to Asset. Please assign IMEI on Mobile device settings page and recompile config. Pending config file saved.

SR-11614 Perform a check against the Device Config API to determine if a MESA unit has no IMEI set and then we only store the ConfigSnapShot for the sales people.

PR: [Pull request 62020: SR-11614 Perform a check against the Device Config API to determine if a MESA unit has no IMEI set and then we only store the ConfigSnapShot for the sales wors peeps. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/62020)
```c#
///MiX.UnitConfiguration/MiX.UnitConfiguration.Data/MobileUnitConfiguration.cs
if (noImeiMesaCompile)
//...
	configurationStatus = ConfigurationStatus.NotCommissioned,
```

C:\Projects\DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Data\MobileUnitConfiguration.cs
file:///C:/Projects/DynaMiX.Backend/MiX.UnitConfiguration/MiX.UnitConfiguration.Data/MobileUnitConfiguration.cs
- Version 23.12
- 

## All other occurances

DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:
  1345            ConfigGroupId = "Unallocated",
  1346:           ConfigurationStatus = ConfigurationStatus.NotCommissioned.GetDescription(),
  1347            ConfigurationStatusTime = statusDate,

DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:
  453               MobileDeviceId = newTemplate.DefinitionDeviceId,
  454:              ConfigurationStatus = canAutoCommission ? ConfigurationStatus.ConfigurationChanged : ConfigurationStatus.NotCommissioned,
  455               ConfigurationGroupId = newConfigGroup.Id,

DynaMiX.Backend\Logic\DynaMiX.Logic\Operations\IridiumManager.cs:
  317       {
  318:        return ConfigurationStatus.NotCommissioned;
  319       }

DynaMiX.Backend\MiX.UnitConfiguration\MiX.UnitConfiguration.Data\MobileUnitConfiguration.cs:
  288                                     mobileUnitId,
  289:                                    configurationStatus = ConfigurationStatus.NotCommissioned,
  290                                     generationNotes = "Generation complete with warning",

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\AssetLevel\AssetManager.cs:
  148             MobileDeviceId = newTemplate.DefinitionDeviceId,
  149:            ConfigurationStatus = canAutoCommission ? MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.ConfigurationChanged : MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.NotCommissioned,

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\DynamicCAN\DynamicCANManager.cs:
  384         {
  385:          deviceConfigRepo.AddMobileUnit(assetId, ConfigurationStatus.NotCommissioned, configGroupId, uniqueIdentifier, currentSession.FullName);

DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs:
  3550            if (!canAutoCommission)
  3551:             configStatus = ConfigurationStatus.NotCommissioned;

## Search Result File

![[NotCommissioned.code-search]]

## All other occurances (img)

![[SR-16213 assets page returns to not commissioned.png | 800]]

## NExT IDEA?

- [ ] SR-16213   
- they definitely are populating the **IMEI** before compiling
- might happen more often when **swapping** an **FM37xx** to a **MiX4000** if that helps at all
- **first compile** after a unit is commissioned, rather than a unit that has been commissioned for some time is suddenly jumping back
- ek het nou net gewonder of daardie dalk 'n  **timing** ding is,  waar die asset nou net commision is en dan dink die config gen sy starting state is **not comissioned** en daarom stel hy hom terug?

## Paul code

So ekt gekyk

Die kode wat Paul noem word v 2 plekke geroep - die een is n UI wat met false inpass - dis OK

Die ander een is waar dit die IMEI ook check - maar net voor dit die unit se imei check doen dit n

var unitSummary = DeviceConfigClient.MobileUnits.GetAssetMobileUnitMappingByMobileUnitId(context.MobileUnitId, correlationId).ConfigureAwait(false).GetAwaiter().GetResult();

C:\Projects\DynaMiX.Backend\Services\Configuration Generation\MiX.UnitConfiguration.GenerationService\UnitConfigurationService.cs
file:///C:/Projects/DynaMiX.Backend/Services/Configuration%20Generation/MiX.UnitConfiguration.GenerationService/UnitConfigurationService.cs

+- Lyn 223

Ek sal nou check of dit uit cache kom of nie...

- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs
- 

### Extra info:

Supply IMEI
MiX4000 (or swapping from an FM37xx)
first
timing

## Try to duplicate AU

- id = 1438187434936836096
- orgId = -4272895230518739167
- SAVE: 
	- Put: https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-4272895230518739167/1438187434936836096
	- DeviceTypeIdentifierTitle": "Unique identifier",
	- "DeviceTypeIdentifierValue": "123456798087945",
- Compile:
	- PUT: https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-4272895230518739167/1438187434936836096/compile_and_upload
	- 

## UI 

![[SR-16213 assets page returns to not commissioned UI.png | 600]]

## Try to duplicate locally

## Inspecting the code

### When saving

- C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
	- It does invalidate the cache: line 258

### Code places

All places in code it is set to Not commissioned

DynaMiX.Backend
API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs
Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs
Logic\DynaMiX.Logic\Operations\IridiumManager.cs
MiX.UnitConfiguration\MiX.UnitConfiguration.Data\MobileUnitConfiguration.cs



DynaMiX.DeviceConfig

DynaMiX.DeviceConfig.Logic\Managers

AssetLevel\AssetManager.cs
DynamicCAN\DynamicCANManager.cs
MobileUnitLevel\MobileUnitManager.cs

### Now let's see where what they intersect with the above

- 

### SQL to test the Audit tables for this unit

![[SR-16213 assets page returns to not commissioned.sql]]

```sql
USE DeviceConfiguration;
DECLARE @id BIGINT = 1438187434936836096;
SELECT * FROM mobileunit.mobileunits WHERE mobileunitid = @id;
SELECT amu.ChangeDate, dc.Description, * 
FROM audit.mobileunit_mobileunits_CT amu
INNER JOIN definition.ConfigurationStatuses dc ON dc.ConfigurationStatus = amu.ConfigurationStatus
WHERE mobileunitid = @id 
ORDER BY amu.ChangeDate ASC;
```

### Excalidraw

![[SR-16213 Investigating the code for Not Commissioned.excalidraw]]

## Fixing the code

- Either the Invalidation of IMEI needs to be fixed... OR
- The reading of unit in compiler must read directly from DB
- Video sent: [SR-16213 IMEI Cache invalidate OR read direct.mkv (sharepoint.com)](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/_layouts/15/stream.aspx?id=%2Fpersonal%2Fmarthinus%5Fraath%5Fmixtelematics%5Fcom%2FDocuments%2FVideos%2FSR%2D16213%20IMEI%20Cache%20invalidate%20OR%20read%20direct%2Emkv&referrer=Teams%2ETEAMS%2DELECTRON&referrerScenario=p2p%5Fns%2Dbim&ga=1)
- Paul's response makes sense: Hou in gedagte dat die kode is in plek en werk al vir 'n hele paar jaar. So as hierdie 'n major change gaan wees wat die performance gaan beïnvloed moet ons dit dalk net as 'n known issue aanteken. Onthou - NB - die compiler loop konstant en compile baie units, die groot meerderheid van hulle is nie vol nonsense nie en moet so gou moontlik compile word. Ons wil dus niks in die process in bring wat hulle gaan affekteer. Met ander woord checks of IFs of calls wat die overall compile vir gewone units sal stadig maak.
- Justus: The Cache that gets read could be old cache. It reads from the in **memory** cache and than the **Redis** cache
- OK - so is it OK if, where we currently call the cache for that:
var unitSummary = DeviceConfigClient.MobileUnits.GetAssetMobileUnitMappingByMobileUnitId
We call the DB directly... eg...
var unitSummary = AnAmazingDBCallThatBypassesCache... (Think Zeshan did one for mapping)

## Ideas

- GetMobileUnitByUniqueIdentifierFromDBV2
	- [mobileunit].[MobileUnit_GetMobileUnitMappingsByUniqueIdentifier]
- IMEI can come from two places!! (look in code)
	- Imei = mobileUnitProperties.UnitIMEI ?? mobileUnitProperties.UniqueIdentifier,

- GetMobileUnitByUniqueIdentifierFromDB, I think this includes both
	- UniqueIdentifier = CASE WHEN mu.UniqueIdentifier IS NULL THEN mup.value ELSE mu.UniqueIdentifier END
	- Imei = mobileUnitProperties.UnitIMEI ?? mobileUnitProperties.UniqueIdentifier,
	- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs
		- mu.UniqueIdentifier = await PopulateUniqueIdentifierFromDeviceProperty(cacheKey, mu).ConfigureAwait(false);
			- PopulateUniqueIdentifierFromDeviceProperty
			- FM!!
				- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs
				- +- 1155
				- [mobileunit].[MobileUnit_GetMobileUnitPropertyValue] 
					- (mobileunit.MobileUnitProperties)
- InvalidateMobileUnitMappingByUniqueIdentifier

## SQL Testing Status changes including Auditing

![[SQL Config Status Changes Audit]]



might happen more often when swapping an FM37xx to a MiX4000 if that helps at all
- Haal FM uit cache
- Sit nie 4K in nie!
- Make FM
- Change to 4K
	- Debug Config API
	- changeMobileDeviceTemplate.save
		- CHANGE_MOBILE_DEVICE
		- Run from FE & Debug BE
		- See what it going wrong
- [MiX Telematics - Assets](http://localhost/MiXFleet.UI/#/fleet-admin/asset/commissioning?id=1468673032566779904&orgId=-4493495256567590976)
- 4K > FM
	- Correctly removes the Unique Id
	- Correctly sets it to an FM
	- LOG: Calls ForceRefreshMobileUnitMapping ONCE with uniqueIdentifier: empty/null
	- Redis: Exists afterwards
- FM > 4K
	- PUT: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-4493495256567590976/1468673032566779904
	- Send correct type, unique key in payload
	- LOG: Calls ForceRefreshMobileUnitMapping MANY TIMES once with uniqueIdentifier: empty/null twice with the new M4K Unique id value
	- Redis: Throws away the redis key
	- See log for potential reason forcing the mapping too often OR it breaks inside?

![[SR-16213 assets page returns to not commissioned Calls 4k too many times to clear redis.png|600]]

In code it only seems to invalidate the cache  if it has a unique identifier:

![[SR-16213 assets page returns to not commissioned Only invalidate if unique id.png|600]]


## Test 2

- [MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1469654901081403392&orgId=-1983255592473789111)
- id=1469654901081403392
- orgId=-1983255592473789111
- 
## Redis

- SELECT 4
- SCAN 0 MATCH *keyword*
- KEYS *keyword*
- GET Config:MobileUnitMapping:1468673032566779904

```txt
SELECT 4
KEYS *1469654901081403392*
GET Config:MobileUnitMapping:1468673032566779904
```

## Testing

I keep running into this issue:
_EXCEPTION_! A connection was successfully established with the server, but then an _error_ occurred during the pre-login handshake.


## 20231212

- AssetId: 1471101195350568960
- [MiX Telematics - Assets](http://localhost/MiXFleet.UI/#/fleet-admin/asset/commissioning?id=1471101195350568960&orgId=-1983255592473789111)
- GET Config:MobileUnitMapping:1471101195350568960
- 
- FM New
- FM 2 4K
- 4K 2 FM

## FM to 4K on Localhost

PUT: http://localhost/DynaMiX.API/fleet-admin/assets/commissioning/-1983255592473789111/1471470736609681408/change-mobile-device
1. ConfigGroupId: "-8415430273961634366"
2. IsFM: false
3. IsMobilePhone: false
4. IsStreamax: false
5. MobileNumber: null
6. WasMobilePhone: false
7. WasStreamax: false
8. WasStreamaxPeripheral: false
9. deviceTypeId: "6183256567829462590"
10. isStreamaxStandAlone: false
11. isUniqueIdentifierVIN: false

## UAT Same as above

- PUT: https://uat.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-3651824075929424032/1471566976607256576/change-mobile-device
- Payload
	1. ConfigGroupId: "1276130878237224532"
	2. IsFM: false
	3. IsMobilePhone: false
	4. IsStreamax: false
	5. MobileNumber: null
	6. WasMobilePhone: false
	7. WasStreamax: false
	8. WasStreamaxPeripheral: false
	9. deviceTypeId: "6183256567829462590"
	10. isStreamaxStandAlone: false
	11. isUniqueIdentifierVIN: false
- PUT: https://uat.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-3651824075929424032/1471566976607256576
- Payload
	1. AssetName: "MR FM Device Template"
	2. CanCompileConfig: true
	3. CanDeactivateIridiumAccount: false
	4. CanEditApnName: true
	5. CanEditDetails: true
	6. CanEditGsmDetails: true
	7. CanEditIridiumSatelliteDetails: true
	8. CanEditMobileDevice: true
	9. CanEditSatelliteDetails: true
	10. CanEditSimPin: true
	11. CanEditSmsDetails: true
	12. CanEditStreamaxDetails: true
	13. CanRemoveMobileDevice: true
	14. CanUploadConfig: true
	15. CanViewCommsLog: true
	16. CommissioningStatus: {CommissioningStatus: "Not available", CommandType: "MasterNumber", CreationDateUtc: null,…}
	17. CommunicationCapable: true
	18. CompileCapable: true
	19. ConfigChanged: true
	20. DeviceIsStreamaxEnabled: true
	21. DeviceTypeIdentifierTitle: "Unique identifier"
	22. DeviceTypeIdentifierValue: "145697485932145"
	23. DeviceTypeName: "MiX4000"
	24. GprsApnPassword: ""
	25. GprsApnPointName: "internet"
	26. GprsApnUsername: ""
	27. GprsCapable: true
	28. GprsEnabled: true
	29. GsmCapable: true
	30. GsmEnabled: false
	31. GsmMsisdnNumber: null
	32. HasBeenCommissioned: false
	33. HasBlockManualCommissioning: false
	34. HasDeviceTypeIdentifier: false
	35. HasIridiumImei: false
	36. HasUploadSchedule: false
	37. IridiumContract: ""
	38. IridiumError: null
	39. IridiumImei: ""
	40. IridiumPlanName: ""
	41. IridiumSatelliteCapable: false
	42. IsMesaBased: false
	43. IsStreamaxPeripheralConnected: false
	44. IsStreamaxStandAlone: false
	45. MiXTalkCarrierID: 0
	46. MiXTalkCarriers: [{CarrierID: 1, Carrier: "MTN"}, {CarrierID: 2, Carrier: "Vodacom"},…]
	47. MiXTalkIMEI: null
	48. MiXTalkSIMNumber: null
	49. MobileDeviceId: "6183256567829462590"
	50. OrgIsMiXTalkEnabled: true
	51. OrgIsStreamaxEnabled: false
	52. SatalliteDeviceId: ""
	53. SatelliteCapable: false
	54. ShowOBCResendCommissioningSMS: false
	55. SimCardPinCode: ""
	56. SmsCapable: true
	57. SmsEnabled: false
	58. SmsMessageCentreNumber: ""
	59. SmsMobileDeviceNumber: null
	60. StreamaxDeviceTypes: null
	61. StreamaxSerialNumber: null
	62. Tabs: null
	63. UploadScheduleId: null
	64. deviceTypeIdentifierValueUI: "145697485932145"

![[SR-16213 assets page returns to not commissioned UAT works fine.png]]
## INT same as UAT

- PUT: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/-1983255592473789111/1471569989004386304/change-mobile-device
- Payload
	1. ConfigGroupId: "-8415430273961634366"
	2. IsFM: false
	3. IsMobilePhone: false
	4. IsStreamax: false
	5. MobileNumber: null
	6. WasMobilePhone: false
	7. WasStreamax: false
	8. WasStreamaxPeripheral: false
	9. deviceTypeId: "6183256567829462590"
	10. isStreamaxStandAlone: false
	11. isUniqueIdentifierVIN: false
- PUT: NA

![[SR-16213 assets page returns to not commissioned INT is missing some calls.png]]




## Investigating the caching.... again

- $"GetMobileUnit:{assetId}"
- GetMobileUnit:1426140713474596864
- **FM37xx** to a **MiX4000**
	- FM ID: 1488972004638027776
```txt
SELECT 4
KEYS *1488972004638027776*
KEYS *GetMobileUnit:1488972004638027776*
GET Config:MobileUnitMapping:1489265894188347392
```
- FM - after first compile - NO IMEI
	- Change mobile device to: Mesa4000
	- GET "Config:MobileUnitMapping:1488972004638027776"
	- NULL
	- Compile
- **MESA**
	- **Create**
	- GET Config:MobileUnitMapping:1489265894188347392
	- GET "Config:MobileUnitMapping:1489265894188347392"
	- NULL
	- **Save** IMEI
	- Has IMEI
	- **Compile**
	- GET "Config:MobileUnitMapping:1489265894188347392"
	- has
- **FM**
	- **Create**
	- GET "Config:MobileUnitMapping:1489278657468002304"
	- NULL
	- **Compile**
	- Record with null imei - correct
	- **CHANGE** to **MESA**
	- Object but NO IMEI... NULL !!!!!!!!!! <-- ISSUE
	- View seconds later
	- NULL <-- no more record
	- Compile
	- NULL..... Stays

## Basic Caching behaviour I saw

The basic mobile unit info (including IMEI) goes into this mapping in the cache:
Config:MobileUnitMapping:{AssetId}

In-memory->Redis->DB

### Mesa

- When you just **create** the Mesa, it has no mapping in cache.
- If you then **save** the IMEI, it has mapping in cache.
- When you **compile**, the mapping remains in cache.

### FM

- When you just **create** the FM, it has no mapping in cache.
- You can't **save** an IMEI, but 
- if you **Compile**, there IS a mapping, but without an IMEI (null). This seems correct.
- If you then **change** this **to a MESA**, it still has this mapping, however, the IMEI is still NULL. This is incorrect!
- A *few seconds later* I checked again and the mapping was gone, null.
- **Compile** has no influence, the mapping remains null.



## Swagger

- End point to get unitSummary: asset-mobile-units/mobileunitids/{mobileUnitId}
- INT: [Swagger UI (domain.local)](http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnitMappings/MobileUnitMappings_GetAssetMobileUnitMappingByMobileUnitId)

- MESA (1489564718297899008)
	- Create: mobile unit object exists, blank Unique Identifier
	- Save IMEI: Has IMEI in object
	- Compile: Same as above
- FM (1489566850975653888)
	- Create: mobile unit object exists, null Unique Identifier
	- Compile: Same as above
	- Change to Mesa: no object, then Mesa object with empty, then FM with null, then Mesa with IMEI, then FM with null, Mesa with, FM with null....
	- View seconds later: it flops around, this is maybe a load balancer issue? See the [video here](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EVGPhdQqT31KlGnRT5Km3doBZ-DCB7k9Pn4-XQ2P6FM-fA?e=bJUnaJ).

## Debugging the code

- Later

## Code change

Zeshan took out in memory cache - seeing it was on more than one server and could result in the flopping of values we saw
