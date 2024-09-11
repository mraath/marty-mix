---
created: 2024-09-10T16:13
updated: 2024-09-11T11:53
---
## Introduction

We often get the following issue, where the value we see in the Asset List page, is different from the value we see in the Diagnostics page.

![[Discrepancy between Asset List and Diagnostics values Example issue.png]]

The short answer for this is that they get **values** from **different places**.
If one is updated and the other is not, then the values will look different.

For this example I will look into [[SR-19107 IMSI has incorrect value]]

I will first investigate where the **Diagnostic** value comes from, usually from the **state table**.
After this I will show where the **Assets List** value comes from, usually from the **unit properties** OR  **property bag**.

## Diagnostics

![[Discrepancy between Asset List and Diagnostics values Diagnostics value.png]]

In short, this usually comes from the **State Table**

In this case the IMEI is received after an end-point is called:
In this example it was: https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/-2028909786913159060/2030626110269687202/diagnostics/MiX4000/mobiledevice/0
This calls the following Route in the 

**BE**:
**ROUTE**: GetDiagnosticsMobileDevice
**METHOD**: GetDiagnosticsMobileDevice
This builds up a whole carrier.
For the IMSI specifically it comes from:
mobileDevice?.IMSI
Which is from the DeviceConfigClient
			
**DeviceConfigClient**: MobileUnits.GetDiagnosticsMobileDeviceDetails
	
**API**:  
**CONTROLLER**: GetDiagnosticsMobileDeviceDetails
**MANAGER**: GetDiagnosticsMobileDeviceDetails
**REPO**: GetStatesForMobileUnit	
**DB**:
[state].[MobileUnitState_GetMultipleStateValuesForMobileUnit]
DeviceConfiguration.DataProcessing
[state].[MobileUnitState]
Property Id: 6851923534434202573

## Assets list

![[Discrepancy between Asset List and Diagnostics values Assets List.png]]

In short, this usually comes from the **unit properties** OR **property bag**

This calls some end-point like this:
https://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/groups/-2028909786913159060
This calls the following route.

**BE**:
	**AssetsListModule**:
	**ROUTE**: GET_ASSET_LIST_PAGE
	**METHOD**: **GetAssetListPage**
		Gets a list from AssetManager.GetAssetList (see below)
		Looping through each, it calls the **ToAssetListItem** extension method to build up the carrier
		(In this case it will handle: assetDetails.**AssetConfigDetails**.IMSI)
		The result comes from calling the below as a Task or Gateway... depending...
	**AssetManager**: 
		**GetAssetList**
			A LOT HAPPENS IN THIS METHOD
			(I will try to focus on ONE field only... IMSI)
			**GetAssetConfigDetailsList**: Gets a list of Config details, puts it into a dictionary, to be called for each assetdetails
				This will return a list of: AssetConfigDetails
				(For this example it contains the IMSI)
			This gets added to each: **assetDetails** as **AssetConfigDetails**
				(AssetDetails has an extension method (**ToAssetListItem**) to buid up the individual asset carrier for the list)
					A LOT happens in the extension
					(This will also for instance have the **IMSI**)
			This is also where we sometimes have to deal with the property bag
				For instance to get eg. to get Asset Status or TripStatus we will do something like this...
					AssetStatusBagConverter.GetTripStatus(statusItem.ToEntity())
					(See Property Bag below for a bit more info)

**Client**: GetMobileUnitPropertiesForAssetsList

**API**
	**MobileUnitControllerRoute**
	**MobileUnitController**:
	**MobileUnitManager**: GetMobileUnitPropertiesForAssetsList
	**REPO** 
	**MobileUnit**
	[mobileunit].[MobileUnit_GetMobileUnitPropertiesForAssetsList]

```sql
SELECT mu.[MobileUnitId], mup.[Value]
FROM [mobileunit].[MobileUnitProperties] mup WITH (NOLOCK)
INNER JOIN @MobileUnits mu ON mup.[MobileUnitKey] = mu.[MUKey]
where mup.[PropertyKey] = @UNIT_IMSI_KEY;
```


## Property Bag (Not relevant for IMSI, but for eg. Trip Status)

AssetStatusValues are received from **AssetsClient.GetStatusValuesAsync**
We then use the Property Bag to convert these values

AssetStatusBagConverter
	GetTripStatus(AssetStatusValues)
		string bag = values.VehicleStatus
		It pulls out a value, eg. var unitArmed = **BagSerialiser**.GetBool(bag, "UnitArmed", false);
	Convert(AssetStatusValues)
		e.g string bag = values.VehicleStatus
		assetStatus.DownloadScheduleId = BagSerialiser.GetInt(bag, "SchedID")
	Many more egs 😄
	
Use case... eg:
	GetDiagnosticsGPS > GetAssetStatus > propertybag


## CONCLUSION

Looking into the IMSI issue, we can see that: 
- the **Diagnostics** value comes from the **MobileUnitState** table, while
- the **Assets List** value comes from the **MobileUnitProperties** table

We will need to:
- ensure this is the **expected** behaviour
- see if the MobileUnitProperties is maybe not **updated** when it should be.

## Maybe Related

[[FE-1350 Diagnostics Modal GPS Status]]
