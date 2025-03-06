---
status: open
date: 2023-07-26
comment:
priority: 5
---

# TECHDEBT-372 Make use of the Glablisation API for DST in DeviceConfig API

Date: 2023-07-26 Time: 10:18
Parent:: ==xxxx==
Friend:: [[2023-07-26]]
JIRA:TECHDEBT-372 Make use of the Glablisation API for DST in DeviceConfig API
[TECHDEBT-372](https://csojiramixtelematics.atlassian.net/browse/TECHDEBT-372)

## Outstanding in this file

- [ ] Local: 🟧 
- [ ] Dev: 🟨 
- [ ] INT: 🟩 
- [ ] UAT: 🟦 
- [ ] PROD: 🟪

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

## Branch

- TECHDEBT-372 Make use of the Glablisation API for DST in DeviceConfig API.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...
- **Common**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **Client**: XXX Branch Name
	- [ ] Local files committed
		- [ ] Local Nuget: xxxName
	- [ ] PR DEV: xxxURL
		- [ ] Nuget DEV: xxxName
	- [ ] PR INT: xxxURL
		- [ ] Nuget INT: xxxName
- **API**: XXX Branch Name
	- [ ] Local files committed
	- [ ] PR DEV: xxxURL
	- [ ] PR INT: xxxURL

## Testing notes

- What to test
- Passed or failed with images

## Description

- 