---
created: 2024-03-14T15:56
updated: 2024-07-22T10:31
---
## Overview

![[STM-1074 Overview.svg]]

## Code PRs to DEV showing the diff

- Core
	- New Action added to be consumed by the BE
	- [PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/99556?_a=files)
- BE 
	- Consumed new action and send it to FE via carrier. 
	- [PR](https://dev.azure.com/MiXTelematics/Common/_git/DynaMiX.Backend/pullrequest/99772)
	- [ ] **TODO**: Business logic as to WHEN this should be added to the group
- FE 
	- Added the new HTML action in the config groups
	- Added the new page to hold the iFrame, which calls the frangular UI
	- [PR](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/99773)
	- [ ] **TODO**: Icon needed from business for new config group action
- Frangular API
	- Pulled Shawn's HTML into our repo
	- [PR](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99385?_a=files)
	- [ ] **TODO**: Some styling to ensure the extra vertical scroller doesn't show


## Video Explanation

- [STM-1074 Basic setup for Frangular UI.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/Edn-QtmHhwdHie7dVX3PeS8BTuBPQFaHPuZ1IWzECl9OQg?e=thIsPq)
