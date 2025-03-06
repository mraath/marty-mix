---
created: 2023-03-27T07:35
updated: 2024-10-28T11:40
status: busy
comment: 
priority: 1
---

# OE-541 Config Compile Status

Date: 2024-10-22 Time: 15:31
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-10-22]]
JIRA:OE-541 Config Compile Status
[OE-541 Config compile status show nothing on Old Configuration group for all devices while on the New Configuration group show “Generation Complete” 4000, MIX2000 and FM but show nothing or empty spaces for 3rd Party devices. - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-541)


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

==Config compile status== show 
- **Old** Configuration: **nothing** on  group for all devices 
	- ![[OE-541 Config Compile Status example 1.png|200]]
- **New** Configuration group: while on the show “Generation Complete” 
	- 4000, 
	- MIX2000 and 
	- FM 
	- but show nothing or empty spaces for 3rd Party devices.
	- ![[OE-541 Config Compile Status eg 2 New.png|200]]

### NA: Comms Logs Fixed Egs

Old Configuration Group shows 8 Comms Logs on the Regression test Units Org:

![[OE-541 Config Compile Status Old eg.png|500]]

New Configuration Group shows 8 Comms Logs on the Regression test Units Org:

![[OE-541 Config Compile Status eg 2 Also 8 in New.png|500]]

This was fixed with my compile and upload work that also reflects the Comms Status for the FM units.


**Asiphe**: This BUG is concern about Config compile status that are not same in Old Configuration and New Configuration for MIX6000, MIX4000, MIX2000 and FM not about comms log. So may you please look at it again.




## Justus

Just to update you on OE-541 The Config compile status should come from ==ConfigurationGenerationWarning== on the mobile units table.. We not bringing this back as a final property on the **SP**.  The display on the **UI** are **abbreviated**. There should also be an a tag **link** which opens up a modal.. so i think this might be another message call to the UI to open the modal with a full description of the warning.

- NA: Return ConfigurationGenerationWarning from SP
- NA: Show in UI
- [x] Add link to modal ✅ 2024-10-24

So sections that need looking at for the fix is the:

- [x] DB=>SP update, ✅ 2024-10-23
- NA: Core needs the warning property(nuget build), 
- NA: endpoint needs to map this in the call, 
- NA: FR_API needs to map this to send back to the FR_UI, 
- [x] FR_UI will need to have link (ConfigCompileStatus) ✅ 2024-10-24
- [x] shorter text ✅ 2024-10-24
- [x] to open modal and ✅ 2024-10-24
- FR UI. PR: [Pull request 113362: OE-541: Cleanup. Added Error modal for Config Compile Status. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/113362)

![[OE-541 Config Compile Status Modal Eg.png|300]]
- NA: Old UI may need to handle this message call. (Modal in new FR FE)

## Steps

- Looking for: Config compile status
- FE
	- field: 'configurationGenerationNotesShort', 
	- fieldAlt: 'configurationGenerationWarningShort'
	- Clicking the link: Search: viewConfigCompileStatus

```c#
viewConfigCompileStatus(row): void {
	var messageModal = "";
	var headerModal = "";

	if (row && row.configurationGenerationNotes) {
		headerModal = "Failed";
		messageModal = row.configurationGenerationNotes;
	}
	if (row && row.configurationGenerationWarning) {
		headerModal = "Warning";
		messageModal = row.configurationGenerationWarning;
	}

	if (messageModal) {
		var rowData = angular.copy(row);
		rowData.header = headerModal;
		var modalData = {
			data: rowData,
			title: "Config compile status",
			message: messageModal,
			cancelButton: null,
			okayButtonTitle: "OK",
		};
		this.scope["$indexScope"].$broadcast("showModal", "configCompileFailModal", modalData);
	}
}
```

- BE
	- ActiveCell: ConfigurationGenerationNotesShort
	- //Compile fail reason
		- IF MiX.DeviceIntegration.Common.Enums.ConfigurationStatus.CompileFailed (4)
			- MobileUnitConfigurationGenerationNotes (first 46...)
				- DeviceConfigClient.MobileUnits.GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary
					- MobileUnitConfigurationGenerationNotes = mu.ConfigurationGenerationNotes,
					- MobileUnitConfigurationGenerationWarning = mu.ConfigurationGenerationWarning
	- //Compile warning reason
- API
	- controller: GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary
	- man: GetMobileUnitSummariesForConfigurationGroup
		- MobileUnitConfigurationGenerationNotes = mu.==ConfigurationGenerationNotes==,
		- MobileUnitConfigurationGenerationWarning = mu.==ConfigurationGenerationWarning==,
	- ? GetMobileUnitSummariesForConfigurationGroup
- FR FE
	- field: "configCompileStatus"

## Stored Proc 

- The original stored proc: [[OE-497 API Load Assets]]
	- [mobileunit].[MobileUnit_GetAllMobileUnitsForConfigurationGroups]
- Common > API > Client > FR API > FR UI
	- ConfigurationGroupMultiselectAssetsList
	- OTHERS....
- Only show where ConfigurationStatus = 4 "Compile failed"
- Might need to send back the number value (4), WENT WITH BELOW
	- Alternatively ONLY fill the ConfigCompileStatus IF ConfigurationStatus = 4....
	- I think this is the fastest
- API, Stored proc, PR: [Pull request 113307: OE-541: Only populate the ConfigCompileStatus when the config status is faile... - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/113307)

## Languaging

- [x] Config compile status ✅ 2024-10-24
- [x] Failed ✅ 2024-10-28

## Screenshots

![[OE-541 Config Compile Status Test 1 Lining up.png|500]]

