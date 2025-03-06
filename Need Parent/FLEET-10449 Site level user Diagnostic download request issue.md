---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-02T13:01
---

# FLEET-10449 Site level user Diagnostic request issue

Date: 2024-10-01 Time: 10:11
Parent:: [[Permissions]]
Friend:: [[2024-10-01]]
JIRA:FLEET-10449 Site level user Diagnostic request issue
[FLEET-10449 REG Assets: Permission error for site level user on diagnostic downloads - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/FLEET-10449)


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

Environment: Integration
Steps to replicate:
Precondition: Log in site level user
- [x] Test user: m.raath@gmail.com ✅ 2024-10-01
Test site: Active 

1.Navigate to Monitor > Fleet Admin > Assets
2.Click more options drop down on FM asset
3.Select Diagnostic option
4.Request current status or Quick download or Full download

BUG: Permission error occurs
Insufficient permissions to perform this action. Please contact your administrator for further assistance.
Error no: 1575626431131996160

![[FLEET-10449 Site level user Diagnostic download request issue Duplicated error.png]]

- Request URL: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/-5401647754082838271/1529920155830849536/request-current-status
	- Route: PutRequestCurrentStatus 
	- Method: PutRequestCurrentStatus
	- CAN_ACCESS_DIAGNOSTICS = 400000001
	- Code Jako added
	- ![[FLEET-10449 Site level user Diagnostic download request issue Jako is the guy.png]]
		- DeviceIntegrationManager.AuthoriseDiagnosticAccessForOrgAndPermission
			- Zeshan worked on this a few weeks before Jako
			- 
Request Method: PUT
1. "Insufficient permissions to perform this action. Please contact your administrator for further assistance.<br />\n<strong>Error no: 1577667912198234112</strong>"
	

I have set up a user to test this issue with. I have duplicated the potential issue.  
- NA: Zeshan taking over: Next I will check the permission logic.



## Ideas

- NA: Zeshan taking over: Duplicate in Prod
- [x] Duplicate on INT ✅ 2024-10-01

## SR Meeting Notes


## Useful Comments from Jira

