---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-23T09:34
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
	- 
      PR: xxxxxxxxxx

### FR UI
- [ ] https://mixconfigfrangularapi.mixdevelopment.com/api/configuration-groups-multiselect/groupId/-1983255592473789111
	- Request Method: GET
	- 
      PR: xxxxxxxxxx

### FR API
- [ ] Need IsDefault on the Carrier For Single Edits
- [ ] ALSO need IsDefault on the Carrier for lists, this will be a much longer one....
      PR: xxxxxxxxxx


## Branch

> Branch: Config/MR/Feature/OPEN-437 Default Config Group not editable.INT

- Config.Api
	- ConfigurationGroupAddEdit : class ConfigurationGroup (MiX.DeviceIntegration.Common, Version=2025.7.11.1)
		- public bool IsDefault { get; set; }
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