---
created: 2025-04-23T16:09
updated: 2025-06-02T14:27
---
This comes from [[xxxxxxxxxxxxxxxxx]]

## Questions:

- [ ] What about the libraries?
	- [ ] Should they not come first?
	- [ ] ALL
		- [ ] No edit / Basic
- [ ] Config Templates?
- [ ] Asset Templates? << ALL THESE (investigation below)
	- [ ] 
- [ ] Then specifically
	- [ ] Events
	- [ ] Locations
	- [ ] Mobile Devices

## Investigating

### Config (Manage > Config > Templates)

- https://integration.mixtelematics.com/#/config-admin/templates
	- Events click: https://integration.mixtelematics.com/#/config-admin/templates/events
		- Event Template Click: <mark class="hltr-pink">(A)</mark> <mark class="hltr-red">(ii)</mark>  https://integration.mixtelematics.com/#/config-admin/templates/events/edit?id=245193282188643425&duplicate=0
	- Location Template Click: https://integration.mixtelematics.com/#/config-admin/templates/locations
		- Location Click: <mark class="hltr-green">(C)</mark> https://integration.mixtelematics.com/#/config-admin/templates/locations/edit?id=2650549531491560536&duplicate=0
	- Mobile Devices Click: https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices
		- Mobile Device Template Click: <mark class="hltr-blue">(B)</mark> https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/edit?id=-3267307515099219057
			- Mobile Device Name Click: <mark class="hltr-purple">(i)</mark> https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-720427755237063859
			- Line: Connection Click: (B2) <mark class="hltr-orange">(iii)</mark> https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-720427755237063859&lineId=7938934130935376309

### Asset (Config Group > Asset > Edit)

- https://integration.mixtelematics.com/#/config-admin/configuration-groups-multiselect
	- Asset click: https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events?assetId=1634286684147179520
		- Event template: ............
			- Event Click: <mark class="hltr-red">(ii)</mark> https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/events/edit?templateEventId=2983736699957985442&assetId=1634286684147179520
		- Mobile Device Templates click: https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device?assetId=1634286684147179520
			- Template: .............. Mobile Template
				- Mobile Device Name Click: <mark class="hltr-purple">(i)</mark> https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1634286684147179520
					- Features and settings
				- Line: Connection Click: <mark class="hltr-orange">(iii)</mark> https://integration.mixtelematics.com/#/config-admin/configuration-groups/asset/mobile-device/edit?assetId=1634286684147179520&lineId=401558247868188484
					- ... Select peripheral device (Parameter) (Features and settings)
					- [ ] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\AssetMobileDevicePeripheralEditTemplate.html

	- Event Template Click: <mark class="hltr-pink">(A)</mark> https://integration.mixtelematics.com/#/config-admin/templates/events/edit?id=245193282188643425&duplicate=0
		- Event template name
		- [ ] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\EventTemplateTemplate.html
			- Event Click: xxxxxxxxxxxx
		- [ ] ?? C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\EventDuplicateTemplateTemplate.html
			- Event Click: xxxxxxxxxxxx
	- Mobile Device Template Click: <mark class="hltr-blue">(B)</mark> https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/edit?id=-836221839103952129
		- Edit mobile device template
		- [ ] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplateTemplate.html
			- Mobile Device Name Click: https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-836221839103952129
				- Features and settings
				- Templates/ConfigAdmin/MobileDeviceTemplatePeripheralTemplate.html
				- C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\LogicalDeviceSettingsTemplate.html
				- C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplateTemplate.html
			- Line: Connection Click: (B2) https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-836221839103952129&lineId=5045108991270747233
				- ... Select peripheral device (Parameter) (Features and settings)
				- [ ] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplatePeripheralTemplate.html
	- Location Template Click: <mark class="hltr-green">(C)</mark> https://integration.mixtelematics.com/#/config-admin/templates/locations/edit?id=2650549531491560536&duplicate=0
		- Location template name
		- [ ] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\LocationTemplateTemplate.html
			- xxxxxxxxxxxxxxxx


## Use Roo Code

[[Roo Code Edit Templates Architect]]

[[ROO Prompt to get Rewrite Edit Templates]]

[[RooPlan2]]

[[RooPlan3]]

[[LocationEditPlan]]

[[EventEditPlan]]

[[EditMobileDevicePlan]]

## Trying to get to a solution

I have a question. Will it not be better to do the following. Start the rewrite from the bottom up. So first rewrite the smaller components, eg, parameters, conditions, etc. (like calibration templates and property-specific templates) Then maybe go up one level, the smaller templates being re-used by many, like the Peripherals, Parameters, Firmware, and CAN libraries. Then maybe work on specific areas... like first Locations (library, template, edit, asset edit) Then Events (library, template, edit, asset edit) The Mobile Device (library, template, edit, asset edit)

This is what I think we should do?

Maybe let me know what you think about this, but then also first show me a diagram how everything includes everything else

