---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-10T11:57
---

# OPEN-698 Languaging

Date: 2025-09-10 Time: 11:37
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-10]]
JIRA:OPEN-698 Languaging
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-698)


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

![[OPEN-698 Languaging 1.png | 400]]

![[OPEN-698 Languaging 2.png|400]]

![[OPEN-698 Languaging 3.png|400]]

![[OPEN-698 Languaging 4.png|400]]

## Language strings

### TEST

- [ ] Select the camera names from the dropdown to assign to the camera  channels. Custom names can be added on the Camera name tab. It is not possible to assign the same camera name to more than one channel.

### TODO

- [ ] Add Camera Name
- [ ] Camera direction
- [ ] Select camera direction
	- [ ] Road facing
	- [ ] In-cab
	- [ ] Driver facing
	- [ ] Left side facing
	- [ ] Right side facing
	- [ ] Rear facing
	- [ ] Other
- [ ] Duplicate Camera Name
- [ ] Camera name already exists.