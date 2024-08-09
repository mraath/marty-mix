---
created: 2022-07-15T16:27
updated: 2024-08-09T08:24
---
[[Frangular Minified]]

## Frangular

- [[Fleet]] team started the seed apps.

Writing our UI elements to work easier:
- New Angular
- Potential API microservices

Old code: Replace with an [[iFrame]]
New code: Make use of Frangular

## Benefits

- Lightweight
- Can use VS Code
- UI: can view that page directly
- Future ... microservices
- Future... Running in Containers? Docker

## Help tools

Fleet has a Seed project: [Seed - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DynaMiX/_git/Seed)
We will clone it for each of our sections.
We will then write that part in new angular and cleaner code.
The old page will become an [[iFrame]]

## Video
Herewith a video where this was explained: [Recordings - OneDrive (sharepoint.com)](https://mixtelematics-my.sharepoint.com/personal/rudolf_dutoit_mixtelematics_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Frudolf%5Fdutoit%5Fmixtelematics%5Fcom%2FDocuments%2FRecordings%2FFrangular%2D20220204%5F143258%2DMeeting%20Recording%2Emp4&parent=%2Fpersonal%2Frudolf%5Fdutoit%5Fmixtelematics%5Fcom%2FDocuments%2FRecordings)

## Image

![[Frangular New MiXFleet UI.png]]

## The basic Angular building blocks

![[Frangular New MiXFleet UI Component.excalidraw.png]]


## Chat with Chad:

- Four main splits
	- MiXFleet UI changes
	- DynaMiX Backend changes
	- the new frangular UI
	- the new frangular API

- Eg. For the operations module that we have in DynaMiX.
	- [Fleet.Services.Operations.API - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.API "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.api")
	- [Fleet.Services.Operations.UI - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/Fleet/_git/Fleet.Services.Operations.UI "https://mixtelematics.visualstudio.com/fleet/_git/fleet.services.operations.ui")
	- It is probably the first frangular stuff that we did.
	- There are other examples like FleetAdmin UI and API etc. They all live in the same section on azure.

## Our use-case overview

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw.png]]

## Dissecting the new logic

![[Frangular EG Dissecting Fleet UI.excalidraw.png]]

## Creating Config Frangular Codebase

- [[OE-20 Seed app - HELLO WORLD]]

## Frangular flowchart

![[OE-20 Frangular Seed App POC layout.png]]

## Current Status: POC

![[OE-20 Seed app - HELLO WORLD#Current Status of POP]]
- Frangular UI Viewing: http://localhost:4200/configuration-groups-multiselect
- MiXFleey UI Consuming the Frangular UI: http://localhost/MiXFleet.UI/#/config-admin/configuration-groups-multiselect

## Next steps

- Clean up two repos
- Chat with Zonika re best way forward
- Start with stories (Some quicker than we thought)
