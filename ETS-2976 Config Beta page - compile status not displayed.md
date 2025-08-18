---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-18T09:45
---

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

![[Untitled 5.png]]

BETA version

![[ETS-2976 Config Beta page - compile status not displayed.png]]



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

## OLD CG?

FM 3607i
configurationGenerationNotesShort
ConfigurationGenerationNotes



## Notes

configurationGenerationNotesShort || configurationGenerationWarningShort
ConfigurationGenerationNotes
ConfigurationGenerationWarning

configurationGenerationNotesShort
configurationGenerationWarningShort

==Click on it modal==