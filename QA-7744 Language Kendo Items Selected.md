---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-05T08:17
---

# QA-7744 Language Kendo Items Selected

Date: 2025-12-03 Time: 15:02
Parent:: ==xxxx==
Friend:: [[2025-12-03]]
JIRA:QA-7744 Language Kendo Items Selected
[JIRA](https://powerfleet.atlassian.net/browse/QA-7744)



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

![[Pasted image 20251203150325.png]]


[[Languaging Kendo Items Selected]]

## Branch

> Branch: Config/MR/Feature/QA-7744_LanguageKendoItemsSelected.22

## PR

- [x] QA-7744 Language Kendo Items Selected > INT ✅ 2025-12-03
	- [x] [Languaging moved](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135575?_a=files) ✅ 2025-12-04
- [x] [QA-7744 Language Kendo Items Selected > UAT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/135516?_a=files) ✅ 2025-12-05

- Languaging - done to Master
