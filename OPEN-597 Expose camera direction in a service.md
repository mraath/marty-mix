---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-19T10:26
---

# OPEN-597 Expose camera direction in a service

Date: 2025-08-18 Time: 16:49
Parent:: ==xxxx==
Friend:: [[2025-08-18]]
JIRA:OPEN-597 Expose camera direction in a service
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-597)

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

**Overview**

We need the ability to accurately identify camera channels when custom camera names are captured on the UI, this is especially needed when video blurring is enabled for an organisation.

The purpose of this story is to update the existing “Add camera name” modal to allow users to select the direction a camera is pointing to. For the screen design refer to [https://powerfleet.atlassian.net/browse/VA-1228](https://powerfleet.atlassian.net/browse/VA-1228)  
1. [ ] Add a dropdown feature on the “Add camera name” modal to allow users to select the direction a camera is pointing to.
2. [ ] The default state of the dropdown is blank, and selecting an option is mandatory.
3. [ ] The user must be prompted to select the camera direction first, then followed by the camera name.
4. [ ] Display the following options in the “Select camera direction” dropdown list:
    1. Road facing
    2. In-cab
    3. Driver facing
    4. Left side facing
    5. Right side facing
    6. Rear facing
    7. Other
5. [ ] When the camera direction is selected, pre-fill the “Add camera name” field with the camera direction selected in the dropdown.
6. [ ] The “Add camera name” field is editable and mandatory as per current process, and functionality to close, save and cancel must be retained.
7. [ ] When “Other” is selected in the dropdown, display the Add camera name field as blank.
8. [ ] Note the above changes must also be applied to the Edit camera name flow.

**Screen wording updates:**

- [x] Remove the “s” in the text underlined in red below. It should read “Camera name” as it refers to the Camera name tab. ✅ 2025-08-19

![[Untitled 6.png|500]]

- [x] Change display text to “Add camera name”. ✅ 2025-08-19

![[Untitled 7.png|300]]

---

The purpose of this story is to expose the camera direction data in a service/API as developed in https://powerfleet.atlassian.net/browse/OPEN-505 
The Data Science team will use the camera direction to apply blurring to specific channels

Do this for:
- [ ] Add camera name
- [ ] Edit camera name


## Searches

regex:
Assign to channels|Camera name|Camera names tab|Add.*camera.*name|assign to channels|camera names tab|add cameras name

## Branch

> Branch: Config/MR/Feature/OPEN-597_Expose_camera_direction_in_a_service.INT

## Repo

- [ ] PR FE to DEV
- [ ] PR FE to INT

