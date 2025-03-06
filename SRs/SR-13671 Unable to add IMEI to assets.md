---
created: 2022-09-13T16:49
updated: 2025-03-06T12:00
---
Date: 2022-09-13 Time: 10:50
Parent:: xxxx
Friend:: [[2022-09-13]]
JIRA:SR-13671
[[SR-13671] Unable to add IMEI to assets - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-13671)

# SR-13671 Unable to add IMEI to assets

## Image


## Development work

- Common > MiX.DeviceIntegration.Core
- API > Dynamix.DeviceConfig
- Client > MiX.DeviceConfig

| Lang  | UI    | BE    | Client | API   | Common | DB    |
| ----- | ----- | ----- | ------ | ----- | ------ | ----- |
| 22.6  | 22.6  | 22.6  | 22.6   | 22.6  | 22.6   | 22.6  |
| Local | Local | Local | Local  | Local | Local  | Local |

## Summary

Hi All, Please assist with the below issue, 
 
We can not add IMEI Numbers to UK Environment, 
 
I chatted to Rudolf and he advised that the call that is made to MiX Connect are failing 
 
 
at DynaMiX.Data.ConfigAdmin.MiXConnectRepository.IsImeiRegistered(String deviceId) in D:\b\2\_work\1119\s\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs:line 118    at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifierMiX2310i(String imei) in D:\b\2\_work\1119\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 329

An unexpected error has occurred
Error no: 1460678744631513088
A call to "GET /devices/350320890035403" failed. 503 - Service Temporarily Unavailable -

[[Comms]] side

## Branch
Config/MR/Bug/SR-13671 Unable to add IMEI to assets.xx.xx.ORI

## Learned
- Log: https://app.logz.io/#/goto/f03fba44d0e84fb7618b12402b9c517b?switchToAccountId=157279
- /assets/commissioning/{orgId}/{assetId}

## Description
IDC: **UK**  
database: Avangrid

MiX 4000  
Asset ID:  1832 & 1935
(Deleted veh CMP-491043 and recreated)

- CMP-491043= IMEI <mark class="hltr-orange">353863118663388</mark> 
- CMP-492119= IMEI 350120020528792

## ERROR:


EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId><mark class="hltr-red">1304725564877578240</mark> </RequestId> <AuthToken>02bf0c2a-c2a1-47f8-9f4e-feb339f488f1</AuthToken> <AccountId>8595454426092307445</AccountId> <RequestJson>{"AssetName":"US-00: NB, Install/Programming GPSV - M4K","HasBeenCommissioned":false,"DeviceTypeName":"MiX4000","MobileDeviceId":"6183256567829462590","HasDeviceTypeIdentifier":true,"DeviceTypeIdentifierTitle":"Unique identifier","DeviceTypeIdentifierValue":"<mark class="hltr-orange">353863118663388</mark> ","ConfigChanged":true,"IridiumImei":"","IridiumContract":"","IridiumError":null,"IridiumSatelliteCapable":false,"HasIridiumImei":false,"CanDeactivateIridiumAccount":false,"CommunicationCapable":false,"SimCardPinCode":"","GprsCapable":false,"GprsEnabled":false,"GprsApnPointName":null,"GprsApnUsername":null,"GprsApnPassword":null,"GsmCapable":false,"GsmEnabled":false,"GsmMsisdnNumber":null,"SmsCapable":false,"SmsEnabled":false,"SmsMobileDeviceNumber":null,"SmsMessageCentreNumber":null,"SatelliteCapable":false,"SatalliteDeviceId":"","UploadScheduleId":null,"HasUploadSchedule":false,"IsMesaBased":true,"CanEditDetails":true,"CanEditSmsDetails":true,"CanEditGsmDetails":true,"CanEditSimPin":true,"CanEditApnName":true,"CanEditMobileDevice":true,"CanRemoveMobileDevice":true,"CanEditSatelliteDetails":true,"CanEditIridiumSatelliteDetails":true,"CompileCapable":true,"CanCompileConfig":true,"CanUploadConfig":true,"CanViewCommsLog":true,"OrgIsMiXTalkEnabled":false,"MiXTalkIMEI":null,"MiXTalkSIMNumber":null,"MiXTalkCarrierID":0,"MiXTalkCarriers":null,"CommissioningStatus":null,"ShowOBCResendCommissioningSMS":false,"Tabs":null,"OrgIsStreamaxEnabled":false,"StreamaxDeviceTypes":null,"StreamaxSerialNumber":null,"DeviceIsStreamaxEnabled":true,"CanEditStreamaxDetails":true,"IsStreamaxStandAlone":false,"IsStreamaxPeripheralConnected":false}</RequestJson> <RequestUrl>PUT [http://uk.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/5132608609161368699/1304717701357973504](http://uk.mixtelematics.com/DynaMiX.API<mark class="hltr-green">/fleet-admin/assets/commissioning/</mark> 5132608609161368699/1304717701357973504 "Follow link")</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! A call to "<mark class="hltr-red">POST /devices</mark> " failed. 500 - Internal Server Error - <!DOCTYPE html>

More from the Log: 

- Exception Type: System.Exception Stack trace at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.CheckForErrorResponse(IRestResponse& response, IRestRequest request, HttpStatusCode[] ignoredHttpStatusCodes) in D:\b\1\_work\779\s<mark class="hltr-red">\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client</mark> \EntityData\ResourceWrapperHelper.cs:line 76 at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.ProcessAddOrUpdateRequest[T](String postUri, String putUri, T resource, String& location) in D:\b\1\_work\779\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\ResourceWrapperHelper.cs:line 33 at MiX.Connect.Devices.Comms.Web.Api.Client.DeviceResourceWrapper.op_Implicit(DeviceResource deviceResource) in D:\b\1\_work\779\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\DeviceResourceWrapper.cs:line 33 at DynaMiX.Data.ConfigAdmin.MiXConnectRepository.RegisterImei(String deviceId, DeviceType deviceType) in D:\b\1\_work\270\s\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs:line 169 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifierMix4k(String imei) in D:\b\1\_work\270\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 367 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifier(String authToken, Int64 orgId, Int64 assetId, String uniqueIdentifier) in D:\b\1\_work\270\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 247 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in D:\b\1\_work\270\s\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 152 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in D:\b\1\_work\270\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1217 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__15_2(Object args) in D:\b\1\_work\270\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 144 at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1) at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_01.<RegisterRoute>b__2(Object args) in D:\b\1\_work\270\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 501 at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1) at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\270\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\270\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\270\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148


## Code sections

- Comms: MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\ResourceWrapperHelper (line 76) 
- Comms: MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\ResourceWrapperHelper (line 33) 
- Comms: MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\DeviceResourceWrapper (line 33) 
- BE: DynaMiX.Data.ConfigAdmin.MiXConnectRepository.RegisterImei (line 169) 
  [_commsServiceApiClient.Devices[imei] = new DeviceResource() { DeviceType = deviceType, Imei = imei };]
- BE: FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifierMix4k (line 367) 
- BE: FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifier (line 247) 
- BE: FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation (line 152) 
- BE: FleetAdmin\Assets\AssetCommissioningModule (line 1217) 
- BE: FleetAdmin.Assets.AssetCommissioningModule (line 144)

## Files

## Resources

## Notes

