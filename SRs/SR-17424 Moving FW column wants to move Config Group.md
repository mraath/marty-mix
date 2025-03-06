---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-02-20T09:13
dg-publish: true
dg-home: 
---

# SR-17424 Moving FW column wants to move Config Group

Date: 2024-02-07 Time: 08:42
Parent:: [[Configuration Groups]]
Friend:: [[2024-02-07]]
JIRA:SR-17424 Moving FW column wants to move Config Group
[URL TO JIRA](https://csojiramixtelematics.atlassian.net/browse/SR-17424)


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

## Image learned from this issue

![[SR-17424 Moving FW column wants to move Config Group.png]]

## Shorter Summary

- Message box: Changing configuration group
- Maybe test for: ui.draggedModel.length > 0
	- Where it says... moveAssetsConfirmation(ui.draggedModel, ui.droppedModel)
## Description

![[SR-17424 Moving FW column wants to move Config Group POssible Fix.png]]

## Branches

- Base it off of: Version 24.2
- Config/MR/Bug/SR_17424_DraggingFW_22.2.ORI
- [DEV PR](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/97566)
- [x] [INT PR](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/97813) ✅ 2024-02-12
- [ ] [UAT](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/98377)
- [ ] PROD PR

## Testing

- Search for this in the min code: MoveAssetEvent
- Set breakpoints
- 



## Final Findings for Jira

- 
