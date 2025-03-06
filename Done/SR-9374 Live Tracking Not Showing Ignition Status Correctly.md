# SR-9374 Live Tracking Not Showing Ignition Status Correctly

  API | Local
  
  Config/MR/Bug/SR-9374_IgnitionStateChangeImmediate.21.17.ORI
  
  ?? SR-10115
  
PR for INT to remove Debug logging: [https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/64329](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/64329)

  
  Event message received: 32510 for Vehicle Id 777

  Event message received: {0} for Vehicle Id {1}
  Event Timestamp: {JsonConvert.SerializeObject(dsiEvent)}
  ----
  C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Services.Fm.ActiveMessageProcessor\Processors\IgnitionStateProcessor.cs


	1) Live tracking > Time in ignition
   	- Livetracking.ts
   	- field: 'timeInIgnition'
     	-  BE
     	-  IgnitionStatus = status.IgnitionStatus.GetDescription
     	-  TimeInIgnition = status.IgnitionStatus == IgnitionStatus.On ? (timeNowInAssetStorageTimeZone - status.StatusDate.DateTime).ToHoursMinutesSecondsString() : string.Empty
     	-  var timeNowInAssetStorageTimeZone = TimeZoneInfo.ConvertTime(ZonedDateTime.UtcNow.DateTime, TimeZoneInfo.Utc, status.StatusDate.TimeZone);
        	-  TrackingManager.GetIgnitionStatusForAssetsByGroupId
        	-  TrackingManager.GetIgnitionStatusForAssetsAssetIds
           	-  DeviceStateProxy.GetIgnitionStatesForMobileUnits
              	-  DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel
                 	-  GetDeviceStatesForMobileUnits(mobileUnitIds, LogicalDevices.ALL_MOBILE_UNITS, Properties.IGNITION_STATE_CHANGE
                 	-  IGNITION_STATE_CHANGE = 6401396132085856906

	2) General Status Information > Vehicle Mode > In trip
   	- asset-diagnostics.html
   	-  generalStatusInfo.vehicleMode| translate }} : {{ generalStatusInfo.vehicleTimeInMode
      	-  status.TripStatus
      	-  status.TimeInMode
      	-  asd.AssetStatus
      	-  asd = AssetsManager.GetAssetDiagnosticInfo
         	-  asd.AssetStatus = AssetStatusBagConverter.Convert(statusValues, orgId);
            	-  statusValues = fleetStatusValues.ToEntity
               	-  AssetsClient.GetStatusValuesAsync
               	-  BagSerialiser.GetBool(bag, "UnitArmed", false
  
   	-  generalStatusInfoG52.vehicleMode| translate }} : {{ generalStatusInfoG52.vehicleTimeInMode 
   	-  generalStatusInfoRemora.vehicleMode| translate }} : {{ generalStatusInfoRemora.vehicleTimeInMode 
   	-  generalStatusInfoOyster.vehicleMode| translate }} : {{ generalStatusInfoOyster.vehicleTimeInMode 
   	-  generalStatusInfoYabby.vehicleMode| translate }} : {{ generalStatusInfoYabby.vehicleTimeInMode 
   	-  
