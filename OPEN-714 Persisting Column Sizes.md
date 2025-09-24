---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-24T13:07
---

# OPEN-714 Persisting Column Sizes

Date: 2025-09-23 Time: 11:24
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2025-09-23]]
JIRA:OPEN-714 Persisting Column Sizes
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-714)

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
      PR: xxxxxxxxxx

### DB
- [ ] Task 1
      PR: xxxxxxxxxx


## Notes

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/query?datacentre=DEV
	dictionaries
		configGroupsColumnWidths
			  0: {key: "sp", value: "200"}
		configGroupsColumnOrder
			0: {key: "sp", value: "14"}

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/query?datacentre=DEV
	configAssetsColumnWidths
		0: {key: "sp", value: "200"}
	configAssetsColumnOrder
		0: {key: "sp", value: "27"}

https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/update?datacentre=DEV
	Payload: configAssetsColumnWidths, configAssetsColumnOrder

Upbove is the update.... so width is on the payload - so SHOULD save it.... so just add the persisting part....
CALLING update on column width change

- [ ] Add an OnColumnWidthChanged (something like that)



## Branch

> Branch: Config/MR/Feature/OPEN-714 Persisting Column Sizes.INT

