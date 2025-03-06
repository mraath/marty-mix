---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-29T14:55
---

# QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI

Date: 2023-11-29 Time: 07:58
Parent:: [[Udate Unit]]
Friend:: [[2023-11-29]]
JIRA:QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI
[QA-6236 QA - VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/QA-6236)

## Lesson

- Fleet: The device doesn't think it is a Rovi2, thus taking a different code path using the RoviCommandClient to send a message to the Rovi, which passes without fail.
- VIN update was sent using the RoviCommandClient: "!ROVI!/15/settings.cmvVin=0qm2sauajIvOzczLysnIx8bO" to this server: "https://incabserver.uat.mixtelematics.com"
- Not using the SNS topic to send the message. Rudolf: I’m not sure where this goes, but it is beyond my domain.

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

## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary

The VIN number is not updated on the ROVI IV device when updating manually in the DynaMiX UI
The reason the rovi is not updated is because the unit is not ELD enabled. We have specific logic in place to only update the VIN on the Rovi if it is ELD enabled
asset config and the ROVI config has been enabled
the following code is returning false:

deviceConfigRepository.IsMobileDeviceELDEnabled(mobileUnit.MobileUnitId)
	MiX.Fleet.Services.API Calls: mobileUnitProxy.IsMobileUnitEldEnabled(mobileUnitID)
	Calls: GetMobileUnitDeviceProperty(LogicalDevices.HOURS_OF_SERVICE, Properties.ELD_ENABLED, mobileUnitId);
				deviceId: HOURS_OF_SERVICE = 7622806356726782531
				propertyId: ELD_ENABLED = 9060590998656351498
				mobileUnitId: 1465832551445032960

GetMobileUnitDeviceProperty = "mobile-units/{mobileUnitId}/devices/{deviceId}/properties/{propertyId}"
	mum.GetEffectiveDevicePropertyForAssets (0, deviceId, propertyId, new List long { mobileUnitId })
	deviceConfigRepo.GetEffectiveDevicePropertyForAssets(deviceId, propertyId, assetIds)

DeviceConfigDb
	[mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets]
		parameters.Add("deviceId", deviceId);
		parameters.Add("propertyId", propertyId);
		parameters.Add("assetIds", assetIds);


## SQL

[[SQL VIN ELD Enabled mobileunit.MobileUnit_GetEnabledDevicePropertyForAssets]]
- Used UAT server: HSUATIIS21

### Value

![[QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI Value on provided eg.png|600]]

![[QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI Logic using the Value.png|600]]

The value from the DB above is 1, thus it should result in True

### Analysis

From my findings the code referred to above it making use of the old mobileUnitProxy which calls the method: IsMobileUnitEldEnabled.
It ends up in the same place as the new client, the stored proc [mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets]
I ran this using the values supplied in the description and the value is 1, which should then return as true.
I will ask the Fleet team for some more information.


## Swagger

- http://api.deviceconfig.uat.production.local/

![[QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI Swagger result 1.png|600]]

Other Swagger:

![[QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI Values fed to end-point.png|600]]

![[QA-6236 VIN is not updated on the ROVI IV device when updating manually in the DynaMiX UI Response Swagger 2.png|600]]



## Description

Database: Lieschen Flexible RAG Scoring Database  
Org ID: 6238 (-5052155438128351875)  
Asset ID:67 (1465832551445032960)  
Asset Description: HJ ROVI IV Bench MiX 4000  
Asset IMEI: 357865090011284  
Application version:23.8.3 Build#634  
Driver: HJ, US  
Driver ID: 102 (1402801836061372416)

## Ideas

- [ ] Duplicate in Prod
- [ ] Duplicate on INT
- [ ] Check DB, Logs

## SR Meeting Notes


## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
