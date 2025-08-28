---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-08-28T10:22
---

# OPEN-505 Identify channels for blurring

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

![[OPEN-597 Expose camera direction in a service Overview.png]]

```html
<div class="well no-margin">
	<div class="row-fluid input">
		<label>
			<span>Camera direction</span>
			<span class="field-mandatory">*</span>
		</label>
		<select class="span12">
			<option selected disabled>Select</option>
			<option value="">Road-facing</option>
			<option value="">In-cab</option>
			<option value="">Driver-facing</option>
			<option value="">Left-side-facing</option>
			<option value="">Right-side-facing</option>
			<option value="">Rear-facing</option>
			<option value="">Other</option>
		</select>
	</div>
	<div class="row-fluid input mt-10">
		<label>
			<span>Camera name</span>
			<span class="field-mandatory">*</span>
		</label>
		<input type="text" class="span12">
	</div>
</div>

<select type="text" class="span12" ng-model="form.deviceTypeId" ng-options="p.deviceTypeId as (p.description | translate) for p in data.peripheralTypes" ng-change="$emit('peripheralTypeChanged', form.deviceTypeId)" dmx-validate="deviceTypeId" name="deviceTypeId">
	<option style="display: none" value="">{{ 'Select peripheral type' | translate }}</option>
</select>
```

getMobileDeviceTemplateDevice - MobileDeviceTemplateCrudModule.ModuleRoutes.GET_DEVICE_DETAILS - GetDeviceDetails - 

## UI

[LOCAL](http://localhost/MiXFleet.UI/#/config-admin/peripherals/edit?id=-565349616809011552)
[INT](https://integration.mixtelematics.com/#/config-admin/peripherals/edit?id=-565349616809011552)
## **Overview**

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


NA: Road facing|In-cab|Driver facing|Left side facing|Right side facing|Rear facing
LOT: Assign to channels|Camera name|Camera name tab|Add.*camera.*name|assign to channels|camera names tab|add cameras name|LogicalCameraDeviceSettings

## **Screen wording updates:**

- [x] Remove the “s” in the text underlined in red below. It should read “Camera name” as it refers to the Camera name tab. ✅ 2025-08-19

![[Untitled 6.png|500]]

- [x] Change display text to “Add camera name”. ✅ 2025-08-19

![[Untitled 7.png|300]]

---

![[OPEN-505 Identify channels for blurring 2025-08-21 10.36.00.excalidraw.svg]]
%%[[OPEN-505 Identify channels for blurring 2025-08-21 10.36.00.excalidraw.md|🖋 Edit in Excalidraw]]%%

## OPEN-597

The purpose of this story is to expose the camera direction data in a service/API as developed in https://powerfleet.atlassian.net/browse/OPEN-505 
The Data Science team will use the camera direction to apply blurring to specific channels

Do this for:
- [ ] Add camera name
- [ ] Edit camera name


## Searches

regex:
Assign to channels|Camera name|Camera names tab|Add.*camera.*name|assign to channels|camera names tab|add cameras name

---

DeviceConfigApi.DeviceConfigClient.LibraryPeripherals.AddLibraryCameraName
	string url = $"{PostPutApiUrl}/groupIds/{groupId}/devices/camera-names?authToken={authToken}";
	API?
		[Library].[LibraryCameraName_Add]
		DB?
DeviceConfigApi.DeviceConfigClient.LibraryPeripherals.UpdateLibraryCameraName
	string url = $"{PostPutApiUrl}/groupIds/{groupId}/devices/camera-names/{cameraNameId}?authToken={authToken}";
	API?
		[Library].[LibraryCameraName_Update]
		DB?


## Branch

> Branch: Config/MR/Feature/OPEN-597_Expose_camera_direction_in_a_service.INT

- Common
	- [x] [PR COMMON to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/129443) ✅ 2025-08-22
		- UpdateCameraName
		- MiX.DeviceIntegration.Common.2025.16.20250822.1.nupkg
	- [x] [PR COMMON to INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/129687) ✅ 2025-08-26
		- MiX.DeviceIntegration.Common.2025.16.20250826.2.nupkg
- **DB**
	- [x] Update 2 Stored Procs ✅ 2025-08-26
		- [x] [Library].[LibraryCameraName_Add] ✅ 2025-08-26
		- [x] [Library].[LibraryCameraName_Update] ✅ 2025-08-26
		- [x] [library].[CameraNames] ✅ 2025-08-26
		- [x] [PR TO DEV 1](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/129678) ✅ 2025-08-26
		- [ ] PR TO DEV 2
			- Allow NULL explicitly
		- [ ] PR to INT

I was very close to make the changed needed to these two stored procs:
[Library].[LibraryCameraName_Add]
[Library].[LibraryCameraName_Update]
Both of them in turn potentially write to:
[library].[CameraNames]
And then you go down a rabbit trail of code using this....

==REGEX==: library.*CameraName|UpdateCameraName|GetLibraryCameraNames



- API
	- [x] Update common ✅ 2025-08-26
	- [x] Update calling [Library].[LibraryCameraName_Add] ✅ 2025-08-26
	- [x] Update calling [Library].[LibraryCameraName_Update] ✅ 2025-08-26
	- LibraryCameraName
		- ? GetLibraryCameraNames

- Client
	- [x] Update common ✅ 2025-08-22
- BE
	- [x] Update common ✅ 2025-08-27
	- [ ] Update LOCAL Client
		- MiX.ConfigInternal.Api.Client.2025.16.20250826.1-alpha
		- GET 	http://localhost/DynaMiX.API/config-admin/organisations/7174429418516644767/peripherals/-565349616809011552
			- Form.LogicalDevices.CameraNames.
		- CameraNameCarrier
	- [ ] Update DEV Client
	- [ ] Update INT Client

- FE
	- [ ] Update Carrier
		- [ ] Send ADD new field
		- [ ] Send UPDATE new field
		- [ ] Get LOAD new field
	- [ ] Update UI
	- addCameraText > UPDATE_PERIPHERAL_CAMERA_NAME > UpdatePeripheralCameraName
## Repo

- [ ] PR FE to DEV
- [ ] PR FE to INT
- [ ] PR Client to DEV
- [ ] PR Client to INT

