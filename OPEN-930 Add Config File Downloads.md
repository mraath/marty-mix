---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-09T10:23
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

## Description

### FE

- [ ] Download config file
	- DownloadConfigFile
	- downloadConfigFileClicked
- [ ] Download pending config file
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

canDownloadConfigFile = canAccessMobileDeviceSettings && canAccessEvents

ModuleRoutes.GET_CONFIG_FILE.ToLinkCarrier("downloadConfigFile", new { orgId = organisationId }),
ModuleRoutes.GET_PENDING_CONFIG_FILE.ToLinkCarrier("downloadPendingConfigFile", new { orgId = organisationId }),

#### Rules

hsFmDevices.Contains
hsM4kDevices
hsM6kDevices

DeviceConfigClient.MobileUnits.GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary

### Client




## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-930_AddConfigFileDownloads.INT

## PR

- [ ] OPEN-930 Add Config File Downloads > DEV
- [ ] OPEN-930 Add Config File Downloads > INT

