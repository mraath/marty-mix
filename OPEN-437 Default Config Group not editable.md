---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-24T11:53
---

# OPEN-437 Default Config Group not editable

Date: 2025-07-22 Time: 14:54
Parent:: ==xxxx==
Friend:: [[2025-07-22]]
JIRA:OPEN-437 Default Config Group not editable
==URL TO JIRA==

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


## SP 2

### FE
- [ ] Task 1 
  PR: xxxxxxxxxx

### BE
- [ ] Task 1
	- https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-1983255592473789111/config_groups
	- Request Method: POST
		- GET_CONFIG_GROUPS_LIST
		- GetConfigGroupListPage
			- In class ConfigGroup add IsDefault
			- MiX.DeviceConfig.Api.Client, Version=25.13.0.0: GetConfigurationGroupSummaries
			- 
      PR: xxxxxxxxxx

### FR UI
- [ ] https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-1983255592473789111
	- Request Method: GET
	- getConfigurationGroupsMultiselect
      PR: xxxxxxxxxx

### FR API
- [ ] Need IsDefault on the Carrier For Single Edits
- [ ] ALSO need IsDefault on the Carrier for lists, this will be a much longer one....
      PR: xxxxxxxxxx


- **OLD Page**
	- [ ] UI > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] BE > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] Client > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] API > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] Common > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] EF
		- [ ] PR INT
		- [ ] PR DEV

- **BETA Page**
	- [ ] FR UI > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] FR API > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] Client > 
		- [ ] PR INT
		- [ ] PR DEV
	- [ ] **API** > 
		- [ ] PR INT
		- [ ] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/127851)
	- [x] **Common** > ✅ 2025-07-24
		- [x] [PR INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/127808) ✅ 2025-07-23
			- MiX.DeviceIntegration.Common.2025.7.23.1.nuspec
			- https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/127810
			- MiX.DeviceIntegration.Common.2025.14.20250723.2.nupkg
		- ~~PR DEV~~
	- [ ] **DB**
		- [ ] PR INT
		- [ ] [PR DEV](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/127850) Manually put on DEV

## Gameplan

- OLD Page
	- UI > BE > Client > API > Common > EF
- BETA Page
	- FR UI > FR API > Client > API > Common > DB

## Branch

> **Branch**: Config/MR/Feature/OPEN-437-Default-Config-Group-not-editable.INT

OPEN-437: Disable edit and remove for default groups

TEST DEV: 
	https://config.dev.mixtelematics.com/#/fleet-admin/driver/details?id=-8383490494337834621&orgId=5373602768183155046
	https://config.dev.mixtelematics.com/#/fleet-admin/asset/details?id=1684661151430238208&orgId=4036779219063094058
	ORGID: 5474499515462821884
TEST INT: https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1466026638581260288&orgId=-1983255592473789111

> [!warning] Some Default groups are not set as IsDefault = 1



- DB
	- g.LocationTemplateName,
	- g.IsDefault, <<<<<<<<<<<<<

- Config.Api
	- ConfigurationGroupAddEdit : class ConfigurationGroup (MiX.DeviceIntegration.Common, Version=2025.7.11.1)
		- public bool IsDefault { get; set; }
		- "[template].[Template_GetConfigurationGroupsMultiselect]"
- Client
	- OLDER Class - not has above...
	- [ ] UPgrade the common class
- FR API
	- [ ] ensure it gets pulled through
- FR UI
	- [ ] enure it gets pulled through
	- [ ] BLOCK Edit and delete

- OLD BE
	- [ ] Ensure you make use of new common
- OLD FE
	- [ ] Ensure pulled through
	- [ ] BLOCK Edit and delete