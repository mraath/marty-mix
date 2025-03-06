CONFIG-2683 [Nicole Feedback Req] MiX2310 Diagnostic window doesn't load

Parent:: [[Diagnostic Modal]]

  - PROD: 21.9

    Config/MR/Bug/CONFIG-2683_DiagnosticScreenTimeout.21.9.PROD.ORI

    FE | Local | DEV | XX
    BE | Local | DEV | XX
    Languaging | Master


  - OLDER - na
    - BE | Local
      Config/MR/Bug/CONFIG-2683_DiagnosticScreenTimeout.21.7.INT.ORI

    - FE | Local
      Config/MR/Bug/CONFIG-2683_DiagnosticScreenTimeout.21.7.INT.ORI



    


    getLatestRelayCommand


  - TEST:
    https://integration.mixtelematics.com/#/asset/diagnostics?id=995127440635920384&orgId=8308618011429325423&device=MiX2310i&modal=true


  - Matt
    
    We have an old piece of code (4 years) that starting giving issues for certain units.
    When I look at the code I see it tries to retrieve the last 20 days' commands and then look for "SetRelayCommandDetails"

    If it isnt found it goed back 20 days and searches again... this is in a loop...
    Is there a faster way of doing this?
    The situations where this bombs out is when the GetList gets called a few times.
    Is there maybe another way to just get the last "SetRelayCommandDetails" command?
    If not I will just change the logic to not get 20 days at a time and also to only loop on request.

  - Some info
    https://jira.mixtelematics.com/browse/CONFIG-2683?focusedCommentId=333548&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-333548
    M2k-21

  Seems to be a Comms issue

    statusInfo.CommandStatus
    statusInfo.CommandDateTime
    statusInfo.ImmobilizerOrRelayDriveState



    1094011258842718208
    352094085099957

  - CODE:
        C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs

        try
				{
					var commands = _commsServiceApiClient.Devices[imei].Commands.GetList(fromDate, toDate);
					result = commands.Where(c => c.CommandDetails is SetRelayCommandDetails).OrderBy(c => c.StatusDetail.DateTime).LastOrDefault();
					toDate = fromDate;
					fromDate = fromDate - TimeSpan.FromDays(20);
				}
				catch (Exception ex)
				{
					throw new Exception(ex.ToString());
				}

  - BUG

    While all the diagnostic windows load for the different unit types, it does not always for the MiX2310i unit type.

    After a while the below error is returned.

    It seems that there is an Internal Server Error 500 on the Comms Web API call to retrieve the Mobile command history.

    My suggestion is to wrap the call and catch the exception so that the rest of the modal sections (Section 1 and 2 will at least show information). The 3rd section (Mobile Commands) could then indicate an issue retrieving latest info. I noticed it happens more frequently if the unit doesn't have any newer command info to retrieve..

    Error from the DynaMiX API:
    EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId>1114335386184511488</RequestId> <AuthToken>9c804bc9-1f31-40aa-879e-086840f0c0b3</AuthToken> <AccountId>-2250199538811307105</AccountId> <RequestJson /> <RequestUrl>GET http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/organisations/8308618011429325423/995127440635920384/diagnostics/0</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! A call to "GET /devices/356496042753582/commands?from=20181014134931&to=20181103134931" failed. 500 - Internal Server Error - {"StatusCode":"InternalServerError","Type":"NullReferenceException","Message":"Object reference not set to an instance of an object."} Exception Type: System.Exception Stack trace at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.CheckForErrorResponse(IRestResponse& response, IRestRequest request, HttpStatusCode[] ignoredHttpStatusCodes) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\ResourceWrapperHelper.cs:line 76 at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.ProcessGetRequest[T](String uri) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\ResourceWrapperHelper.cs:line 18 at MiX.Connect.Devices.Comms.Web.Api.Client.CommandResourceWrapperCollection.GetList(DateTime from, DateTime to) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api.Client\EntityData\CommandResourceWrapperCollection.cs:line 26 at DynaMiX.Data.ConfigAdmin.MiXConnectRepository.GetLatestRelayCommand(Int64 imei) in D:\b\2_work\177\s\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs:line 513 at DynaMiX.Data.ConfigAdmin.MiXConnectRepository.GetLastKnownDeviceDiagnosticInfo(String deviceId) in D:\b\2_work\177\s\Data\DynaMiX.Data\ConfigAdmin\MiXConnectRepository.cs:line 443 at DynaMiX.Logic.FleetAdmin.AssetManager.GetMiX2310iAssetDiagnosticInfo(String authToken, Int64 orgId, Int64 assetId, UInt32& statusPendingRequestId, Int64 correlationId) in D:\b\2_work\177\s\Logic\DynaMiX.Logic\FleetAdmin\Assets\AssetManager.cs:line 1615 at DynaMiX.Api.NancyModules.FleetAdmin.DiagnosticsModule.GetAssetDiagnosticInfoMiX2310i(String authToken, Int64 orgId, Int64 assetId, Int64 statusPendingRequestId) in D:\b\2_work\177\s\API\DynaMiX.API\NancyModules\FleetAdmin\DiagnosticsModule.cs:line 655 at DynaMiX.Api.NancyModules.FleetAdmin.DiagnosticsModule.<.ctor>b_24_0(Object args) in D:\b\2_work\177\s\API\DynaMiX.API\NancyModules\FleetAdmin\DiagnosticsModule.cs:line 116 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass46_0`1.<RegisterRoute>b0(Object args) in D:\b\2_work\177\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 497 at DynaMiX.Core.Http.Nancy.ModuleBase.<>cDisplayClass27_1`1.<HandleTyped>b_1() in D:\b\2_work\177\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\2_work\177\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\2_work\177\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

    Error from the Comms API log:
    2021/04/01 13:49:19 EXCEPTION! 10.105.1.183 GET /devices/356496042753582/commands - EXCEPTION!2021/04/01 13:49:19 EXCEPTION! 10.105.1.183 GET /devices/356496042753582/commands - EXCEPTION! Exception Type: System.ExceptionEXCEPTION! Object reference not set to an instance of an object. Exception Type: System.NullReferenceException Source MiX.Connect.Devices.Comms.Web.Api Stack trace    at MiX.Connect.Devices.Comms.Web.Api.Resources.Mappers.CommandDetailsMapperLibrary.GetCommandDetails(Command command, UInt16 udpMessageId) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api\Resources\Command Details\Mappers\CommandDetailsMapperLibrary.cs:line 124   at MiX.Connect.Devices.Comms.Web.Api.DeviceCommandsModule.<>c.<GetCommands>b__2_2(Command t) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api\Modules\DeviceCommandsModule.cs:line 108   at System.Linq.Enumerable.WhereSelectListIterator`2.MoveNext()   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)   at MiX.Connect.Devices.Comms.Web.Api.DeviceCommandsModule.<>c_DisplayClass2_0.<GetCommands>b_0() in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api\Modules\DeviceCommandsModule.cs:line 106   at MiX.Connect.Devices.Comms.Web.Api.ModuleHelper.ProcessRequest(NancyModule module, Func`1 handler) in D:\b\1_work\841\s\Devices\Comms\MiX.Connect.Devices.Comms.Web.Api\Modules\ModuleHelper.cs:line 18
    2

