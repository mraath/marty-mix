---
created: 2024-10-24T15:22
updated: 2025-01-27T13:54
---
### Branches (This has changed as devs were added)

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
		- SHOULD BE: https://selectioncriteria.intss.mixdevelopment.com
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