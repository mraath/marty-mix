---
status: closed
date: 2022-10-25
comment: Release 22.17
priority: 3
---

Date: 2022-10-25 Time: 09:59
Parent:: xxxx
Friend:: [[2022-10-25]]
JIRA:SR-13904 

# SR-13904 GSM Modem Device Settings hidden on Mobile Device Template

## Next

- Look what the Template logic says when to show for asset level

## Investigate

### HTML debug

- Edit peripheral device (C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\) (**Template: MR FM38**)
	- <mark class="hltr-green">AssetMobileDevicePeripheralEditTemplate.html</mark>
		- ui:if="!lineId || (data.currentDevice.id && !controller.peripheralChanged)
		- lineid: has value (<mark class="hltr-red">??????????????</mark>)
		- currentDevice.Id has value
		- controller.peripheralChanged is false
		- !$scope.lineId || ($scope.data.currentDevice.id && !$scope.controller.peripheralChanged)
		- TRUE
	- <mark class="hltr-yellow">MobileDeviceTemplatePeripheralTemplate.html</mark>
		- ui:if="!lineId || (data.currentDevice.id && !controller.peripheralChanged)
		- lineid: has value (<mark class="hltr-red">this is the issue</mark>) NO - its not!!!!!!!!!!!! IT SHOULD SHOW due to the OR part being valid
		- currentDevice.Id has value
		- controller.peripheralChanged is false
		- !$scope.lineId || ($scope.data.currentDevice.id && !$scope.controller.peripheralChanged)
		- ???????????
	- <mark class="hltr-blue">PeripheralEditTemplate.html</mark>
	- PeripheralParameterEditTemplate.html
- DeviceSettingsTemplate.html
	- <mark class="hltr-green">AssetMobileDevicePeripheralEditTemplate.html:</mark>
	- MobileDeviceEditTemplate.html
	- <mark class="hltr-yellow">MobileDeviceTemplatePeripheralTemplate.html</mark>
	- PeripheralCreateTemplate.html
	- <mark class="hltr-blue">PeripheralEditTemplate.html</mark>
	- 


### Console ERROR

1) length
	1) ... ConfigAdmin Controllers MobileDeviceTemplatePeripheralController.ts
		1) line78,19: if (this._data.form.selectedPeripheralDevice.logicalDevices[0].rows.length > 0) {
2) description
3) canDoTacho

## Notes

- Asset Level
	- Edit peripheral device
	- GSM modem
		- S2 - GSM modem (Extended Device)
		- Select peripheral device
		- Device settings
- Mobile Device Templates
	- S2 - GSM Modem
	- Currently I cant see the above one :-D
	- ==!!! FM3617i==
- Configuration group
	- Mobile device templates -> S2 GSM Modem
	- S2 - GSM modem (Extended Device)
		- Edit peripheral device
		- Select peripheral device
		- <mark class="hltr-red">MISSING</mark> Device settings
		- Features and settings

- Fix for cameras were:

```html
<!--LogicalDeviceSettingsTemplate.html-->
<div ng-show="(!$controller.logicalDevices[0].cameraNames.any()) "> <!--/div>&& ($controller.logicalDevices[0].cameraNames.length == 0)">-->
<!--It was-->
<div ng-show="($controller.logicalDevices[0].cameraNames == null) "> <!--</div>&& ($controller.logicalDevices[0].cameraNames.length == 0)">--> 
```

## This wont work because

From what I can see in the logic the only reason it would hide is if:
-   there are no properties on the controller (VERY OLD CODE)   
- OR there is a line id (VERY OLD CODE)
- OR there is no current device id 
- OR the peripheral has changed (VERY OLD) <mark class="hltr-green">FALSE</mark>

Due to the above I will need to investigate further as this code hasn't changed in a while

	


## Image


## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| FE    |     |
| ----- | --- |
| 22.15 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-13904_GSMModemDeviceSettingsHiddenOnTemplate.22.15.ORI

## Learned

## Description
- Device settings missing
	- Manage -> Templates -> Mobile device templates -> Select Template -> S2 GSM Modem - Device settings not visible
	- Assets -> Select Asset -> Configuration group -> Mobile device templates -> S2 GSM Modem - Device settings are not visible
- Works on Asset Level
	- Assets -> Select Asset -> Configuration group -> Asset description -> Mobile device templates -> S2 GSM Modem - Device settings are visible
## Code sections

## Files

## Resources

## Notes

