---
created: 2024-05-17T09:23
updated: 2024-05-17T11:43
---
## Introduction to moving Shuan's wireframe

The following will explain what I did to get the story ready with static info, in order for the Dev to take over and add the actual logic.
I did the basics to get Shuan’s wireframe into our new Frangular UI, and then Pallavi took over to hook up all the other moving parts.  
  
I created the next few parts:  
- BE: Send down an action to go to the new page (Might hardcode this on the UI for now?)  
- FE: Ensure the FE action opens the iFrame, which will call the NEW UI  
- NEW UI: Make use of Shawn’s HTML

The separate pdf is available here:
[STM-1074 Handover to Pallavi.pdf](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/Documents/Microsoft%20Teams%20Chat%20Files/STM-1074%20Handover%20to%20Pallavi.pdf)

[[STM-1074 Handover to Pallavi]]

Herewith the video explanation of the same.
[STM-1074 Basic setup for Frangular UI.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/Edn-QtmHhwdHie7dVX3PeS8BTuBPQFaHPuZ1IWzECl9OQg?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=lgSUqq)

## After moving the wireframe into our component

The new UI now incorporates Shawn’s HTML.  
NO LOGIC has been added, just the HTML.

![[STM-1074 Video event configuration Moving Shuans html to our component Wireframe.png|600]]

Need NEW UI with Shawn's HTML  
- video-event-configuration  
- [PR into INT](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99384 "https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99384")  
- [PR into DEV](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99385 "https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/99385")

 [[STM-1074 More in-depth Steps to pull Shawn's wireframe in]]

I added an action on the BE
This was used in the FE
Next, I will just build up the iFrame and add an action to show the new page.

## Moving parts done

Currently, all the moving parts are there. Not everything has been fleshed out. It is more of a framework for Pallavi to get going.  
  
Herewith the menu item:
![[STM-1074 Video event configuration Moving Shuans html to our component Menu item.png|300]]

Herewith is the screen that opens (still needs a bit of styling)

![[STM-1074 Video event configuration Moving Shuans html to our component Component screenshot.png|600]]

This was handed over to Pallavi