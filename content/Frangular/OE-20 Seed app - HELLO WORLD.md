---
created: 2023-09-01T08:15
updated: 2024-05-14T09:20
---

## Small POC app

- Learn from: [[OE-20 NA POC Write a small App]]

## Things needed

### Branch

- Config/MR/POC/OE-20_Frangular.INT.ORI
- NA: Config/MR/Feature/OE-20 Frangular Multi Select Configuration Group
- MiX.ConfigInternal.Api.Client.2024.1.20231204.1-_alpha

### OLD BE

- Menu Item
	- ConfigAdmin - Added a menulink
- [x] Language this ✅ 2024-01-26

### OLD FE

- config.js
	- var angularNextConfigUrl = "http://localhost:5001";
	- var operationsApiUrl = "http://localhost:5013"; //TODO: MR: Replace
	- [x] Transforms needed ✅ 2024-01-26
- Configuration.ts
	- angularNextConfigUrl
- iFrame Page
	- ConfigGroupsMultiselectTemplate.html
	- ConfigGroupsMultiselectController.ts
	- Routes.ts
	- ConfigGroupsMultiselectLanding: "/config-admin/configuration-groups-multiselect";
	- controllerName: 'configGroupsMultiselect';
- Values for iFrame
	- iframeName: string = "iframeConfigGroupsMultiselectHost";
	- iframeUrl: string = angularNextOperationsUrl + "/asset-search"; //TODO: MR: Point to Frangular url
	- channelName: string = "configGroupsMultiselectChannel";
- Call Frangular UI
- [x] Language all of this ✅ 2024-01-26
- [x] Discovered: Add Config group, Edit Config Group... other existing logic that needs to be ported ✅ 2024-01-26

### Frangular UI

- file:///C:/Projects/Seed
- Router needed
	- app-routing.module.ts
	- configgroups.component.ts
	- configgroups.component.html
	- api.service.ts
	- app.module.ts
	- ui.module.ts
	- app.component.html
- Basic Page
- Call to API
- [x] Language all of this ✅ 2024-01-26
- [x] Add all smarter ways of doing things as enhancements later or start slower now? ✅ 2024-01-26

### Frangular API

- Made some setting changes
- Wasted a day
- Chad helped me do THIS which caused things to work
	- ![[Seed app - HELLO WORLD Important Frangular API Selection.png]]
- Add a simple Back-End call
- Call from Frangular UI
- Use results in Frangular UI
- [x] Fleet also uses lambdas ✅ 2024-01-26

### Maybe to be excluded for now

- Microservices
- Containers / Docker

## HOWTO: UI Steps Taken before

- Console:
	- ng generate component configgroups --skip-tests
	- ng generate component kendo --skip-tests
- FE:
	- In the app-routing.module.ts
	- Next I will add a small control which calls something on our API
	- Then I will locally try to add this into the existing FE within the iFrame
```c#
//..\Seed\src\app\app-routing.module.ts

import { ConfiggroupsComponent } from "./configgroups/configgroups.component";
const routes: Routes = [
  ...
  { path: 'configgroups', component: ConfiggroupsComponent }
];
```


## Current Status of POP

![[OE-20 Seed app - HELLO WORLD Part 3.png]]
