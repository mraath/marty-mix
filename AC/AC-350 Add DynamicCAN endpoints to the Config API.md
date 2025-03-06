Date: 2022-05-23 Time: 10:33
Status: #closed  
Friend: 
JIRA:AC-350
[AC-350 Add DynamicCAN endpoints to the Config API - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/AC-350)

# AC-350 Add DynamicCAN endpoints to the Config API

## Image

## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Client                  | API    | Common | DB     |
| ----------------------- | ------ | ------ | ------ |
| Local                   | 22.9   | 22.10  | 22.10  |
| NUGET loc               |        |        |        |
| > INT & Consume in test |        |        |        |
| xx                      | PR INT | PR INT | PR INT |

## Branch
Config/MR/Bug/AC-350AddDynamicCANendpointsToConfigAPI.22.10.INT.ORI
Config/MR/Bug/AC-350AddDynamicCANendpointsToConfigAPI.22.9.INT.ORI (NA)

## URL
- DEV: http://api.dcan.MiXdevelopment.com
- INT: https://dynamic-can-api.integration.mixtelematics.com

## TEST DATA
DSDEVCFGSQL01
3222089765699420885
WDB9066592S202912
4) Behind Instrument Cluster


## DB
[library].[GetAllLibraryParameterDescriptionsForSystemNames]
return
[ { "SystemName": "string", "Description": "string" } ]


## Register
public const string DynaMiXDynamicCanApiUrl = "DynaMiXDynamicCanApiUrl";
DICANClient.RegisterRepository(
					GetType().Namespace,
					SettingsProviderFactory.GetProvider(CoreConstants.ServiceName).GetString(CoreConstants.SettingNames.DynaMiXDynamicCanApiUrl));
				DependencyRegistry.Register(() => DICANClient.Logging);

## Nugets

MiX.DIConfig.DCAN.Client, Version=2022.5.24.1
MiX.DIConfig.DCAN.Dtos, Version=2022.5.24.1

## PARAMS

{ "ParameterList": [ "System.FM.CAN.LTSSI", "System.FM.CAN.RTSSI", "System.FM.CAN.PBRKS", "System.FM.CAN.HDLTS", "System.FM.CAN.FMODO", "System.ECMST", "System.CAN.FuelQuantity" ] }

## Zonika

Ok - so - ekt so paar vra / leiding nodig met AC-350

Ekt die basiese API klaar - wag nog met Caching tot ek weet wat ek gaan kry

MAIN probleem - kry heeltyd JSON null issues as ek die DynamicCAN roep - maar seker dis setup aan my kant

So wil net daai by jou hoor - hoef nie nou nie - gedink ek kan blindelings die client deel doen - wat anyways net die end-points roep - as ek die end-points tref werk die klient  

So dan kan ek na ek en jy gechat het die API finalise


## Env Issue
Failed to restore C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.HOS\DynaMiX.DeviceConfig.Services.DataProcessing.Outgoing.HOS.csproj (in 16 sec).

Failed to restore C:\Projects\DynaMiX.DeviceConfig\TestApp\DynaMiX.DeviceConfig.Services.DataProcessing.TestApp.csproj (in 15,98 sec).

Failed to restore C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay\DynaMiX.DeviceConfig.Services.DataProcessing.MessageReplay.csproj (in 15,75 sec).

Failed to restore C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.ConfigUI\DynaMiX.DeviceConfig.ConfigUI.csproj (in 15,49 sec).

Failed to restore C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M6K\DynaMiX.DeviceConfig.Services.DataProcessing.Incoming.M6K.csproj (in 14,58 sec).

## Learned
[[Caching]]

## Description

Add endpoints to the config API for the   
GetAvailableScriptsInfo, GetFilesForPartialVIN and GetParameterList calls in the DCAN client

- **GetAvailableScriptsInfo**:  There is a separate story to extend this call to return **3 additional fields**. Please use the updated entity when returning the values
      "Update the GetAvailableScriptsInfo Lambda to return the **Make, Model and Year** as found on the script entry record in the DynamoDB"
      GetAvailableScriptsInfoEntry(vin numbers)
      dynamic-can/scripts/scipts-by-vin-numbers (pass list(string) in header)
      public const string GetSciptsByVinNumbers = "dynamic-can/scripts/scipts-by-vin-numbers"

- **GetFilesForPartialVIN**:  This is a **straight** pass through for now
	GetScriptFilesForVIN (vin & installationprofile)
	dynamic-can/scripts/scipts-by-partial-vin/vin/{vin}/installation-profile/{installationProfile}
	public const string GetSciptsByPartialVinAndProfile = "dynamic-can/scripts/scipts-by-partial-vin/vin/{vin}/installation-profile/{installationProfile}";
	
- **GetParameterList:**  
	- This needs to **add** an additional **lookup for the Parameter display** name and 
	- some **caching** around that
	GetParameterListForVIN (vin & installationprofile)
	dynamic-can/parameters/vin/{vin}/installation-profile/{installationProfile}
	public const string GetParametersByVinAndProfile = "dynamic-can/parameters/vin/{vin}/installation-profile/{installationProfile}";
	
Notes:  
This should be done as a separate controller to allow it to be split out into a microservice in the future

MiX.DIConfig.DCAN.Client
https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MIX.DeviceIntegration.DynamicCAN

## Code sections

Assembly MiX.DeviceIntegration.Core, Version=2022.5.17.1
CoreConstants.SettingNames.DynaMiXDynamicCanApiUrl
DynaMiXDynamicCanApiUrl = "DynaMiXDynamicCanApiUrl"

## Files

## Resources

## Notes

