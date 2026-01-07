---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-01-07T12:57
---

# OPEN-930 Add Config File Downloads

Date: 2025-12-08 Time: 16:54
Parent:: ==xxxx==
Friend:: [[2025-12-08]]
JIRA:OPEN-930 Add Config File Downloads
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-930)

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

## Overview

FR UI > FR API > Client > API

## Description

### FE

- Download config file
	- DownloadConfigFile
	- downloadConfigFileClicked
- Download pending config file
	- DownloadPendingConfigFile
	- downloadPendingConfigFileClicked

It is already in the Core enum: C:\Projects\MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Enums\AssetConfigurationAction.cs

```ts
downloadConfigFileClicked(row): void {
	this._currentRow = row;
	var downloadUrl = this.assetData.downloadConfigFile.fullUri;
	window.open(downloadUrl.urlReplace({ assetId: row.assetId, auth: this.authentication.authenticationToken }), "_blank");
}

downloadPendingConfigFileClicked(row): void {
	this._currentRow = row;
	var downloadPendingUrl = this.assetData.downloadPendingConfigFile.fullUri;
	window.open(downloadPendingUrl.urlReplace({ assetId: row.assetId, auth: this.authentication.authenticationToken }), "_blank");
}
```

assetData > getConfigGroupAssets > GET_CONFIG_GROUP_ASSETS > GetConfigGroupAssetList
C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs




### BE

Routes:
public static readonly RouteDefinition GET_CONFIG_FILE = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/{orgId}/asset/{assetId}/downloadConfigFile", Core.Http.Constants.HTTPVerbs.GET);
public static readonly RouteDefinition GET_PENDING_CONFIG_FILE = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/{orgId}/asset/{assetId}/downloadConfigPendingFile", Core.Http.Constants.HTTPVerbs.GET);

- [ ] canDownloadConfigFile = canAccessMobileDeviceSettings && canAccessEvents
- bool canAccessMobileDeviceSettings = allPermissions[ConfigConstants.Permissions.ASSET_LEVEL_ACCESS_MOBILE_DEVICE];
- bool canAccessEvents = allPermissions[ConfigConstants.Permissions.ASSET_LEVEL_ACCESS_EVENTS];

ModuleRoutes.GET_CONFIG_FILE.ToLinkCarrier("downloadConfigFile", new { orgId = organisationId }),
ModuleRoutes.GET_PENDING_CONFIG_FILE.ToLinkCarrier("downloadPendingConfigFile", new { orgId = organisationId }),

#### Rules

- [ ] hsFmDevices.Contains
- [ ] hsM4kDevices.Contains
- [ ] hsM6kDevices.Contains

DeviceConfigClient.MobileUnits.GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary

#### Calls

//Config
var jsonData = DeviceConfigClient.MobileUnitConfiguration.GetLoadedConfigTextSummaryForMobileUnit(authToken, assetId).ConfigureAwait(false).GetAwaiter().GetResult();
return WriteFileResponse(assetId, jsonData != null ? JsonConvert.DeserializeObject(jsonData).ToString() : null);

//Pending
var jsonData = DeviceConfigClient.MobileUnitConfiguration.GetPendingConfigTextSummaryForMobileUnit(authToken, assetId).ConfigureAwait(false).GetAwaiter().GetResult();
return WriteFileResponse(assetId, jsonData != null ? JsonConvert.DeserializeObject(jsonData).ToString() : null, true)

**EG**: "https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-5401647754082838271/asset/1626018637366906880/downloadConfigPendingFile"

**downloadConfigPendingFile**

19bd4d3f-5b45-4d1f-b47b-98e81a959720
-5401647754082838271
1626018637366906880

```TS
private Response WriteFileResponse(long assetId, string file, bool getPending = false)
{
	var pendingString = getPending ? "Pending" : "";
	if (string.IsNullOrEmpty(file))
	{
		var dataType = getPending ? "pending" : "loaded";
		file = $"No {dataType} configuration found";
	}
	Response response = new Response();
	var fileName = $"{pendingString}ConfigFile_{assetId}.txt";
	response.Headers.Add("Content-Disposition", "attachment; filename=" + fileName);
	response.ContentType = "text/plain";
	response.Contents = stream =>
	{
		using (var writer = new StreamWriter(stream))
		{
			writer.Write($"{file}");
		}
	};
	return response;
}
```

### Client

IMobileUnitConfigurationRepository
- [ ] GetLoadedConfigTextSummaryForMobileUnit
- [ ] GetPendingConfigTextSummaryForMobileUnit

## FR API

getPendingConfigTextSummaryForMobileUnit


## FR UI

eg to follow:
getOverriddenInformationForMobileUnit

action
- getPendingConfig
- [ ] xxxxx

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-930_AddConfigFileDownloads.INT

## PR

- [ ] OPEN-930 Add Config File Downloads > DEV
- [ ] OPEN-930 Add Config File Downloads > INT

