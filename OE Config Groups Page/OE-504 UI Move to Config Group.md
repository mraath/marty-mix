---
created: 2023-03-27T07:35
updated: 2024-10-31T08:19
status: busy
comment: 
priority: 1
---

# OE-504 UI Asset Move to Config Group

Date: 2024-08-12 Time: 10:39
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-08-12]]
JIRA:OE-504 UI Asset Move to Config Group
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-504)

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

ADD IMAGE

## Description


- [x] When one or more assets have been selected then the user should be able to select the Move to config group option ✅ 2024-08-12
- [x] When this is selected then open the modal ✅ 2024-08-12
- [x] Green header: Move to config group ✅ 2024-08-12
- [x] Help text: You have selected x assets. Please select a configuration group to move these to: ✅ 2024-08-12
- [x] Below this is a drop-down list of available configuration groups ✅ 2024-08-12
- [x] The user needs to be able to also easily search for a specific config group so the select box should also double as a searchable field ✅ 2024-08-12
- [x] Once the user has selected the config group then the user can select “Move” ✅ 2024-08-12
- [x] This should then move the selected assets to said config group ✅ 2024-08-14
- [x] Close the modal and display a green toast message on the screen with the text: Assets moved successfully ✅ 2024-08-14
- [x] If it does fail for whatever reason then display the error on the screen as per usual ✅ 2024-08-19
- [x] We need to keep the existing move logic in place where a user can only move to config groups with the same mobile device etc ✅ 2024-08-19

## Error handling

Commissioning Blocked

![[OE-504 UI Move to Config Group Blocked Fixed.png]]

Incompatible Assets

![[OE-504 UI Move to Config Group Incompatible Fixed.png]]

Incompatible VIN

![[OE-504 UI Move to Config Group VIN Fixed.png]]


## Verify the behaviour when the move operation fails

There are three potential reasons a move could fail:

1) Commissioning Blocked: When the target Config group doesn't allow manual commissioning of assets.
	- For my testing I forces this to happen in the API, however, I did see that the following works... on Amy's org
	- If you try to assign an unallocated asset to the "Default configuration group for AEMP", you should get the error:
![[OE-504 UI Move to Config Group Blocked Fixed.png]]

2) Mobile device type differs: When you try to move it to a config group which has a different mobile device type than the one installed on the asset you are trying to move. 
	- For my testing I also forces this to happen in the API.
	- From the logic I implemented in the new Beta UI, this shouldn't be possible, as I am removing all incompatible assets before trying to move them. This is an enhancement we have added in.
	- I think it will be safe to not spend too much time to try and test for it. Maybe just select a few config groups with different mobile device types, then select all the assets (with different mobile device types) and try to move them to a config group.
	- It should then remove the incompatible ones before trying to send them.
	- Herewith an example of how it would look if it was incompatible, once again, I can't see this happening with the new UI
![[OE-504 UI Move to Config Group Incompatible Fixed.png]]

3) Incompatible VIN: This seems to handle errors if the device was dynamic can, without a VIN number, however, this logic was removed in the BE over a year ago. I left the CATCH in the UI, in case this is ever introduced again. I highly doubt this will be the case.
	- For my testing I also forced this in the API.
	- You won't be able to test this currently, as this can't happen currently, looking at the API.
	- IF it was ever to be introduces again, it will look something like this
![[OE-504 UI Move to Config Group VIN Fixed.png]]

I would say, speak to the PO about #3 above. I am sure the PO will also know that this was removed about a year ago.

