---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-02-22T10:59
---

# MX46-1358 DTC Not Languaged

Date: 2024-02-22 Time: 10:17
Parent:: [[Languaging]]
Friend:: [[2024-02-22]]
JIRA:MX46-1358 DTC Not Languaged
[JIRA](https://csojiramixtelematics.atlassian.net/browse/MX46-1358)

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

- Log in with Pig Latin as your Selected Language 
- Navigate to MANAGE>CONFIG ADMIN>Configuration groups (Anagemay>Onfigcay Adminway>Onfigurationcay oupsgray) 
- Open the Mobile device template (Obilemay eviceday emplatetay) 
- Then click on the Mobile device type: MiX 4000 (Obilemay eviceday ypetay: MiX4000) 
- Scroll down to: ==Send fault codes==
- NOTES:
	- It is between:
	- **Send AVLs**
	- **Unit power management**
## Duplicate Issue

- DONE
## Screenshot of the issue

![[MX46-1358 DTC Not Languaged Seems fine.png]]


## DONE

It was fixed by Paul
![[MX46-1358 DTC Not Languaged Fixed by Paul.png]]