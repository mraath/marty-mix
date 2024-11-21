---
created: 2024-03-15T10:14
updated: 2024-11-19T15:04
---
## Video how to fix WiX

[PMU Fix WiX v3.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EVhxYdZDkz1DkAEaIPCNX_cBp6_HVTHq_6na0AYILhRNWw?e=hh4brF)
If not available, please give me a shout.

## Installing WiX

After first opening the project within Visual Studio, you might see an error.

The reason for this is because you need to install the wix tools.

Close Visual Studio.

Next you need to install the WiX Installer extension and the WiX Build Extension (something like that) (version 3.11.x)

### Main WiX tool

1) The main tool can be downloaded here:
https://wixtoolset.org/releases/

### WiX Extension

2) The Visual Studio Extension can be downloaded from here:
- [WiX v3 - Visual Studio 2022 Extension - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2022Extension)

Once both of these have been installed:
1) Reload the project in Visual Studio
2) Reload all projects

### .Net version

.Net version update?????
- Future video

### Nuget packages

- Core and other Nuget Packages
- We had an error like the below
![[PMU More Notes Last 5 Errors.png]]
- In order to fix this
	- Check the nuget references in the UI project
	- The reference error icon was displayed
![[PMU Fix WiX v3 Reference error icon.png|250]]
- In order to resolve this
	- Just right-click and delete this
	- Then in the Nuget Management, re-install it from the Browse tab

## Signtool issue

After this everything should be working fine.

When I built it, I started getting a Signtool issue:
![[PMU Fix WiX v3 Signtool issue.png]]
I had a look at the mentioned directory and in my case this file does exist.
This is most likely (as the error shows) and issue with the signing certificate not being found.
The tool is in the following directory on my PC: C:\Program Files (x86)\Microsoft SDKs\ClickOnce\SignTool
- [ ] The fix will be done and documented in future

## OLD Non valid links

OLD: https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2019Extension
