---
created: 2024-03-08T12:22
updated: 2024-03-08T12:23
---
## Getting Shawn's code

- Open the seed app
- Find out from Shawn which branch to use
- For this story he said:
	- The html is on the **Seed repo** on the branch: **ui-video-event-config**  
		`https://mixtelematics.visualstudio.com/DynaMiX/_git/Seed`

## Pulling new HTML into our UI

- Checked out the Frangular UI repo (There is a document to get you up and running with this)
- Generate a new component to host the video event configuration page
	- ng generate component video-event-configuration --skip-tests
- Add in the routing, this helps the app know which url will open this new page
	- app-routing.module.ts
		- import { VideoEventConfigurationComponent } from "./video-event-configuration/video-event-configuration.component";
		-   { path: 'video-event-configuration', component: VideoEventConfigurationComponent }
- Add a way to access this new page, lets add it to the header menu, we could have done this somewhere else
	- header.component.html
		- 
		  ```html
		  <a href="/video-event-configuration" class="ml-3">Video event configuration</a>
		  ```
- The component will still be default, but just test if it works
	- ng serve
- Test result
	- ![[STM-1074 Video event configuration Menu shown.png]]
	- ![[STM-1074 Video event configuration Blank Page.png]]
- WORKS!!!!!
- Next I will copy over Shawn's html, etc. This can take some work... I won't keep perfect notes now
	- Copy to node_module
		- @mixtel 
	- Copied more files
	-  Moved code around
	- Changed a few uris
- Shawn's result
	- ![[STM-1074 Video event configuration Shawn's result.png]]
