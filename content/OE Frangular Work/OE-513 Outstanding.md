---
created: 2024-07-09T14:25
updated: 2024-08-23T10:17
---
## Outstanding

### Overview

![[OE-513 Outstanding Image.png]]


### Story points

![[OE-513 Story Points]]


[[OE-513 Languaging]]

### DEV

- [x] //TODO: MR: Add GetVideoEventConfigurationDetails back on DEV once DONE with this ✅ 2024-08-06
- [ ] UpdateAssetsConfigurationGroup: This method still uses proxies - replace
- [x] Spinners ✅ 2024-08-08
- [ ] Languaging
- [ ] Grid Ordering / Sort
- [ ] Timeout issues on API calls
- [ ] Activate menu for prod & UAT (MUCH **LATER**)
- [ ] Add in SelectionCriteria
	- AllowedOrigins: "https://mixconfigfrangularui.mixdevelopment.com", "https://mixconfigfrangularapi.mixdevelopment.com",

### PO questions

- [ ] PO: Should FW versions be shown and filtered for MESA only?
- [ ] Permission / Auth for loading Orgs, Groups, Sites, Assets (Add into API)
- [x] Is short asset Id within an org unique? I assume it is (so selecting checkbox accordingly) ✅ 2024-08-06
- [x] When **hovering** over info for unallocated... display the following help text:  (currently when clicking) ✅ 2024-08-08

### Test this

- [ ] Test the results for fetching unallocated against original page's result


### Branches

- Common:
	- INT: Config/MR/OE-497-Asset-List-Panel.24.8.INT.ORI
- API: 
	- DEV: ????
	- INT: ~~Config/MR/Feature/OE-496-CG-OE-497-Asset.INT.ORI~~
- Client:
	- INT: ~~Config/MR/OE-497-Asset-List-Panel.24.8.INT.ORI~~ ~~MOVED~~
	- INT: Config/MR/Feature/OE-482_ConfigGroupMultiselectMenu.INT
	- !! Nuget (current just local)
- FR API:
	- DEV: Config/MR/OE-497-Asset-List-Panel.24.9.DEV
	- ~~INT: Config/MR/OE-497-Asset-List-Panel.INT~~ ~~MOVED~~
	- INT: Config/Features/OE_API_INT
	- "ConfigApiUrl": "http://localhost/DynaMiX.DeviceConfig.Services.Api"
	- "SelectionCriteriaUrl": "https://selectioncriteria.mixdevelopment.com",
- FR UI:
	- DEV: Config/MR/Feature/OE-491-Asset-List-Panel.24.9.DEV.ORI
	- ~~INT: Config/MR/Feature/OE-491-Asset-List-Panel.INT~~
	- INT: Config/Features/OE_UI_INT
	- export const APIURL_DEV = "http://localhost:5000";

- UI:
	- DEV: ?
	- INT: Config/MR/Feature/OE-482_ConfigGroupMultiselectMenu.INT
- BE:
	- DEV: ?
	- INT: Config/MR/Feature/OE-482_ConfigGroupMultiselectMenu.INT
- DB:
	- DEV: ?
	- INT: Config/MR/Feature/OE-482_ConfigGroupMultiselectMenu.INT
