---
created: 2024-01-26T08:49
updated: 2024-07-22T10:02
---
## Overview

As part of OE-20, we are redoing the Configuration Groups page. It is becoming a multiselect configuration groups page. We have decided to implement this making use of "Frangular", a MiX internal name for writing a page in New Angular, and then pulling it into the OLD UI by making use of an iFrame.

Herewith the overview of the full OE-20 story.
For the API section we will purely be looking into the Green part of the image, Frangular API and its sub items (methods in the new API). IF time is straining we could call our current client methods from the new API Managers. We need to consider internal, vs public methods as per a comment made by Jeremy and later pointed to by Zeshan.

![[marty-mix/content/Frangular/OE-20 Planning.excalidraw]]


## Repo

The repo can be found here, I think for now the best would be to work off of the Integration branch.

[MiX.Config.Frangular.API - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API)

## Development

- Pull the repo
- Do development in Visual Studio
- Run the Project.API directly
- ![[Seed app - HELLO WORLD Important Frangular API Selection.png]]
- A command window and swagger page will open

## Future work needed

- [ ] Refactoring of production environments settings
- [ ] Build-Pipelines
- [ ] Enhance the Pull Request permission, etc