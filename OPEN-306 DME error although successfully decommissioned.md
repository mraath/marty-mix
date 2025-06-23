---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-23T12:06
---

# OPEN-306

Date: 2025-06-18 Time: 14:55
Parent:: ==xxxx==
Friend:: [[2025-06-18]]
JIRA:OPEN-306
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-306)


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

- Mobile Device Settings
	- Remove mobile device
	- 
## Code

- UI: removeMobileDeviceTemplate.save
- REMOVE_MOBILE_DEVICE
	- /assets/commissioning/{orgId}/{assetId}/remove-mobile-device
	- RemoveMobileDevice
	- ==BREAKS==
		- ConfigInternalClient.MobileUnitCommissioning.MobileUnitDecommissioning
		- SuccessFailWithMessage decommissionResult = ConfigInternalClient.MobileUnitCommissioning.MobileUnitDecommissioning(authToken, assetDecommRequest).ConfigureAwait(false).GetAwaiter().GetResult();
		- /mobile-units/decommissioning?authToken
	- Config.API
		- AnyMobileUnitDecommission
		- 

![[OPEN-302 Unallocated Asset Description link click errpr.png]]

AssetId: 1647399904357085184
https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1647399904357085184&orgId=-5401647754082838271

```json
{
  "AssetId": 1647399904357085184,
  "DeviceTypeId": 0,
  "GroupId": 0,
  "UniqueIdentifier": null,
  "PropertyValues": null,
  "ConfigGroupId": null,
  "SiteId": null,
  "OverrideActiveState": false,
  "Notes": null
}
```

![[OPEN-306 DME error although successfully decommissioned My SWAGGER.png|300]]


ERROR: "The mobile unit you are trying to delete, could not be found"
- This was because I have decommissioned it... set CG to Digital matter, trying again
- 


## What next

- [ ] Find in Code where it bombs out
- [ ] See if it should be fixed or if this is just something to explain
