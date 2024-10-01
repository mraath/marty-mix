---
created: 2024-10-01T08:50
updated: 2024-10-01T10:17
---

> [!info]
> This Project has been **passed around** between teams.
> Config Dev has done a lot on this project.
> We also change the **installation** and fixed some issues.
> There were a few hassles regarding **security key** or something like that.
> The HOS team also added some extra logic, I think around installation.

## Code base

> C:/Projects/DynaMiX.Backend/Utilities/PlugManagement/DynaMiX.PlugManagement.Standalone/

After first opening the project within Visual Studio, you might see an error.

The reason for this is because you need to install the wix tools.

Close Visual Studio.

## PMU Code Setup

### Installing WiX

- Fix up the WiX Tool
	- 1) WiX Tool (Installer), and
		- This puts WiX on your PC
		- It allows for command line execution
		- https://wixtoolset.org/releases/
			- Download WiX v3.14 (exe)
	- 2) WiX Extension (Bootstrapper)
		- It is a VS Extension
		- [WiX v3 - Visual Studio 2022 Extension - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=WixToolset.WixToolsetVisualStudio2022Extension)
			- Need VS 2022 version (WiX v3 VS 2022)

Once both of these have been installed:
1) Reload the project in Visual Studio
2) Reload all projects

### .Net version

- Install an older .net dev pack (4.7)
	- ![[PMU Justus discussion Notes Install Older dot Net.png]]
	- Install .Net 4.7 DEV Pack

### Nuget packages

- Upgrade MiX Core and other Nuget Packages
	- Ensure your Nuget Source is correct
	- ![[PMU Justus discussion Notes Nuget Source.png]]
	- Upgrade the Nugets

## Video how to fix WiX

This is summarised in the steps above.
If the below link is not available, let me search for it.
[PMU Fix WiX v3.mp4](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/EVhxYdZDkz1DkAEaIPCNX_cBp6_HVTHq_6na0AYILhRNWw?e=hh4brF)


