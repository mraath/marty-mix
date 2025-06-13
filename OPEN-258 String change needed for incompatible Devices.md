---
created: 2025-06-11T14:58
updated: 2025-06-13T14:16
---
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-258)

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

- [x] Ask Peter!! ✅ 2025-06-13

Hi there. We are looking into a wording issue.
Basically in the new BETA page... if you were to select a few assets, but they are of different Device Types...
IF you go.... Move to Config Group.... you get shown a dialogue... where you should select the config group to move to...
If you were to select a MiX4000 (for instance) Config Group.... and there were also MiX3000s in there... it would show you a very serious message about the device being decommissioned, etc....
HOWEVER...
Actually we would just deselect any incompatible assets from the selection made, automatically, and then only move the (in this case) MiX4000 assets to the new Config Group...
 
What should the message be?
 
Something like:
"The incompatible devices will not be moved."
Something like that?
 
I am quickly looking to send you the current screenshot....

![[String change needed for incompatible Devices Message Eg.png|500]]


[[Legacy Config Group Move different Device Types]]

## Decision

I will change it to:

The mobile device type in this configuration group differs from the mobile device type installed in **1** of these asset(s). To move the asset(s) to this configuration group, please use the 'Change mobile device' function on the mobile device settings screen on the Assets page.


- [x] Add it in ✅ 2025-06-13
- [x] Language ✅ 2025-06-13

## Merge

Branch: Config/MR/Feature/OPEN-258_AddingNewIncompatibleDevicesString

- [ ] [PR DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/126146)
- [ ] PR INT

## Locally tested

![[OPEN-258 String change needed for incompatible Devices New String Local.png|400]]