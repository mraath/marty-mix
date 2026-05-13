---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-11-14T15:22
---

# OPEN-1052

Date: 2025-11-13 Time: 14:53
Parent:: ==xxxx==
Friend:: [[2025-11-13]]
JIRA:OPEN-1052
https://powerfleet.atlassian.net/browse/OPEN-1052


## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```


## Shorter Description

It was added: https://dev.azure.com/MiXTelematics/Common/_build/results?buildId=549573&view=logs&s=96ac2280-8cb4-5df5-99de-dd2da759617d

- [x] DEV UI ✅ 2025-11-14
	- https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/134204
	- POT file also updated in Languaging
- [x] TEST on INT ✅ 2025-11-14

> Config/MR/OPEN-1052_NoDataFoundLanguagingKendo.INT


## POC

![[Pasted image 20251114114857.png]]

```html
	  <ng-template kendoMultiSelectNoDataTemplate>
          <div class="custom-no-data-msg">
              {{'NO DATA FOUND!!!'|dmxTranslate }}
          </div>
      </ng-template>
    </kendo-multiselect>
```