---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-05-14T11:32
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
	- [x] compile for the ones that can ✅ 2025-05-13
	- [x] notify that some of the assets cannot request compile: "Some assets could not request compile" ✅ 2025-05-14
	- [x] language above ✅ 2025-05-14
- “it also doesn’t action the compile for the other…” - this is a bug as the original spec said it should not crash on error but continue with the rest
	- [x] fail cleanly and continue with the rest ✅ 2025-05-14

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

## Swagger TEST

-5401647754082838271

{
  "Ids": [
    "1596635336800804864",
    "1606679698413109248",
    "1631447698450665472",
    "1647399904357085184"
  ],
  "IdType": "1",
  "Action": "Compile",
  "WhenToUpload": 0,
  "WhenToUploadDateTime": {
    "DateTime": "2025-05-08T14:58:54",
    "IsoDateTimeString": "2025-05-08T14:58:54",
    "TimeZoneName": "string",
    "TimeZoneShortCode": "string",
    "LocalName": "string"
  }
}

curl -X 'POST' \ 'https://localhost:7116/api/configuration-groups/groupId/-5401647754082838271/compile-upload-configuration?authToken=8ccbb261-df68-44d2-854b-d70158a95f36' \ -H 'accept: text/plain' \ -H 'Content-Type: application/json' \ -d '{ "Ids": [ "1596635336800804864", "1606679698413109248", "1631447698450665472", "1647399904357085184" ], "IdType": "1", "Action": "Compile", "WhenToUpload": 0, "WhenToUploadDateTime": { "DateTime": "2025-05-08T14:58:54", "IsoDateTimeString": "2025-05-08T14:58:54", "TimeZoneName": "string", "TimeZoneShortCode": "string", "LocalName": "string" } }'

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
						- await **xxxxxxxxxxxxx**
						- 
					- Upload
		- 

## Suggestion

![[OE-651 Multiselect Compile Error Suggested fix.png|550]]

## Current Status

Part **one**: Languaging string. I know where we can change this. We need to decide what this string should be.  
Part **two**: Cleanly failing per unit. I have looked at the code. The loop that tries to schedule each individual mobile unit doesn’t have a try-catch. Therefore, it will not cleanly fail for one mobile unit and continue to the next. This code will need to change.  
Currently, this code is referenced in many places.  
Our team will just quickly need to discuss the best way forward.



## Languaging

### This  one

- [ ] Some assets could not request compile <<<<< ???????

### Non Related

- Compile failed
- Compile requested
- Firmware upload request successful
- Request submitted successfully
- Upload failed
- Upload request submitted successfully
- Upload requested

## Branch

- Config API: Config/MR/Bug/OE-651_Compile_Fail_Nicely
- OLD UI: Config/MR/Bug/OE-651_Compile_Fail_Nicely

## Deploy

- [ ] PR **INT** UI: xxxxxxxxxxx
- [ ] PR INT API: xxxxxxxxxxx
- [ ] PR **DEV** UI: [Pull request 124558: OE-651: Added a better toast message - Repos](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/124558)
- [ ] PR DEV API: [Pull request 124559: OE-651: Added Try catch to fail nicely for a list of units - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/124559)
