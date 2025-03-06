# CONFIG-2848 ODO and Engine Hours different on diagnostics modal and assets list

SELECT TOP (1000) [MobileUnitStateKey]
      ,[MobileUnitId]
      ,[DeviceId]
      ,[PropertyId]
      ,[Value]
      ,[DateUpdated]
      ,[MessageDate]
  FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitState]
  WHERE MobileUnitId in (-3958977241595557833, 1121885054700744704)
  AND (PropertyId = -4403033164446606692
  OR PropertyId = -3166755750272960197)


CHANGE WHERE IT READS FROM

LAST_TRIP_END_ODOMETER
ASSET_LAST_DISPLAY_ODOMETER

From 4k modal...
deviceConfigRepository.GetState(mobileUnitId, deviceId, Properties.LAST_TRIP_END_ODOMETER

MiX4000/6000 odo state values, so maybe whichever property is used to display the odo for those unit types can be used for the MiX2000/2310

  Most likely it is read from two different places
  - Get the place where assets list reads it from
      Odometer
        assetDetails.Asset.Odometer
          AssetsGateway.GetAssetList
            assetExtendedSummary.Odometer
              AssetsClient.GetExtendedSummariesAsync
                AssetDB... dbo.Vehicles...
                  fLastOdo
                  liLastEngineSeconds

                So as dit n 3b org is dan call ons
                [dynamix].[Assets_GetExtendedSummaries]
                
                en as dit 3b af is call ons
                [deprecated].[Assets_GetExtendedSummaries]

  - Get the place where diagnostics reads it from
      Diagnostic info 
        Odometer
        mix2310iDiagnosticInfo.odometer
          tripInfo.Odometer.Value / 1000.0
            muProxy.GetDiagnosticsTripInformation
              MobileUnitStateInSharedCache().GetTripInformation


