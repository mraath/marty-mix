---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-07-22T10:02
---

# OE-485 UI Holding page with the Configuration Group Multiselect Panel and Assets List Panel

Date: 2024-01-23 Time: 11:44
Parent:: ==xxxx==
Friend:: [[2024-01-23]]
JIRA:OE-485 [UI] Holding page with the Configuration Group Multiselect Panel and Assets List Panel
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-485)

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

## Image Summary

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw#^group=0kkID4iNbx1wUfb2Js7se]]
## Description

- Look for the main layout and apply to existing code - currently I dont see it - find a similar one looking for the following - else ask Shawn
- dmx-iframe-host-adapter
- [MiX Telematics - Multiselect configuration groups](http://localhost/MiXFleet.UI/#/config-admin/configuration-groups-multiselect)
- -4493495256567590976
## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Result

![[OE-485 UI Holding page with the Configuration Group Multiselect Panel and Assets List Panel Current TMP View.png]]