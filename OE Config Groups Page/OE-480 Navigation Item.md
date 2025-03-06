---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-03-05T14:10
---

# OE-480 Navigation Item

Date: 2024-01-09 Time: 14:03
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-09]]
JIRA:OE-480 Navigation Item
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-480)

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

## Shorter Summary


![[OE-480 Navigation Item.png|400]]


## Description

- [x] Configuration groups (Beta) ✅ 2024-03-01
- [x] Language this ✅ 2024-03-01

Examples:
- Operations (Beta)
- Live tracking (legacy)
- Driver debrief dashboard (BETA)


## Branches

- Config/MR/Feature/OE-501-Frangular-B.24.3.INT
- ALWAYS merge INT back in before merging to DEV, then INT...

## Implementation

```c#
new UIModuleMenuLink()
{
	Name = "Multiselect configuration groups",
	Href = "/config-admin/configuration-groups-multiselect",
	AccessPermissionId = ConfigAdminPermissions.CAN_ACCESS_CONFIGURATION_GROUPS			//TODO: MR: Replace with new Permission if needed
},
```
