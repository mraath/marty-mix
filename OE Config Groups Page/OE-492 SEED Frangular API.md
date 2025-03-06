---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-28T11:37
---

# OE-492 SEED Frangular API

Date: 2024-01-10 Time: 15:38
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-10]]
JIRA:OE-492 SEED Frangular API
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-492)

## OE-492 TODO
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

## Image Summary

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw#^group=gknc-s50nd1joQbEZPTDv]]

## Description

New Repo: MiX.Config.Frangular.API
Replace all Seed references

## Branches

- Config/MR/Feature/OE-501_SEED_API.INT.ORI

## Work to be done

- [x] Commit PR and Auth Needed, currently it just allows any commits ✅ 2024-10-28
- [x] authToken not hardcoded ✅ 2024-01-15
	- ..\MiX.Config.Frangular.API\MiX.Config.Frangular.Logic\AssetManager\AssetManager.cs
- [x] write an actual method for this without hardcoded authtoken... or reuse current one ✅ 2024-01-15
- [x] ConfigApiUrl in Transform ✅ 2024-01-15

## Testing

- OrgId: -4493495256567590976

## Sending through Parameters to the API (ended up being a spelling mistake 🤦)
- [MiX Telematics - Multiselect configuration groups](http://localhost/MiXFleet.UI/#/config-admin/configuration-groups-multiselect)
- I used this to search for eg. this.module.
	- [this.module. - Search Code - Home (azure.com)](https://dev.azure.com/MiXTelematics/_search?action=contents&text=this.module.&type=code&lp=custom-Collection&filters=ProjectFilters%7BFleet%7D&pageSize=25&result=DefaultCollection/Fleet/Fleet.Services.Operations.UI/GBDevelopment//src/app/data-centre-administration/tabs/asset-search/asset-search.component.ts)
	- this.module.getAvailableHoursForDriver({ isTimeEntryEnabled: this.sessionManagerService.getIsTimeEntryEnabled()}).pipe()
	- this.module.getTextSummary({ siteId: this.asset.siteId, entityId: this.asset.assetId, from: moment(this.lastStartDate).format("YYYY-MM-DD[T]HH:mm:ss"), to: moment(this.asset.lastTrip.date).format("YYYY-MM-DD[T]HH:mm:ss") })
	- AssetCommissioningController.tsCommon > MiX.Fleet.UI 
		- /UI/Js/ConfigAdmin/Controllers/AssetCommissioningController.ts
		- DIDNT HELP
	- this.module.getAuthenticationSettings({ organisationId: this.organisationId })
		- public const string GetAuthenticationSettings = "api/driver-auth/organisation/{organisationId}/authentication-settings";
		-hypermedia.HyperMedia.Methods.Add(new MethodCarrier("getAuthenticationSettings", ApiControllerRoutes.DriverAuthentication.GetAuthenticationSettings, "==GET=="));
		- !!! driver-auth-hypermedia.model.ts
		- 	getAuthenticationSettings(parameters: IOrganisationIdParameter): Observable AuthenticationSettingsCarrier ,
```c#
[Route(ApiControllerRoutes.DriverAuthentication.GetAuthenticationSettings)]
[ProducesResponseType(typeof(AuthenticationSettingsCarrier), 200)]
[HttpGet]
public async Task<IActionResult> GetAuthenticationSettingsAsync(string organisationId)
{
	if (!long.TryParse(organisationId, out long groupId))
		throw new ArgumentException($"Organisation Id was not valid :{organisationId}");

```
-
	- ALSO INVESTIGATE
		- public const string EnableDriverAccount = "api/driver-auth/organisation/{organisationId}/driver/{driverId}/enable";
			- public const string EnableDriverAccount = "api/driver-auth/organisation/{organisationId}/driver/{driverId}/enable";
			- hypermedia.HyperMedia.Methods.Add(new MethodCarrier("enableDriverAccount", ApiControllerRoutes.DriverAuthentication.EnableDriverAccount, "POST"));
```c#
[Route(ApiControllerRoutes.DriverAuthentication.EnableDriverAccount)]
[ProducesResponseType(typeof(ResultCarrier), 200)]
[HttpPost]
public async Task<IActionResult> EnableDriverAccountAsync([FromRoute] string organisationId, [FromRoute] long driverId)
{
	if (!long.TryParse(organisationId, out long groupId))
		throw new ArgumentException($"Organisation Id is not valid :{organisationId}");
```
-
	-
			- this.model.enableDriverAccount({ organisationId: this.organisationId, driverId: this.driverId })
			-  Fleet.Services.FleetAdmin.UI
			-  enableDriverAccount(parameter: { organisationId: string, driverId: string }): Observable ResultCarrier,
-
	- this.module.updateAuthenticationSettings({ organisationId: this.organisationId }, this.authenticationSettings)
		- ==Could== potentially pass everything into the wildcard (json)
		- 

- Potential fix?
```c#
[Route(ApiControllerRoutes.DriverAuthentication.GetAuthenticationSettings)]
[ProducesResponseType(typeof(AuthenticationSettingsCarrier), 200)]
[HttpGet]
public async Task<IActionResult> GetAuthenticationSettingsAsync(string organisationId)
{
	if (!long.TryParse(organisationId, out long groupId))
		throw new ArgumentException($"Organisation Id was not valid :{organisationId}");
```

## Next: Get OrgId from the SelectionCriteria

- 