Date: 2022-03-08 Time: 15:42
Status: #done
Friend: 

# Timezones

## Description

Just some code snippets regarding timezones

## Code sections

response.requestDate
formatZonedDate:{ locale : loggedInProfile.locale, format : 8 }
getAssetDiagnostics


carrier.RequestDate = carrier.GeneralStatusInfo.StatusRetrieved.ToHistoricalTimeZone(asd.AssetId, timezoneResource, sourceDataTimezone)
GeneralStatusInfo.StatusRetrieved

asd.AssetStatus.Retrieved
asd = AssetsManager.GetAssetDiagnosticInfo
asd.AssetStatus = AssetStatusBagConverter.Convert(statusValues, orgId)

  statusValues
  assetStatus.Retrieved = ZonedDateTime.ToTimeZone(retrievedZdt, context.ContextTimeZone);
  BAG > retrievedUTC ?? Retrieved
    retrievedUTC: 
    retrieved: 
  bag = values.VehicleStatus
    statusValues = fleetStatusValues.ToEntity
      (AssetsClient.GetStatusValuesAsync).VehicleStatus.(retrievedUTC / retrieved)

DONNY STM:
  003F0019C6
  1187448574767980544

AssetDiagnosticInfoCarrier ToCarrier(this AssetStatusDetails asd