# QA-4696 changing mobile device from PaOBC to a MiX4000/6000 OBC unit

BE | Local

Config/MR/Bug/QA-4696_MovedTimeZoneDeviationLogic_IMEI.21.12.PROD_ORI


http://localhost/MiXFleet.UI/#/fleet-admin/asset/details?id=1162056578522247168&orgId=-3239007612472481813

groupIds/{groupId}/mobile-units/{mobileUnitId}/command/{commandId}

"Unable to send update timezone message for all the assets.FAILURE: Remote message for asset 1162056578522247168 not sent. DynaMiX.DeviceConfig.Common.Exceptions.ServerSideException: A call to "POST /devices/27670666534/commands" failed. 404 - 

The requested resource could not be found.

 at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.HandleErrorCodes(Uri uri, String requestUrl, JsonResponse response) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 60
  at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.DoPost(String url, Object body, RequestParameter[] parameters) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 148

   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitCommandsProxy.SendCommandToMobileUnit(String authToken, Int64 groupId, Int64 mobileUnitId, Int32 commandId, Nullable`1 preferredTransport, Nullable`1 param1, Nullable`1 param2, Nullable`1 param3)

 at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.SendCommandToMobileDevice(String authToken, Int64 organisationId, Command cmd, Int64 correlationId, Nullable`1 disSupportedUnit) in D:\b\1_work\769\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 207
  at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\1_work\769\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 1323"

NOTE: I was able to replicate the issue using the (MiX4000 & 6000) device types. Also something to note that when I change the device type back to "mobile phone" from any of the above mentioned device types that failed, the process works by design.
