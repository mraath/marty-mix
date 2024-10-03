---
created: 2024-07-09T14:25
updated: 2024-10-02T15:32
---
## Outstanding

### Overview

![[OE-20 Planning.excalidraw.png]]


### Story points

![[OE-513 Story Points]]


[[OE-513 Languaging]]

### DEV

- [x] //TODO: MR: Add GetVideoEventConfigurationDetails back on DEV once DONE with this ✅ 2024-08-06
- [ ] UpdateAssetsConfigurationGroup: This method still uses proxies - replace
- [x] Spinners ✅ 2024-08-08
- [ ] Languaging
- [ ] Languaging doesnt always change, eg. to En / Pig
- [ ] Grid Ordering / Sort
- [ ] Timeout issues on API calls
- [ ] Activate menu for prod & UAT (MUCH **LATER**)
- [x] Add in SelectionCriteria ✅ 2024-10-02
	- AllowedOrigins: "https://mixconfigfrangularui.mixdevelopment.com", "https://mixconfigfrangularapi.mixdevelopment.com",
- [ ] Authentication and Authorisation
	- [ ] Only show these actions when the user has access
	- [ ] Only show other actions when the user has 
	- [ ] Permissions and Authentication logic for loading Orgs, Groups, Sites, Assets has not been added. Is it OK to do this at a later stage?

### PO questions - OLD

- Handled somewhere else: PO: Should FW versions be shown and filtered for MESA only?
- Handled somewhere else: Permission / Auth for loading Orgs, Groups, Sites, Assets (Add into API)
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

## PO Questions

![[OE-513 PO Questions]]

## Testers Subbugs

![[OE-513 Sub bugs]]

