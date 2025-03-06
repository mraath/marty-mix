---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-28T11:36
---

# OE-484 SEED Frangular UI

Date: 2024-01-10 Time: 15:38
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-01-10]]
JIRA:OE-484 SEED Frangular UI
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-484)

## OE-484 TODO
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

## Image Summary

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw#^group=5EPVHjXfv-zqYgk9FVBXG]]
## Description

New Repo: MiX.Config.Frangular.UI
## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Work to be done

- [x] Commit PR and Auth Needed, currently it just allows any commits ✅ 2024-10-28
- [x] Fix host.names.ts ✅ 2024-10-28
- [x] Fix apiurl.list ✅ 2024-10-28
- [x] authToken not hardcoded ✅ 2024-10-28
	- ..\MiX.Config.Frangular.UI\src\app\configgroups\configgroups.component.ts
- [x] Write connection between old UI and new UI ✅ 2024-10-28
- [x] Spinner ✅ 2024-10-28
- [x] Languaging ✅ 2024-10-28
- [x] Read SelectionCriteria ✅ 2024-10-28

## Getting it to work

- Cloned
- kendo License
- npm install -g vsts-npm-auth
- ? npm run refreshVSToken
- ? npm install
- node_modules (Seperate download for now - exclude)
- 