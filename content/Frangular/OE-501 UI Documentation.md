---
created: 2024-01-26T09:58
updated: 2024-01-29T10:19
---
## Overview

As part of OE-20, we are redoing the Configuration Groups page. It is becoming a multiselect configuration groups page. We have decided to implement this making use of "Frangular", a MiX internal name for writing a page in New Angular, and then pulling it into the OLD UI by making use of an iFrame.

Herewith the overview of the full OE-20 story.
For the UI section we will purely be looking into the Blue part of the image, Frangular UI and its sub items (UI Components).

![[OE-20 Planning.excalidraw]]

## Repo

The repo can be found here, I think for now the best would be to work off of the Integration branch.

[MiX.Config.Frangular.UI - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI)

The above was based off of Fleet's Operations Repo, as the Asset Search page was the closest to what I could see we needed.

https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.UI

## Development

- Do your development in Visual Studio Code (VSCode)
	- You can still make use of Visual Studio
- Pull the repo (above)
- Read the ReadMe file for a short setup explanation. [READ HERE](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI?path=/README.md).
- Build the project: 'npm run dev'
- You can locally test the UI stand-alone, usually with a browser by navigating to: 
	- Root url: http://localhost:4200/
	- Eg. to the demo url: http://localhost:4200/configuration-groups-multiselect
- If you want to test getting or sending data the **Frangular API** should also be running locally. Please also take note of the Frangular API's port number, in case you struggle connecting to it from the UI.

## Basic Frangular flowchart

![[OE-20 Frangular Seed App POC layout]]


## Basic examples

```C#
//Creating a component (Eg. Page) From the console in VSCode
ng generate component configgroups --skip-tests

//Routing to point to above component
//In this file... ..\src\app\app-routing.module.ts
import { ConfiggroupsComponent } from "./configgroups/configgroups.component";
const routes: Routes = [
  ...
  { path: 'configgroups', component: ConfiggroupsComponent }
];

//More to come...

```

## Highlevel Angular building blocks

This is purely for interest. NO need to know all of these parts.

![[Frangular New MiXFleet UI Component.excalidraw]]

## Future work needed

- [ ] Refactoring of production environments settings
- [ ] Build-Pipelines
- [ ] Enhance the Pull Request permission, etc