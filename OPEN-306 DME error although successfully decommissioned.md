---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-19T10:40
---

# OPEN-306

Date: 2025-06-18 Time: 14:55
Parent:: ==xxxx==
Friend:: [[2025-06-18]]
JIRA:OPEN-306
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-306)


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


## Code

- UI: removeMobileDeviceTemplate.save
- REMOVE_MOBILE_DEVICE
	- /assets/commissioning/{orgId}/{assetId}/remove-mobile-device
	- RemoveMobileDevice
	- 

## What next

- [ ] Find in Code where it bombs out
- [ ] See if it should be fixed or if this is just something to explain
