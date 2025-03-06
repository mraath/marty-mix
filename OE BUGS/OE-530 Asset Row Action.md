---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-08T08:52
---

# OE-530 Asset Row Action

Date: 2024-10-07 Time: 14:41
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-10-07]]
JIRA:OE-530 Asset Row Action
[[OE-530] Asset details drop down not clickable - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-530)


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

- [ ] Only allow for Delete Asset action on the asset row
- [ ] Auth and permissions!! 

## Actions

### Assets

'Edit'
'View'
'Compile'
'Compile'
'Upload'
'Commission'
'Reset to group config'
'Upload firmware'
'Download config file'
'Download pending config file'
'Asset configuration file'

### Config Group

"Edit"
"View"
"CompileAll"
"Compile"
"CompileAndUpload"ConfigGroupsLandingController.CompileAndUploadGroupEvent },
"Upload"
"Rollback"
"Remove"
"UploadFirmware"ConfigGroupsLandingController.UploadFirmwareGroupEvent },
"VideoEventConfiguration"


## OLD Code

UI: 
- Action > Remove
- Method: removeAsset(asset)
	- Modal
		- title: 'Remove asset',
		- message: 'Are you sure you want to remove asset <strong>{{ assetName }}</strong>?',
	- pageData.removeAssetTemplate.removeAsset
		- 'Asset removed successfully' OR
		- showErrorModal(result.title, result.description)
			- ???

BE: 
- Route: AssetDetailsModule.ModuleRoutes.REMOVE_ASSET
- Method: RemoveAsset(string authToken, long orgId, long assetId)
- deregistration, decommissioning, etc LOGIC which is qute tense 😛
- canDelete

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing


