---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-09T16:42
---

# OE-537 BUG Spinner on Decommissioning DME

Date: 2025-06-05 Time: 11:26
Parent:: [[Remove Mobile Device]]
Friend:: [[2025-06-05]]
JIRA:OE-537 BUG Spinner on Decommissioning DME
https://powerfleet.atlassian.net/browse/OE-537


> [!Important] Renamed to: OPEN-239


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

## Shorter Description

ORG: Amy Bench Units
Asset: Oyster (IMEI: 353323081190745)
ORG: Regression Test Units
Asset: Remora (IMEI: 358014099129974)
When I remove the mobile device, the spinner appears for (ever)

- Remove mobile device
- manually refreshing page
	- error
	- BUT this error could be due to refreshing this while data has now changed in the backend

When navigating out of Assets page and then going back in, the asset has been successfully decommissioned.

Error: 1574916149047824384
```xml
EXCEPTION! <?xml version="1.0" encoding="utf-16"?>  
<ApiRequestInfo xmlns:xsd="[http://www.w3.org/2001/XMLSchema](http://www.w3.org/2001/XMLSchema)" xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)">  
<RequestId>1574916149047824384</RequestId>  
<AuthToken>6dc2afaa-04e3-45e8-9d17-a61d81847ab2</AuthToken>  
<AccountId>3311992934800910971</AccountId>  
<RequestJson />  
<RequestUrl>GET <[http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/2307906436721054420/1567976447281238016</RequestUrl>>](http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/2307906436721054420/1567976447281238016%3C/RequestUrl%3E%3E)  
</ApiRequestInfo>  
Exception Type: System.Exception  
EXCEPTION! **Object reference not set** to an instance of an object.  
Exception Type: System.NullReferenceException  
Stack trace at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.**GetAssetCommissioning**(String authToken, Int64 groupId, Int64 assetId) in D:\b\2\_work\1603\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\**AssetCommissioningModule.cs:line 712**  
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_01.<RegisterRoute>b__0(Object args) in D:\\b\\2\\_work\\1603\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 499 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_11.<HandleTyped>b__1() in D:\b\2\_work\1603\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 288  
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func1 method) in D:\\b\\2\\_work\\1603\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 215 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func1 method) in D:\b\2\_work\1603\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 149
```

## JAKO

Root cause:

In the old method of commissioning, we always used to return “success” even if the call to the DME API returned an error. All other decommissioning tasks were completed.

In the new method of commissioning, we return a “failure” if the call to the DME API returns and error. The Fleet.UI Page isn’t setup to handle failure results in this scenario, to the spinner spins perpetually.

Solution:

We will not be implementing the new method of commissioning in UAT or Release, so we have switched it off. Please repeat regression testing with this setting disabled.

A new ticket will be opened to address this issue in a future sprint.

## Amy

- New - IMEI was _not_ decommissioned - 
	- Data centre administration | Asset search, the IMEI still appeared on his org
	- (after waiting many mins)
- DME specific?
	- Could assign the IMEI
	- didn’t give me the usual “This IMEI is already in use“ message
	- Error on save
	- Specified argument was out of the range of valid values. (Parameter 'Unique Identifier already used on MobileUnit: {"AssetId":1451687716841263104,"MobileUnitId":1451687716841263104,"UniqueIdentifier":"358014098040867","OrganisationId":-9139758428361458025,"LegacyVehicleId":25,"LegacyOrganisationId":9596,"MobileDeviceType":4,"MobileUnitType":5646852502041998355}
	- [ ] separate bug

## Idea

- Amy needs to create a new one for the above mentioned bug
- Debug locally against INT - old BE in  
	- C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs
- I think the spinner and the bug are two seperate issues
	- The bug happens because of the user refreshing the page after the decommissioning
	- [ ] It would make sense that there could then be a NULL object as we are loading a page which has lost data
	- [ ] LANGUAGE: Error updating asset

## Testing

- 353323081190745 <<
	- Digital Matter: Device
	- Name: Oyster 3G
	- Default configuration group for Digital Matter
	- When decommissiong it reaches an error and returns
		- RemoveMobileDevice > GatewayResultStatus.GeneralFailure
		- 11 months ago - Zeshan
		- [ ] NOT HANDLES?????????
			- It isn't handled in the UI
				- $dynamicScope.removeMobileDeviceTemplate.save().then(() => {
							$dynamicScope.contentLoadingStack.pop();
							$dynamicScope.$popAlert('success', 'Asset updated successfully');
							$dynamicScope.$resetUnsavedChanges();
							$dynamicScope.$setPath('/fleet-admin/assets');
					});
		- IF the user the refreshes....
			- mobileUnit.ConfigurationGroupId is null, this the error after refresh
- 358014099129974