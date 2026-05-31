---
wiki_ingested: 2026-05-28
created: 2024-10-01T09:54
updated: 2024-10-01T09:54
---
- The WiX tool is needed to bootstrap the tool into an EXE / executable
- There are a few [[PMU Overview | Older PMU notes]]
- I had to also install an older .net dev pack (4.5)

![[PMU Justus discussion Notes Phase 1.png]]

- Install WiX
- Code and Nuget updates
- try and build different projects in the solution by themselves - this sometimes helps... AFTER **WIX**

### ### Installing WiX

- Install the WiX tool outside of VS ??????????? 2019 version ?
- And then the VS extension?

After first opening the project within Visual Studio, you might see an error.
The reason for this is because you need to install the wix tools.
Close Visual Studio.
Next you need to install the WiX Installer extension and the WiX Build Extension (something like that) (version 3.11.x)
The main tool can be downloaded here:  
[https://wixtoolset.org/releases/](https://wixtoolset.org/releases/ "https://wixtoolset.org/releases/")
The Visual Studio Extension can be downloaded from here:
- OLD: [https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2019Extension](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2019Extension "https://marketplace.visualstudio.com/items?itemname=wixtoolset.wixtoolsetvisualstudio2019extension")
- [WiX v3 - Visual Studio 2022 Extension - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2022Extension "https://marketplace.visualstudio.com/items?itemname=wixtoolset.wixtoolsetvisualstudio2022extension")

Once both of these have been installed:  
1) Reload the project in Visual Studio  
2) Reload all projects

.Net version update?????
## Discussion

Yes i did and i installed the 2019 version. Ill try the TOOL again.. maybe something went wrong or i installed the wrong thing    
![[PMU More Notes Buil Succeeded.png]]


The Tool you installed is on the Release page of Wix ? I made a video while doing it

I still wanted to edit it

But let me upload it as is and send it to you ok cool thank you At the end of the video the WiX extension was still trying to install

I just re-installed it and then things started working

Also - try and build different projects in the solution by themselves - this sometimes helps... AFTER WIX Ok i think its the Wix install than that was not the right thing. [https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EQAAivVd139JjDxc4PBwM8ABit1YK81jCyMKh-ik1yZw4Q?e=KPD3kw](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EQAAivVd139JjDxc4PBwM8ABit1YK81jCyMKh-ik1yZw4Q?e=KPD3kw "https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/eqaaivvd139jjdxc4pbwm8abit1yk81jcymkh-ik1yzw4q?e=kpd3kw")

[WiX Issue.mkv](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/Documents/Videos/WiX%20Issue.mkv) LEt me know if the video opens

I am going to stop working now ok thank you.. the video did start playing.. Im downloading now to watch on the PC and free up my teams cheers - have a good eve Thanks again and enjoy your evening. I am also down to that last 5 errors now.. 

![[PMU More Notes Last 5 Errors.png]]

build succeeded Let me know if this helped at all Good morning, Yes where to find that version 3 helped, I also had an issue with where my nugets was pionting to that caused so many errors. The application can run but it cant connect to an org without the plug thingy magic connected to my pc. Can you confirm this? I also made a video on that one - not yet edited OK - maybe it will be good to edit that video for others devs trying to get this working MOST LIKELY it will need a plug thingi - yes Maybe breakpoint there and then force it to continue and see ![😄](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/grinningfacewithsmilingeyes/default/20_f.png "Grinning face with smiling eyes")  Glad that the video helped ok will see how i can chippo it to get it running,  YEeehaaa  ![😋](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/tongueout/default/50_f.png "Cheeky")I made the PMU WiX fix video MUCH shorter and added more steps

Please let me know if I missed something - only 4 mins

[PMU Fix WiX v3.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EVhxYdZDkz1DkAEaIPCNX_cBp6_HVTHq_6na0AYILhRNWw?e=hh4brF "https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/evhxydzdkz1dkaeaipcnx_cbp6_hvthq_6na0ayilhrnww?e=hh4brf")
[PMU Fix WiX v3.mp4](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/Documents/Videos/PMU%20Fix%20WiX%20v3.mp4) 
[[PMU Fix WiX v3]]
