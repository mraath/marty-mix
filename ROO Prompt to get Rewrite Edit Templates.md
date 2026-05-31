---
wiki_ingested: 2026-05-28
created: 2025-06-02T09:54
updated: 2025-06-05T08:58
---
OK, please look at the previuos history. In short, I am busy rewriting the edit templates. I need to look at all the templates, how they are integrated into each other. If you basically look at the *template*.html files, you will get a good idea.

Here is a high level investigation I did.

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
					- [x] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\AssetMobileDevicePeripheralEditTemplate.html ✅ 2025-06-05

	- Event Template Click: <mark class="hltr-pink">(A)</mark> https://integration.mixtelematics.com/#/config-admin/templates/events/edit?id=245193282188643425&duplicate=0
		- Event template name
		- [x] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\EventTemplateTemplate.html ✅ 2025-06-05
			- Event Click: xxxxxxxxxxxx
		- [x] ?? C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\EventDuplicateTemplateTemplate.html ✅ 2025-06-05
			- Event Click: xxxxxxxxxxxx
	- Mobile Device Template Click: <mark class="hltr-blue">(B)</mark> https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/edit?id=-836221839103952129
		- Edit mobile device template
		- [x] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplateTemplate.html ✅ 2025-06-05
			- Mobile Device Name Click: https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-836221839103952129
				- Features and settings
				- Templates/ConfigAdmin/MobileDeviceTemplatePeripheralTemplate.html
				- C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\LogicalDeviceSettingsTemplate.html
				- C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplateTemplate.html
			- Line: Connection Click: (B2) https://integration.mixtelematics.com/#/config-admin/templates/mobile-devices/peripherals?templateId=-836221839103952129&lineId=5045108991270747233
				- ... Select peripheral device (Parameter) (Features and settings)
				- [x] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\MobileDeviceTemplatePeripheralTemplate.html ✅ 2025-06-05
	- Location Template Click: <mark class="hltr-green">(C)</mark> https://integration.mixtelematics.com/#/config-admin/templates/locations/edit?id=2650549531491560536&duplicate=0
		- Location template name
		- [x] C:\Projects\MiX.Fleet.UI\UI\Js\ConfigAdmin\Templates\LocationTemplateTemplate.html ✅ 2025-06-05
			- xxxxxxxxxxxxxxxx

My main focus would be on rewriting:
- Events
- Locations
- Mobile Devices

Basically each of them has:
- Libraries
- Templates
- Asset overrides

Here is a basic summary of what I previously got from you:

C:\Projects\marty-mix\content\Frangular Template Editing\Roo Code Edit Templates Architect.md

Please architect this so I can see all the templates, how they use each other, maybe a basic plan of how I can start rewriting these. Please also note that there are eg. under events, there are actions, parameters, etc.