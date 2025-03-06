Parent::[[AC-78]]

# AC-248 Default Configuration Not just Track & Trace

  BE | local | DEV | xx (nuget)
  DB
  COMMON | local | INT | DEV

## Commit details

## AC Cleanup Script

![[AC Cleanup Script]]

### FE
Nothing

### BE
BE: Files touched

Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\ConfigAdminConverters.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\DefaultTemplateInfo.cs	Add / Deleted
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\IDeviceModel.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\LogicalDevice.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MIX4000Model.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\MobileDeviceHelper.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\PropertyValue.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateResult.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs	Edit
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs	Edit
Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\MobileDeviceTemplateManager.cs	Edit
Logic\DynaMiX.Logic\DynaMiX.Logic.csproj	Edit
API\DynaMiX.API\web.config	Edit
Common\DynaMiX.Common\ConfigAdmin\ConfigAdminSettings.cs	Edit
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryFirmwareManager.cs	Edit
Logic\DynaMiX.Logic\ConfigAdmin\TemplateLevel\EventTemplateManager.cs	Edit
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\DefaultTemplateInfo.cs	Delete
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\DeviceDetail.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\DeviceFactory.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\DefaultTemplateOverrides\PeripheralDevice.cs	Add
Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\IDefaultTemplateResult.cs	Add
API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs	Edit
Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs	Edit
Data\DynaMiX.Data\ConfigAdmin\Mapping\DefinitionLevel\DefinitionMobileDeviceMap.cs	Add
Data\DynaMiX.Data\ConfigAdmin\Mapping\LibraryLevel\LibraryDeviceMap.cs	Add
Data\DynaMiX.Data\ConfigAdmin\Mapping\LibraryLevel\LibraryLibraryMap.cs	Add
Data\DynaMiX.Data\ConfigAdmin\Mapping\TemplateLevel\TemplateMobileDeviceTemplateMap.cs	Add
Data\DynaMiX.Data\DynaMiX.Data.csproj	Edit
Entities\DynaMiX.Entities\ConfigAdmin\DefinitionLevel\DefinitionMobileDevice.cs	Add
Entities\DynaMiX.Entities\ConfigAdmin\LibraryLevel\LibraryDevice.cs	Add
Entities\DynaMiX.Entities\ConfigAdmin\LibraryLevel\LibraryLibrary.cs	Add
Entities\DynaMiX.Entities\ConfigAdmin\TemplateLevel\TemplateMobileDeviceTemplate.cs	Add
Entities\DynaMiX.Entities\DynaMiX.Entities.csproj	Edit
Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs	Edit






### DB
AC-266 Rear door resulted in issues for MiX4k
DevicesData.xml (New logical)


## More

  - MR
	  - Config/MR/Feature/AC-248_Default_Configuration_logical.21.14.INT_ORI
	  - (NA) ac-266
  - Justus
	  - ac-257
	  - ac-163
	  - 

  DEFAULT_CONFIGURATION

  ConfigConstants.LogicalDevices.DEFAULT_CONFIGURATION
  ConfigConstants.LogicalDevices.TRACK_AND_TRACE

  ```xml
  <device id="-1588804249563418712" type="130" systemName="System.Logical.DefaultConfiguration" legacyId="-667000">
		<logical label="Default Configuration" uisortorder="67000" />
		<dependencies>
			<dependency id="-6958420740236099092" parentId="6183256567829462590" type="1" autoConnect="1" info="MobileDevice.MiX4000" />
		</dependencies>
	</device>
  ```


## Notes

- AC-4
	- cloned AC-149
	- cloned AC-163 (SPIKE)
	- cloned AC-78
		- XML
			-   **Library: Peripheral Settings.** ([~~AC-254~~](https://jira.mixtelematics.com/browse/AC-254 "Settings: XML: Self-Install CAN - Default Configuration: Library: Peripheral Settings."))
			-   **Library: Setup Mobile Device Template Settings.** ([~~AC-255~~](https://jira.mixtelematics.com/browse/AC-255 "Settings: XML: Self-Install CAN - Default Configuration: Library: Mobile Device Template Settings"))
			-   **Library: Setup Event Template Settings.** ([~~AC-256~~](https://jira.mixtelematics.com/browse/AC-256 "Settings: XML: Self-Install CAN - Default Configuration: Library: Event Template Settings"))
		- BE Logic
			-   **Logic: Not just Track & Trace.** ([~~AC-248~~](https://jira.mixtelematics.com/browse/AC-248 "BE: Self-Install CAN - Default Configuration: Not just Track & Trace"))  
			    Currently, it only happens for track and trace as well as beacon.   
			    We should open this up to MiX4000 and in future more device types.
			-   **Logic: Connect Lines.** ([~~AC-249~~](https://jira.mixtelematics.com/browse/AC-249 "BE: Self-Install CAN - Default Configuration: Connect Lines"))  
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
			-   **Logic: Missing Event Template Info.** ([~~AC-252~~](https://jira.mixtelematics.com/browse/AC-252 "BE: Self-Install CAN - Default Configuration: Missing Event Template Info"))  
			    We will need to ensure all of these are handled in the code.
		- Database Scripts
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
		- Testing
			- -   **Regression Test Make Available.** ([~~AC-253~~](https://jira.mixtelematics.com/browse/AC-253 "Testing: Self-Install CAN - Default Configuration: Regression Test Make Available"))  
			    Seeing the BE code to make devices available will be changed.   
			    We need to test a few devices just to ensure it still works as expected. This might take a bit of time.
	- [MIX3K-8](https://jira.mixtelematics.com/browse/MIX3K-8) DI Config: Create new mobile device for MiX3000