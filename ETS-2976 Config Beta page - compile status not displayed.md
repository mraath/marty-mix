---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-20T10:47
---
You will now see that it populates for more config statuses. It used to only populate for failed, but now it will also populate for failed.
# ETS-2976 Config Beta page - compile status not displayed

Date: 2025-08-15 Time: 14:05
Parent:: 
Friend:: [[2025-08-15]]
JIRA:ETS-2976 Config Beta page - compile status not displayed
[JIRA](https://powerfleet.atlassian.net/browse/ETS-2976)


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

IDC: UK

Example Database: Schlumberger-KWT-kuwait

Example Asset IMEI: 355544063920712

Issue: Config Compile status in the UK for config warnings is not showing on the beta page

It seems to be ok on ZA so might be something small in UK. RSO asked this to be logged as High and Zoe confirmed as the old config page is being deprecated in September. This is deemed very important so it is being logged as High priority.

Current Prod version

![[Untitled 5.png|500]]

BETA version

![[ETS-2976 Config Beta page - compile status not displayed.png|500]]



## Findings

As far as I can tell this is an FM 3607i/3617i. The **config compile status** 
INT: Regression Testing Units (do not edit)

==configCompileStatus==	FROM 
POST: 	https://mixconfigfrangularapi.dev.mixtelematics.com/api/configuration-groups-multiselect/groupId/2330833568360483679/assets-list
GetConfigurationGroupsMultiselectAssetsList
[mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]

```sql
CASE 
      WHEN mu.ConfigurationStatusId = @CompileFailed THEN
        ISNULL(mu.ConfigurationGenerationNotes, mu.ConfigurationGenerationWarning)
      ELSE '' 
    END AS ConfigCompileStatus,
```

FR UI - FR API - Client - API (==convert==):  controller, man (convert), Repo: GetConfigurationGroupsMultiselectAssetsList - [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]


The Warning statuses were not included
![[ETS-2976 Config Beta page - compile status not displayed-1.png|300]]


```sql
Use [DeviceConfiguration];
SELECT 
--top 10 *
DISTINCT TOP 100 Notes, Name
FROM mobileunit.MobileUnits mu
INNER JOIN mobileunit.AssetMobileUnits amu ON amu.MobileUnitKey = mu.MobileUnitKey
INNER JOIN template.ConfigurationGroups tcg ON tcg.ConfigurationGroupKey = mu.ConfigurationGroupKey
INNER JOIN library.Libraries ll ON ll.LibraryKey = tcg.LibraryKey
WHERE (ConfigurationGenerationNotes IS NOT NULL OR ConfigurationGenerationWarning IS NOT NULL)
AND ConfigurationStatus IN (14) --(4, 14, 0)
/*
AND MobileDeviceKey IN (
    SELECT DeviceKey FROM definition.MobileDevices WHERE [Description] like 'FM%'
)
*/


```
## OLD CG?

FM 3607i
configurationGenerationNotesShort
ConfigurationGenerationNotes

```html
<MiXFleet.UI.Grid.IClickableColumnDefintion>{ title: 'Config compile status', field: 'configurationGenerationNotesShort', fieldAlt: 'configurationGenerationWarningShort', translate: true, cellType: MiXFleet.UI.Grid.ClickableColumn, clickFn: (row) => this.viewConfigCompileStatus(row) },
```

```ts
if (mobileUnit.MobileUnitConfigurationStatus == MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.CompileFailed) //4
{
	carrier.ConfigurationGenerationNotes = mobileUnit.MobileUnitConfigurationGenerationNotes;
	var shortNote = (mobileUnit.MobileUnitConfigurationGenerationNotes != null && mobileUnit.MobileUnitConfigurationGenerationNotes.Length > 50) ? mobileUnit.MobileUnitConfigurationGenerationNotes.Substring(0, 46) + "..." : "" + mobileUnit.MobileUnitConfigurationGenerationNotes;
	carrier.ConfigurationGenerationNotesShort = new ActiveCell { Title = shortNote, Disabled = false };
}
else
{
	carrier.ConfigurationGenerationNotesShort = new ActiveCell { Title = "", Disabled = true };
}

//14 || (0 && MobileUnitConfigurationGenerationWarning)
if (mobileUnit.MobileUnitConfigurationStatus == MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.ConfigurationWarning ||
					(mobileUnit.MobileUnitConfigurationStatus == MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.NotCommissioned && string.IsNullOrEmpty(mobileUnit.MobileUnitConfigurationGenerationWarning) == false))
{
	carrier.ConfigurationGenerationWarning = mobileUnit.MobileUnitConfigurationGenerationWarning;
	var shortNote = (mobileUnit.MobileUnitConfigurationGenerationWarning != null && mobileUnit.MobileUnitConfigurationGenerationWarning.Length > 50) ? mobileUnit.MobileUnitConfigurationGenerationWarning.Substring(0, 46) + "..." : "" + mobileUnit.MobileUnitConfigurationGenerationWarning;
	carrier.ConfigurationGenerationWarningShort = new ActiveCell { Title = shortNote, Disabled = false };
}
else
{
	carrier.ConfigurationGenerationWarningShort = new ActiveCell { Title = "", Disabled = true };
}
```
## Notes Beta

configurationGenerationNotesShort || configurationGenerationWarningShort
ConfigurationGenerationNotes
ConfigurationGenerationWarning

configurationGenerationNotesShort
configurationGenerationWarningShort

==Click on it modal==

## Testing on DEV

![[ETS-2976 Config Beta page - compile status not displayed-2.png]]
## Repo

- Config/MR/Bug/ETS-2976_Config_Beta_compile_status_not_displayed.INT
- [PR TO DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/129172)
- [x] [PR TO INT](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequestcreate?sourceRef=Config/MR/Bug/ETS-2976_Config_Beta_compile_status_not_displayed.INT&targetRef=Integration&sourceRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291&targetRepositoryId=72660fef-f082-49a7-b7c0-8648450cd291) ✅ 2025-08-19

## Phase 2 error (to be logged)

- “Compile failed” hyperlink appears
	- example and what data does it show

```ts
//Modal loads Notes, then Warn
if (row && row.configurationGenerationNotes) {
		headerModal = "Failed";
		messageModal = row.configurationGenerationNotes;
}
if (row && row.configurationGenerationWarning) {
		headerModal = "Warning";
		messageModal = row.configurationGenerationWarning;
}
```

``