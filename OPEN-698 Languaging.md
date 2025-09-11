---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-11T12:01
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

### Descr 1

![[OPEN-698 Languaging 1.png | 400]]

### Descr 2

![[OPEN-698 Languaging 2.png|400]]

### Descr 3

![[OPEN-698 Languaging 3.png|400]]

### Descr 4

![[OPEN-698 Languaging 4.png|400]]


## Language strings

### TEST

- [x] Select the camera names from the dropdown to assign to the camera  channels. Custom names can be added on the Camera name tab. It is not possible to assign the same camera name to more than one channel. ✅ 2025-09-11
- [x] Add Camera Name ✅ 2025-09-11
- [x] Camera direction ✅ 2025-09-11
- [x] Select camera direction ✅ 2025-09-11
- [x] Duplicate Camera Name ✅ 2025-09-11
- [x] Camera name already exists. ✅ 2025-09-11
- [x] Road facing ✅ 2025-09-11
- [x] In-cab ✅ 2025-09-11
- [x] Driver facing ✅ 2025-09-11
- [x] Left side facing ✅ 2025-09-11
- [x] Right side facing ✅ 2025-09-11
- [x] Rear facing ✅ 2025-09-11
- [x] Other ✅ 2025-09-11

> p.id as (p.title | translate) for p in deviceList

- Handled in OPEN-505: [PR TO DEV dropdown languaging](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/130564)

## DEV TEST

![[OPEN-698 Languaging Test 1.png | 400]]

![[OPEN-698 Languaging Test 2.png|400]]

![[OPEN-698 Languaging Test 3.png|400]]

![[OPEN-698 Languaging Test 4.png|400]]


this.languageService.translate("Config group successfully created")