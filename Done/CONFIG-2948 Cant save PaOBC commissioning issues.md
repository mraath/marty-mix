# CONFIG-2948 Cant save PaOBC, commissioning issues


I've tried first making these available: G52S, Remora, Oyster, Yabby
After which I made Mobile Phone available.
The Hidden DME is still not on my new Org's Mobile Phone template.

* remora of oyster in jou nuwe org sit en dan 'n PaOBC weer probeer create
* 

WAS: LogicalDevices.SYSTEM_LOGICAL_DME_HIDDEN
NOW: LogicalDevices.DME_HIDDEN
-9075836125967806082

  '''xml
  <device id="-9075836125967806082" type="130" systemName="System.Logical.Dme.Hidden" legacyId="-220006">
		<logical label="DME - hidden device" uisortorder="57500" />
		<dependencies>
			<dependency id="4778452061163257880" parentId="697324896487352644" type="1" autoConnect="1" childRequired="1" info="MobileDevice.G52S Solar Tracker" />
			<dependency id="5878452061163257880" parentId="797324896487352744" type="1" autoConnect="1" childRequired="1" info="MobileDevice.Remora" />
			<dependency id="-4812439148942010772" parentId="1421721680027030859" type="1" autoConnect="1" childRequired="1" info="MobileDevice.Oyster" />
			<dependency id="-8660254537534741229" parentId="-7892022077469569738" type="1" autoConnect="1" childRequired="1" info="MobileDevice.Yabby" />
		</dependencies>
	</device>
  '''

- ERROR

    Error no: 1174772867607900169

    "message": "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
 <RequestId>1174772867607900169</RequestId>
 <AuthToken>9d812508-c5da-4b00-8662-514898140a95</AuthToken>
 <AccountId>8913709627074943104</AccountId>
 <RequestJson>{\"AssetName\":\"Default mobile device template for Mobile Phone\",\"HasBeenCommissioned\":false,\"DeviceTypeName\":\"Mobile Phone\",\"MobileDeviceId\":\"-7688187356053930045\",\"HasDeviceTypeIdentifier\":true,\"DeviceTypeIdentifierTitle\":\"Mobile number\",\"DeviceTypeIdentifierValue\":\"+27814991301\",\"ConfigChanged\":true,\"IridiumImei\":\"\",\"IridiumContract\":\"\",\"IridiumError\":null,\"IridiumSatelliteCapable\":false,\"HasIridiumImei\":false,\"CanDeactivateIridiumAccount\":false,\"CommunicationCapable\":false,\"SimCardPinCode\":\"\",\"GprsCapable\":false,\"GprsEnabled\":false,\"GprsApnPointName\":null,\"GprsApnUsername\":null,\"GprsApnPassword\":null,\"GsmCapable\":false,\"GsmEnabled\":false,\"GsmMsisdnNumber\":null,\"SmsCapable\":false,\"SmsEnabled\":false,\"SmsMobileDeviceNumber\":null,\"SmsMessageCentreNumber\":null,\"SatelliteCapable\":false,\"SatalliteDeviceId\":\"\",\"UploadScheduleId\":null,\"HasUploadSchedule\":false,\"IsMesaBased\":false,\"CanEditDetails\":true,\"CanEditSmsDetails\":true,\"CanEditGsmDetails\":true,\"CanEditSimPin\":true,\"CanEditApnName\":true,\"CanEditMobileDevice\":true,\"CanRemoveMobileDevice\":true,\"CanEditSatelliteDetails\":true,\"CanEditIridiumSatelliteDetails\":true,\"CompileCapable\":true,\"CanCompileConfig\":true,\"CanUploadConfig\":true,\"CanViewCommsLog\":false,\"OrgIsMiXTalkEnabled\":false,\"MiXTalkIMEI\":null,\"MiXTalkSIMNumber\":null,\"MiXTalkCarrierID\":0,\"MiXTalkCarriers\":null,\"CommissioningStatus\":null,\"ShowOBCResendCommissioningSMS\":true,\"Tabs\":null,\"OrgIsStreamaxEnabled\":false,\"StreamaxDeviceTypes\":null,\"StreamaxSerialNumber\":null,\"DeviceIsStreamaxEnabled\":false,\"CanEditStreamaxDetails\":true,\"IsStreamaxStandAlone\":false}</RequestJson>
 <RequestUrl>PUT http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/-8441185520557948197/1174422167963815936</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! A call to \"PUT /devices/27814991301/setconnector\" failed. 500 - Internal Server Error - {\"StatusCode\":\"InternalServerError\",\"Type\":\"Exception\",\"Message\":\"NotFound - Invalid IMEI[27814991301].\"}
\tException Type: System.Exception
\tStack trace at MiX.Connect.Dmt.Web.Api.Client.EntityData.ResourceWrapperHelper.CheckForErrorResponse(IRestResponse& response, IRestRequest request, HttpStatusCode[] ignoredHttpStatusCodes) in D:\\b\\1\\_work\\368\\s\\DMT\\MiX.Connect.Dmt.Web.Api.Client\\EntityData
    ResourceWrapperHelper.cs:line 83
 at MiX.Connect.Dmt.Web.Api.Client.EntityData.ResourceWrapperHelper.ProcessPutRequest(String uri) in 
    D:\\b\\1\\_work\\368\\s\\DMT\\MiX.Connect.Dmt.Web.Api.Client\\EntityData     ResourceWrapperHelper.cs:line 50
 
    at DynaMiX.Data.ConfigAdmin.MiXConnectRepository.RegisterImeiG52S(String deviceId) in D:\\b\\2\\_work\\699\\s\\Data\\DynaMiX.Data\\ConfigAdmin
    MiXConnectRepository.cs:line 161
 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifierG52S(String imei) in D:\\b\\2\\_work\\699\\s\\Logic\\DynaMiX.Logic\\FleetAdmin
    AssetCommissioningManager.cs:line 345
 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateUniqueIdentifier(String authToken, Int64 orgId, Int64 assetId, String uniqueIdentifier) in D:\\b\\2\\_work\\699\\s\\Logic\\DynaMiX.Logic\\FleetAdmin
    AssetCommissioningManager.cs:line 244
 at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.UpdateAssetCommissionInformation(String authToken, Int64 orgId, Int64 assetId, Dictionary`2 propertyValueDictionaryFromUi, Int64 correlationId, Boolean configChanged) in D:\\b\\2\\_work\\699\\s\\Logic\\DynaMiX.Logic\\FleetAdmin
    AssetCommissioningManager.cs:line 149
 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.UpdateAssetCommissioning(String authToken, Int64 orgId, Int64 assetId, AssetCommissioningFormCarrier carrier) in D:\\b\\2\\_work\\699\\s\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets
    AssetCommissioningModule.cs:line 1223
 at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b_19_2(Object args) in D:\\b\\2\\_work\\699\\s\\API\\DynaMiX.API\\NancyModules\\FleetAdmin\\Assets
    AssetCommissioningModule.cs:line 158
 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass46_0`1.<RegisterRoute>b2(Object args) in D:\\b\\2\\_work\\699\\s\\Core\\DynaMiX.Core.Http\\Nancy
    ModuleBase.cs:line 501
 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass27_1`1.<HandleTyped>b_1() in D:\\b\\2\\_work\\699\\s\\Core\\DynaMiX.Core.Http\\Nancy
    ModuleBase.cs:line 287
 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\699\\s\\Core\\DynaMiX.Core.Http\\Nancy
    ModuleBase.cs:line 214
 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\699\\s\\Core\\DynaMiX.Core.Http\\Nancy
    ModuleBase.cs:line 148
",


