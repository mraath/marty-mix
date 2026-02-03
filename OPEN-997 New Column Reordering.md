---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-02-03T08:59
---

# OPEN-997 New Column Reordering

Date: 2026-01-26 Time: 15:15
Parent:: https://powerfleet.atlassian.net/browse/OPEN-715
Friend:: [[2026-01-26]]
JIRA:OPEN-997 New Column Reordering
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-997)



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

- Please provide all links investigated for these findings, including JIRA items (main and parent) and relevant repositories.

### Investigated Links
- **JIRA Story**: [OPEN-997](https://powerfleet.atlassian.net/browse/OPEN-997)
- **Parent JIRA**: [OPEN-715](https://powerfleet.atlassian.net/browse/OPEN-715)
- **Previous Work**: [OPEN-714](https://powerfleet.atlassian.net/browse/OPEN-714), [OPEN-371](https://powerfleet.atlassian.net/browse/OPEN-371)
- **MiX Seed Repo**: [MiX Seed](https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed)
- **Seed App Demo**: [http://10.224.2.56/fleet/seedapp/#/layout](http://10.224.2.56/fleet/seedapp/#/layout)
- **Frangular UI Repo**: [MiX.Config.Frangular.UI](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI)

## AI Questions:

### One

OK - I found the correct links....
In this link:
https://powerfleet.atlassian.net/browse/OPEN-715?focusedCommentId=1355185
Shawn mentioned this seed app where he did it:
MiX Seed: https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed


We would add something like that into this part of our logic:
C:\Projects\MiX.Config.Frangular.UI\src\app\configgroups\configgroups.component.html
And its relevant .ts file, where it mentions this:
          <kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns" [anchor]="configGroupsColumnChooserButton" (anchorViewportLeave)="showGridConfigGroupColumns = false" [animate]="false" [anchorAlign]="anchorAlign" [popupAlign]="popupAlign">

### Two

Did you see this part he mentioned:
@Richard Hobson I’ve done an example on the ui-config-groups branch on the MiX Seed app repo, showing column reordering via the column chooser popup. I would recommend setting [reorderable]="false" on the grid, so that the user is forced to use the column choose to reorder columns. They would still need to persist the column order state.

MiX Seed: https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed

### Three

Okay this is great, now looking at the seed app and the changes Sean showed there, could you try and duplicate that in our config groups page for a config group popup modal. Under this section
kendo-popup #popup class="popup-column-chooser" *ngIf="showGridConfigGroupColumns



## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-997_NewColumnReordering.INT

## PR

- [ ] OPEN-997 New Column Reordering > DEV
- [ ] OPEN-997 New Column Reordering > INT
- [ ] OPEN-997 New Column Reordering > UAT
- [ ] OPEN-997 New Column Reordering > PROD
