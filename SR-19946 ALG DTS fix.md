---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-19T09:20
---

# SR-19946 ALG DTS fix

Date: 2025-03-19 Time: 08:46
Parent:: [[DST]]
Friend:: [[2025-03-19]]
JIRA:SR-19946 ALG DTS fix
[SR-19946 Time Adjustment tool in OMAN - Jira](https://csojiramixtelematics.atlassian.net/browse/SR-19946)

Similar to:: [[SAAS-10447 DST Tool in OMAN 18.17]]

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

We got it sorted in OMAN
- [[OMAN DST Command 45 Setup]]
Now we just need to figure this out for ALG

## Finding the server

- ~~HSATSIIS06~~
- ~~HSATSIIS07~~
- ~~HSATSIIS11~~
- ~~HSATSIIS12~~
- Searched Jira:
	- HSATSDMXIIS01
	- HSATSDMXIIS02
	- HSATSMCIIS04
	- HSATSAPC04
	- HSATSAPP09
- Aaaarrrggghhhh - check [[Production Servers]] for **ATS**
	- HSATSDCSIIS01
	- HSATSDMXIIS01,02
- 