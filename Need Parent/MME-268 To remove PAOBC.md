---
created: 2025-02-12T12:02
updated: 2025-02-12T16:25
schema: |-
  {
   8928347298347923874928374
  }
---

- FE
	- Decommissioning (when delete PaOBC asset)
		- I recall this was an issue
	- Also Commissioning PaOBC...
	- Potentially when trying to compile...
		- It went here... DeviceConfigClient.MobileUnits.RequestMobileUnitConfigurationCompile
	- I'm just going to grab some text I see which is related, most likely
		- mobile device settings tab, we need to display the "Configuration status" for assets making use of the mobile phone device type
		- buttons regarding upload, compile, etc is influenced by this device
	- Resend SMS OBC
	- ? Change Mobile Phone
- BE
	- IT sends back info if you can Compile and Upload
	- PaOBC Thresholds
		- changeThresholdsTemplate.overSpeeding
		- changeThresholdsTemplate.overRevving
		- changeThresholdsTemplate.harshBraking
		- changeThresholdsTemplate.harshAcceleration
		- changeThresholdsTemplate.highEngineTemperature
		- changeThresholdsTemplate.harshCornering
	- Decommissioning
	- CommissioningClient.DecommissionByAssetId called in MyMiX.PaOBC.Commissioning.Management.Client from our code
	- RequestMobileUnitConfigurationCompile
	- Send SMS
	- Look for: isMobilePhone
	- ChangeMobileDevice
	- RemoveMobilePhone
	- GetSendDecommissioningErrorResult
- MiX.DeviceIntegration.Common
- DynaMiX.DeviceConfig
	- Used to have: 
		- Client: PaOBCProxy
		- Manager / logic: PaOBCMessageSender, PaOBCCommandSender, ...
		- Also had URLS to PaOBC
	- PaOBCDataCentre
	- PaOBCApiUrl
	- PaOBCCommissioningApiUrl
	- PaOBCConfigUploadApiUrl
	- paOBCProxy.SendDecommissioningRequest
	- 
- MiX.DeviceConfig.Api.Client

## Next round

MobileDevice.Phone (device id=-7688187356053930045)

-   New PaOBC CommandSender
-   Consume Client
-   Create MessageId
-   Save Message - default Pending
-   Transfer method to be used… CommandIdType.SendCommissioningRequest (106)
-   Add to **MiX Client** (overload for SendCommandToMobileUnit called "SendCommissioningRequest")

[DeviceConfiguration].[mobileunit].[AssetProperties]


[[PaOBC Potential Code]]

## Potential overview


![[MME-268 To remove PAOBC First try.png]]

```txt
My Claude question:
OK, if you consider the paths mentioned in the current file.... and you then consider the following.... how would you draw the chart then?

The FE (MiX.Fleet.UI) speak to the BE (Dynamix.BAckend). The BE often then calls an API (USed to be: DynaMix.DeviceConfig) it has now moved to (config.api). This in turn could speak to more services (Fleet.Services) or the Database (Database). The Common class (MiX.DevicceIntegration.Core) often has classes we share across repos. The client we often use to call our API is (MiX.DeviceConfig). The newest logic is the FR UI (MiX.Config.Frangular.UI), which is an angular UI we inject into the old FE via an iFRame. It speak to our API via the FR API (MiX.Config.Frangular.API) which in turn calls our client. I hope this clarifies a lot?
```


![[MME-268 To remove PAOBC Rough OVerview.png]]
