---
created: 2022-07-15T16:27
updated: 2024-10-02T13:22
---
# AC-163 SPIKE CAN Config Group

## Image

![[Pasted image 20221107141741.png]]


## From Story

From what I can see these are the potential stories that could come out of the SPIKE.  
I have colour coded the story (on the right) to be easily traceable to the diagram position.

-   Settings (XML):  
    Do these first, as the findings here could influence how we handle the rest of the stories.  
    The items below come from what I could see from the SPIKE and EXCEL spreadsheet.  
    These libraries will need to be set up in order to get the device and event templates' info.  
    As MiX4000 already exists, but it has no default templates, some of this might already exist, but most likely not all of it.
    -   **Library: Peripheral Settings.** ([~~AC-254~~](https://jira.mixtelematics.com/browse/AC-254 "Settings: XML: Self-Install CAN - Default Configuration: Library: Peripheral Settings."))
    -   **Library: Setup Mobile Device Template Settings.** ([~~AC-255~~](https://jira.mixtelematics.com/browse/AC-255 "Settings: XML: Self-Install CAN - Default Configuration: Library: Mobile Device Template Settings"))
    -   **Library: Setup Event Template Settings.** ([~~AC-256~~](https://jira.mixtelematics.com/browse/AC-256 "Settings: XML: Self-Install CAN - Default Configuration: Library: Event Template Settings"))

-   BE Logic:
    -   **Logic: Not just Track & Trace.** ([~~AC-248~~](https://jira.mixtelematics.com/browse/AC-248 "BE: Self-Install CAN - Default Configuration: Not just Track & Trace"))  
        Currently, it only happens for track and trace as well as beacon.   
        We should open this up to MiX4000 and in future more device types.
    -   **Logic: Connect Lines.** ([~~AC-249~~](https://jira.mixtelematics.com/browse/AC-249 "BE: Self-Install CAN - Default Configuration: Connect Lines"))  
        There is already logic for this, however, it might be missing some autoconnect parts due to eg. more than one CAN script being available.   
        So we might need to specify the defaults to use, based on device type.  
        Currently, it seems to use the first available option.
    -   **Logic: Additional Events.** ([~~AC-265~~](https://jira.mixtelematics.com/browse/AC-265 "BE: Self-Install CAN - Default Configuration: Additional Event Changes"))  
        We have found that some of the events specified in the Excel spreadsheet is not part of MiX4000.  
        These will be handled in code. Basically we will add them as we will do for connecting lines to specific peripherals.
    -   **Logic: Missing Create Templates Code.** ([~~AC-250~~](https://jira.mixtelematics.com/browse/AC-250 "BE: Self-Install CAN - Default Configuration: Missing Create Templates Code"))  
        There might be code required in the creation of the mobile device template.   
        It might need little work for the event template.   
        The config group template should most likely work as-is.
    -   **Logic: Missing Get Device Template Info.** ([~~AC-251~~](https://jira.mixtelematics.com/browse/AC-251 "BE: Self-Install CAN - Default Configuration: Missing Get Device Template Info"))  
        There is already logic for this, however, in the Excel spreadsheet, there was a lot of information.   
        It might be that we will need to cater for logic here, to incorporate any new properties or fields not previously considered.
    -   **Logic: Missing Event Template Info.** ([~~AC-252~~](https://jira.mixtelematics.com/browse/AC-252 "BE: Self-Install CAN - Default Configuration: Missing Event Template Info"))  
        There is already logic to do this, however, the Excel spreadsheet shows a lot of actions, conditions and parameters.   
        We will need to ensure all of these are handled in the code.

-   Database Scripts:  
    Do these stories last, as by this point we will know a lot more as to what needs to be done.  
    This will be used when the Organisation already has MiX4000 made available.  
    For these Organisations, the default templates will need to be retro-fitted.  
    The best likely way to do this would be DB Scripts, which can be run as post-deployment scripts.  
    These scripts could potentially be very involved, as it would need to duplicate the logic currently creating the templates.  
    Herewith the scripts I think would be necessary.
    -   **Script: Get Device Template Info.** ([~~AC-260~~](https://jira.mixtelematics.com/browse/AC-260 "DB Script: Self-Install CAN - Default Configuration: Library: Get Device Template Info"))  
        This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    -   **Script: Get Event Template Info.** ([~~AC-261~~](https://jira.mixtelematics.com/browse/AC-261 "DB Script: Self-Install CAN - Default Configuration: Library: Get Event Template Info"))  
        This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    -   **Script: Connect Lines.** ([~~AC-262~~](https://jira.mixtelematics.com/browse/AC-262 "DB Script: Self-Install CAN - Default Configuration: Library: Connect Lines"))  
        This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.**
    -   **Script: Create Mobile Device Template.** ([~~AC-257~~](https://jira.mixtelematics.com/browse/AC-257 "DB Script: Self-Install CAN - Default Configuration: Library: Create Mobile Device Template"))  
        This can only be done after ([~~AC-260~~](https://jira.mixtelematics.com/browse/AC-260 "DB Script: Self-Install CAN - Default Configuration: Library: Get Device Template Info") and [~~AC-262~~](https://jira.mixtelematics.com/browse/AC-262 "DB Script: Self-Install CAN - Default Configuration: Library: Connect Lines"))  
        This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    -   **Script: Create Event Template.** ([~~AC-258~~](https://jira.mixtelematics.com/browse/AC-258 "DB Script: Self-Install CAN - Default Configuration: Library: Create Event Template"))  
        This can only be done after ([~~AC-261~~](https://jira.mixtelematics.com/browse/AC-261 "DB Script: Self-Install CAN - Default Configuration: Library: Get Event Template Info"))  
        This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    -   **Script: Create Config Group.** ([~~AC-259~~](https://jira.mixtelematics.com/browse/AC-259 "DB Script: Self-Install CAN - Default Configuration: Library: Create Config Group"))  
        This can only be done after ([~~AC-257~~](https://jira.mixtelematics.com/browse/AC-257 "DB Script: Self-Install CAN - Default Configuration: Library: Create Mobile Device Template") and [~~AC-258~~](https://jira.mixtelematics.com/browse/AC-258 "DB Script: Self-Install CAN - Default Configuration: Library: Create Event Template"))  
        This will duplicate the existing logic as a stored proc.
    -   **Script: Post Deployment Scripts.** ([~~AC-263~~](https://jira.mixtelematics.com/browse/AC-263 "DB Script: Self-Install CAN - Default Configuration: Library: Scripts ** ONCE OFF"))  
        This can only be done after ([~~AC-259~~](https://jira.mixtelematics.com/browse/AC-259 "DB Script: Self-Install CAN - Default Configuration: Library: Create Config Group"))  
        This will be used to run the above scripts post-deployment.

-   Testing:
    -   **Regression Test Make Available.** ([~~AC-253~~](https://jira.mixtelematics.com/browse/AC-253 "Testing: Self-Install CAN - Default Configuration: Regression Test Make Available"))  
        Seeing the BE code to make devices available will be changed.   
        We need to test a few devices just to ensure it still works as expected. This might take a bit of time.

## Other

![](AC-163_MiX4000_DefaultConfigGroup.png)
![](AC-163_FlowChart.png.md)


  -BE
    C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs
    MakeAvailableForLibrary


  Mobile device library

  DynaMiX.DeviceConfig.Services.API.Client.Proxies.LibraryLevel
    MakeMobileDeviceAvailable

  ...\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs
    MakeLibraryMobileDeviceAvaialble

  Conclusion:

  Please view the image below:

  xxxxxxxx

  From what I can see these are the potential stories that could come out of the SPIKE.
  I have colour coded the story (on the right) to be easily traceable to the diagram position.

  -  Database Scripts:
    This will be used when the Organisation already has MiX4000 made available.
    For these Organisations, the default templates will need to be retro-fitted.
    The best likely way to do this would be DB Scripts, which can be run as post-deployment scripts.
    These scripts could potentially be very involved, as it would need to duplicate the logic currently creating the templates.
    Herewith the scripts I think would be necessary.
    * Script: Create Mobile Device Template. 
    This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    * Script: Create Event Template. 
    This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    * Script: Create Config Group. 
    This will duplicate the existing logic as a stored proc.
    * Script: Get Device Template Info. 
    This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    * Script: Get Event Template Info. 
    This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    * Script: Connect Lines. 
    This will duplicate the existing logic as a stored proc. There MIGHT be some new logic needed.
    * Script: Post Deployment Scripts. 
    This will be used to run the above scripts post deployment.

  -  Settings (XML):
    The items below comes from what I could see from the SPIKE and EXCEL spreadsheet.
    These libraries will need to be set up in order to get the device and event templates' info.
    As MiX4000 already exists, but it has no default templates, some of this might already exist, but most likely not all of it.
    * Library: Peripheral Settings.
    * Library: Setup Mobile Device Template Settings.
    * Library: Setup Event Template Settings.

  -  BE Logic:
    * Logic: Not just Track & Trace. 
    Currently it only happens for track and trace as well as beacon. We should open this up to MiX4000 and in future more device types.
    * Logic: Connect Lines. 
    There is already logic for this, however, it might be missing some autoconnect parts due to eg. more than one CAN script being available. So we might need to specify the defaults to use, based on device type. Currently it seems to use the first available option.
    * Logic: Missing Create Templates Code. 
    There might be code required in the creation of the mobile device template. It might need little work for the event template. The config group template should most likely work as is.
    * Logic: Missing Get Device Template Info. 
    There is already logic for this, however, in the Excel spreadsheet there was a lot of information. It might be that we will need to cater for logic here, to incorporate any new properties or fields not previously considered.
    * Logic: Missing Event Template Info. 
    There is already logic to do this, however, the Excel spreadsheet shows a lot of actions, conditions and parameters. We will need to ensure all of these are handled in the code.

  -  Testing:
    * Regression Test [[Make Available]]. 
    Seeing the BE code to make devices available will be changed. We need to test a few devices just to ensure it still still works as expected. This might take a bit of time.

