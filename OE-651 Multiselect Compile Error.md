---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-12T12:26
---

# OE-651 Multiselect Compile Error

Date: 2025-05-08 Time: 13:48
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-05-08]]
JIRA:OE-651 Multiselect Compile Error
[OE-651 Beta - multiselect - compile error - no indication which asset is causing the issue - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-651)


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

- I believe the behaviour here should be to request the compile for the ones that can and perhaps just notify that some of the assets cannot request compile (need some wording here) perhaps it can be an orange warning toast message I dont think we need to say which ones as the ones that failed would all stay in config changed status
	- [ ] compile for the ones that can
	- [ ] notify that some of the assets cannot request compile
	- [ ] language above
- “it also doesn’t action the compile for the other…” - this is a bug as the original spec said it should not crash on error but continue with the rest
	- [ ] fail cleanly and continue with the rest

![[OE-651 Multiselect Compile Error Eg.png|650]]

- 3,7,12,20
- SEND
- Payload: {
  "ids": [
    "1596635336800804864",
    "1606679698413109248",
    "1631447698450665472",
    "1647399904357085184"
  ],
  "idType": 1,
  "whenToUploadDateTime": {
    "isoDateTimeString": "2025-05-08T14:58:54"
  }
}
- Compile Failed
- https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-5401647754082838271/upload-configuration
- REPLY
- {
  "id": null,
  "value": false,
  "resultMessage": "System.Collections.Generic.List`1[System.String]"
}

## Coding

- C:\Projects\MiX.Config.Frangular.API\MiX.Config.Frangular.Logic\ConfigurationGroupManager\ConfigurationGroupManager.cs
	- CompileAndUploadConfiguration
	- ConfigurationGroups.CompileAndUploadConfiguration
- Client
	- CompileAndUploadConfiguration
	- groupId/{groupId}/compile-upload-configuration
- Config.Api
	- CompileAndUploadConfiguration
	- man.CompileAndUploadConfiguration
		- split
			- config
				- split
					- Compile
						- await CompileConfigurationGroups
						- 
					- Upload
			- asset
				- split
					- Compile
						- await xxxxxxxxxxxxx
						- 
					- Upload
		- 

## Languaging

### This  one

- [ ] xxxxxxxxxxxxxx

### Non Related

- Compile failed
- Compile requested
- Firmware upload request successful
- Request submitted successfully
- Upload failed
- Upload request submitted successfully
- Upload requested
