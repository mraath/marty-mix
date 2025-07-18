---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-18T11:17
---

# OPEN-403 Multiselect Columns

Date: 2025-07-17 Time: 09:14
Parent:: ==xxxx==
Friend:: [[2025-07-17]]
JIRA:OPEN-403 Multiselect Columns
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-403)


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

The following was stated by @Shawn Hancock in a Teams discussion with me:

“…**ensure the popup remains open while selecting and deselecting checkboxes**. The rest is all good.

There's documentation they can follow on Kendo's website:

[https://www.telerik.com/kendo-angular-ui/components/popup/closing](https://www.telerik.com/kendo-angular-ui/components/popup/closing)”


## Code - NONE of this or the above link worked... I just set two places from true to false :-)

### HTML

assetsColumnChooserButton: button #assetsColumnChooserButton (anchor) (click)="onToggleGridConfigAssetsColumns()" 
popup: kendo-popup #popup class="popup-column-chooser" [anchor]="assetsColumnChooserButton" **(missing .element)** SHOULD HAVE!!!!!
 
### TS

@ViewChild("assetsColumnChooserButton") public assetsColumnChooserButton: ElementRef; (already there)
@ViewChild("popup", { read: ElementRef }) public popup: ElementRef; (ALREADY)

Added: @HostListener("document:keydown" - as per example
Changed: @HostListener("document:click - as per example
Changed: public onToggleGridConfigAssetsColumns(show - as per example
Changed: private contains(target - as per their example

## PR

- BRANCH: Config/MR/OPEN-403_Multiselect_Columns_INT
- [x] [OPEN-403: PR to DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/127540?_a=files) ✅ 2025-07-17
- [x] [OPEN-403: PR to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/127549) ✅ 2025-07-18
