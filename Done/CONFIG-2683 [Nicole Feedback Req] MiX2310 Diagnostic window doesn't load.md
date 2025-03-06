# CONFIG-2683 [Nicole Feedback Req] MiX2310 Diagnostic window doesn't load

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






## TELTONIKA DEVICE ISSUES

- Info
  https://jira.mixtelematics.com/browse/LFDI-10
  https://jira.mixtelematics.com/browse/LFW-2259


- MS SQL:
  USE MiX.Connect.Teltonika
  GO
  SELECT TOP 100 * FROM dbo.Commands (NOLOCK)

- Matthew extracted the following from logs:
  "2019/01/22 13:26:54 TeltonikaComms TcpChannel

- Our logs:
  Command sent to MiX.Connect.Teltonika

  "WARN  2021-05-10T13:08:31+00:00 [tid:5   ] Command sent to MiX.Connect.Teltonika (CommandId=SendConfiguration, UnitIdentifier=867060033914892, MobileUnitId=1094010937441591296, Transport=GPRS, MessageId=1108383646, Parameter1=, Parameter2=, Parameter3=, Value=, Commands=setparam 11004:10.000000;11104:130.000000;11005:33.000000;40162:4503.000000)"


## SR-9998 [UAT Testing] Event triggering incorectly

MiX4000
Data Centre (SR):Sydney
Affected Region:
Australasia (AsiaPac)
Organisation:Water Corporation WA PROD
WaterCorporationTest_2020
VehicleId (Legacy),	59
IMEI	354444114239975
OrgId (Legacy)	4795
Company ID	-32305
Firmware	4.8.35
Assetid (64 bit) (AND IMEI for MiX Connect Devices, e.g. DMT/MiX2000/MiX4000/MiX6000)	1053593783899312128


event (Driving>2hrs without rest) triggering incorrectly.
Event	Driving >2hrs without rest
Event id	135
Rule id	-4771988436495079232

event triggered on 15/03/2021.
According to the RSO the asset was idle all this time which means: 
'standing delay expired' and 
'Time since subtrip depart' parameters were not met. 

Why did the event trigger?




## Messages Commands PaOBC MiXTalk FM 4k 6k

MobileUnitManager > MobileUnitCommandsManager > (split) PaOBCCommandSender > PaOBCMessageSender > PaOBCProxy > Client that sends
MobileUnitManager > MobileUnitCommandsManager > (split) MiX4k6kCommandSender > (split) MiXConnectMessageSender > MiXConnectProxy > Client that sends




## NOTES

Jumpboxes
![](JumpboxesPaul.png)

## PROD Issue DUB


ERROR 1:

POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/config_groups
MiX.DeviceConfig.Api.Client.Repositories.ConfigurationGroupsRepository Line 89
It calls config-group-capabilities
Dewald 10 maande terug
Zonika a BE call 5 maande terug  (ConfigurationGroupsModule line 209)
  

  Message

    [8:48 AM] Shukoor Dramat
            EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
    <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RequestId>1119290383256047616</RequestId>
      <AuthToken>a98b3a1e-23ef-484f-a53b-abef5626d932</AuthToken>
      <AccountId>6429018838140833431</AccountId>
      <RequestJson>{​​​​​​​"Id":"configAdmin","Name":"Config Admin","Actions":[],"SortOrder":200}​​​​​​​</RequestJson>
      <RequestUrl>POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/config_groups</RequestUrl>
    </ApiRequestInfo>
        Exception Type: System.Exception
    EXCEPTION! A task was canceled.
        Exception Type: System.Threading.Tasks.TaskCanceledException
        Stack trace    at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) in D:\b\1\_work\83\s\MiX.Core\Retries\ElasticRetryStrategy.cs:line 103
      at MiX.Core.Retries.RetryStrategy.<ExitRetryAsync>d__33.MoveNext() in D:\b\1\_work\83\s\MiX.Core\Retries\RetryStrategy.cs:line 362
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.Core.Retries.RetryStrategy.<ExecuteActionWithTraceAsync>d__29`1.MoveNext() in D:\b\1\_work\83\s\MiX.Core\Retries\RetryStrategy.cs:line 295
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.Core.Clients.HttpRetries.<GetAsync>d__11`1.MoveNext()
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.Core.Clients.HttpRetries.<Get>d__10`1.MoveNext()
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at MiX.DeviceConfig.Api.Client.Repositories.ConfigurationGroupsRepository.<GetConfigurationGroupCapabilitiesForConfigurationGroupsList>d__4.MoveNext() in D:\b\1\_work\136\s\MiX.DeviceConfig.Api.Client\Repositories\ConfigurationGroupsRepository.cs:line 89
    --- End of stack trace from previous location where exception was thrown ---
      at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
      at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
      at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.GetConfigGroupListPage(String authToken, Int64 orgId) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 0
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__1(Object args) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

-------

ERROR 2:

POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5017546331788413305/config_groups/0/assetlist
EXCEPTION! Object reference not set to an instance of an object
ConfigurationGroupsModule.ConvertToCarrier Line 992
Will need to investigate
Me SerialNumber 10 months ago
Zonika IsPhoneBased 5 months ago

  Message

    ​[8:48 AM] Shukoor Dramat
        EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
    <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RequestId>1119295805122064384</RequestId>
      <AuthToken>da4b204e-7ddc-438d-9f23-f1df5ec83245</AuthToken>
      <AccountId>6429018838140833431</AccountId>
      <RequestJson>{​​​​​​​"fromCache":false,"page":1,"pageSize":50,"sortField":"description","sortDirection":0,"filters":[{​​​​​​​"fieldName":"type","value":""}​​​​​​​]}​​​​​​​</RequestJson>
      <RequestUrl>POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5017546331788413305/config_groups/0/assetlist</RequestUrl>
    </ApiRequestInfo>
        Exception Type: System.Exception
    EXCEPTION! Object reference not set to an instance of an object.
        Exception Type: System.NullReferenceException
        Stack trace    at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.ConvertToCarrier(AssetSummary entity, MobileUnitSummary mobileUnit, TimeZoneInfo sourceDataTimezone, List`1 timezoneResource, Boolean canEditMobileDeviceTemplates, Boolean canEditEventTemplates, Boolean canEditLocationTemplate, Boolean canAccessScheduler, Boolean canViewAssets, Boolean canEditAssets, Boolean canCompileAssets, Boolean canUploadAssets, Boolean canResetToConfigGroup, Boolean canDownloadConfigFile, AssetUploadScheduleSummary schedule, HashSet`1 hsBeaconIds, HashSet`1 hsTrackTrace, HashSet`1 hsFmDevices, HashSet`1 hsTdiDevices, HashSet`1 hsM2kDevices, HashSet`1 hsM4kDevices, HashSet`1 hsM6kDevices, HashSet`1 hsMesaDevices, HashSet`1 hsG52Devices, HashSet`1 hsPhoneDevices, Dictionary`2 siteNames, Dictionary`2 unitFw, Dictionary`2 dictLatestMesaMessages, Dictionary`2 dictdeviceTypes, Dictionary`2 dictImeiProperties, Dictionary`2 assetConfigFlags, UserProfile user) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 992
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.GetConfigGroupAssetList(String authToken, Int64 orgId, Int64 configGroupId, ListQueryCarrier queryCarrier) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 684
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.<.ctor>b__13_3(Object args) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 102
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__1(Object args) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148
​

--------

ERROR 3: (duplicate of 2)

POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5017546331788413305/config_groups/0/assetlist
EXCEPTION! Object reference not set to an instance of an object.
SAME AS ABOVE

  Message
    [8:48 AM] Shukoor Dramat
        EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
    <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RequestId>1119299125771030528</RequestId>
      <AuthToken>bed65783-f008-46c2-a951-40e77951c589</AuthToken>
      <AccountId>8595454426092307445</AccountId>
      <RequestJson>{​​​​​​​"fromCache":false,"page":1,"pageSize":50,"sortField":"description","sortDirection":0,"filters":[{​​​​​​​"fieldName":"type","value":""}​​​​​​​]}​​​​​​​</RequestJson>
      <RequestUrl>POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5017546331788413305/config_groups/0/assetlist</RequestUrl>
    </ApiRequestInfo>
        Exception Type: System.Exception
    EXCEPTION! Object reference not set to an instance of an object.
        Exception Type: System.NullReferenceException
        Stack trace    at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.ConvertToCarrier(AssetSummary entity, MobileUnitSummary mobileUnit, TimeZoneInfo sourceDataTimezone, List`1 timezoneResource, Boolean canEditMobileDeviceTemplates, Boolean canEditEventTemplates, Boolean canEditLocationTemplate, Boolean canAccessScheduler, Boolean canViewAssets, Boolean canEditAssets, Boolean canCompileAssets, Boolean canUploadAssets, Boolean canResetToConfigGroup, Boolean canDownloadConfigFile, AssetUploadScheduleSummary schedule, HashSet`1 hsBeaconIds, HashSet`1 hsTrackTrace, HashSet`1 hsFmDevices, HashSet`1 hsTdiDevices, HashSet`1 hsM2kDevices, HashSet`1 hsM4kDevices, HashSet`1 hsM6kDevices, HashSet`1 hsMesaDevices, HashSet`1 hsG52Devices, HashSet`1 hsPhoneDevices, Dictionary`2 siteNames, Dictionary`2 unitFw, Dictionary`2 dictLatestMesaMessages, Dictionary`2 dictdeviceTypes, Dictionary`2 dictImeiProperties, Dictionary`2 assetConfigFlags, UserProfile user) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 992
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.GetConfigGroupAssetList(String authToken, Int64 orgId, Int64 configGroupId, ListQueryCarrier queryCarrier) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 684
      at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.<.ctor>b__13_3(Object args) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 102
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__1(Object args) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148


---------------------

ERROR 4

POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/config_groups/0/assetlist
EXCEPTION! Value cannot be null
ConfigurationGroupsModule.GetConfigGroupAssetList
dictMobileUnitsConfigFlags = mucf.ToDictionary (OLD CODE)
however
  List<MobileUnitConfigFlag> mucf = muProxy.GetConfigChangedFlagForMobileUnits(authToken, organisationId);
  ME 2 months ago... Only to use organisationId in case of siteid

  Message
      EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId>1119299458192609280</RequestId> <AuthToken>41c14454-5046-4b1e-a7be-88f4ad18fd74</AuthToken> <AccountId>-2594647640637744898</AccountId> <RequestJson>{"fromCache":false,"page":1,"pageSize":50,"sortField":"description","sortDirection":0,"filters":[{"fieldName":"type","value":""}]}</RequestJson> <RequestUrl>POST http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/config_groups/0/assetlist</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION! Value cannot be null. Parameter name: source Exception Type: System.ArgumentNullException Stack trace at System.Linq.Enumerable.ToDictionary[TSource,TKey,TElement](IEnumerable`1 source, Func`2 keySelector, Func`2 elementSelector, IEqualityComparer`1 comparer) at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.GetConfigGroupAssetList(String authToken, Int64 orgId, Int64 configGroupId, ListQueryCarrier queryCarrier) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 659 at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ConfigurationGroupsModule.<.ctor>b__13_3(Object args) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs:line 102 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__1(Object args) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 499 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

------------

ERROR 5

GET http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/templates/mobile-devices
Object reference not set to an instance of an object
TemplatesModule.cs line 159
Doesnt make sense as it is instantiating a class... maybe something higher up


  Message
    EXCEPTION! <?xml version="1.0" encoding="utf-16"?> <ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <RequestId>1119323767092191232</RequestId> <AuthToken>41c14454-5046-4b1e-a7be-88f4ad18fd74</AuthToken>
    <AccountId>-2594647640637744898</AccountId> <RequestJson /> <RequestUrl>GET http://uk.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/2391282202306069750/templates/mobile-devices</RequestUrl> </ApiRequestInfo> Exception Type: System.Exception EXCEPTION!
    Object reference not set to an instance of an object. Exception Type: System.NullReferenceException Stack trace at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.TemplatesModule.GetMobileDevicesTemplateList(String authToken, Int64 orgId) in D:\b\1\_work\271\s\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\TemplatesModule.cs:line
    159 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 497 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in
    D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287 at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1
    method) in D:\b\1\_work\271\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148





## SRs / BUGS / UAT


## FE-1350 [TIM] REG Live tracking: GPS status information not available on asset diagnostics

Diagnostics window > Fleet services (asset's status values) > "[dynamix].[AssetStatusValues_Get]"
Asset status GPSReading property > gps values from the status string
!! This however does not always have the correct values to populate the GpsStatusInfo !!


Hey daar. Ek hoop jy doen nog baie goed! 

Ek het gekyk na n issue: FE-1350 (Diagnostics Modal)
GPS data is leeg, last position is nie.
Hul het dit gelog as regression maar dit lyk nie vir my na regression nie.
Dis reeds so op UAT.

My enigste ding wat ek kan doen is om met die Devs involved te praat en te hoor of hul kode in orde lyk.
So ek het probeer om sin te maak van dit als maar dis redelik involved...

In kort... lyk dit of waar ek jou moet vra die volgende is...
xxxxxxxxxxxxxxxx


Diagnotics modal summary


- **FM**

  Request URL: https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/2364975042774694384/7071574470134052972/diagnostics/0


  - GPS status information
    FE
      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html
        gpsStatusInfo
    BE
      GPS_STATUS_INFO

        .... as BE below

          GetAssetDiagnosticInfoDefault


          entity > AssetsManager.GetAssetDiagnosticInfo
            entity.ToCarrier
              carrier.LatestAVLInfo (asd.LastAVL) > TrackingRepository.GetLatestGPSReading (Tim)

            ----------

            last_position > TrackingRepository.GetLatestGPSReading

            ----------

            entity (asd) = AssetsManager.GetAssetDiagnosticInfo

                fleetStatusValues = AssetsClient.GetStatusValuesAsync (fleet client)
                var statusValues = fleetStatusValues.ToEntity
                
                asd.AssetStatus = AssetStatusBagConverter.Convert(statusValues, orgId) 
                    bag = statusValues.VehicleStatus;
                    statusValues.GPSReading = ConvertGPSReading(bag)

			          X asd.LastAVL = TrackingRepository.GetLatestGPSReading(orgId, assetId, correlationId);

            assetConfigDetails = DeviceIntegrationManager.GetAssetConfigDetails
                ...

            carier > entity.tocarrier(assetConfigDetails)
                carrier.GpsStatusInfo = ConvertGPSReading(asd.AssetStatus.GPSReading
                

            -------------

            Summary:
        
            AssetsClient.GetStatusValuesAsync > statusValues
              bag > statusValues.vehicleStatus
                bag converted > asd.AssetStatus.GPSReading

            GPS_data = asd.AssetStatus.GPSReading > bag converted > statusValues.vehicleStatus > AssetsClient.GetStatusValuesAsync

            -------------



            fleetstatusvalues = AssetsClient.GetStatusValuesAsync   <<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>



            fleetStatusValues = AssetsClient.GetStatusValuesAsync


            assetConfigDetails (asd) > DeviceIntegrationManager.GetAssetConfigDetails

              asd.AssetStatus = propertybag(statusValues)
                statusValues = AssetsClient.GetStatusValuesAsync

            carrier.GpsStatusInfo > ConvertGPSReading(asd.AssetStatus.GPSReading



            ASD = AssetStatusDetails entity = AssetsManager.GetAssetDiagnosticInfo(authToken, orgId, assetId, CorrelationId)

            ConvertGPSReading(ASD.AssetStatus (fleetstatusvalues) .GPSReading 

                [ConvertGPSReading(bag)]

                <--> CHECK WHO LAST TOUCHED THIS

    API
    DB

  - Latest position information
    FE
      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html
        latestAVLInfo
    BE
      LATEST_AVL_INFO
      LATEST_POSITION_INFO
        GetAssetDiagnosticInfo
          Splits into 4k, 6k.... 2k.... other (<focussed on this>)

          GetAssetDiagnosticInfoDefault

            also ASD
                ASD.LastAVL (comes from)
                    TrackingRepository.GetLatestGPSReading
                        tracking repo...

                          <--> CHECK WHO LAST TOUCHED THIS


    API
    DB

- **4k, 6k**

  - GPS status information
    FE
      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsGPS.html
        gps
        getDiagnosticsGPS
    BE
      GPS_STATUS_INFO
        GetDiagnosticsGPS
          muProxy.GetDiagnosticsGPSInformation
    API
      GetDiagnosticsGPSInformation
        MobileUnitStateInSharedCache().GetGpsInformation
        else null !!

        [wynand]                  <-->

    DB

  - Latest position information
    FE
      C:\Projects\MiXFleet\UI\Js\ConfigAdmin\Templates\Diagnostics\DiagnosticsPosition.html
        position
        getDiagnosticsPosition
    BE
      GetDiagnosticsPosition
        List<GPSReading> latestPositions = TrackingManager.GetLatestPositionsForAssetsByAssetIds(authToken, orgId, new List<long> { assetId }, CorrelationId);
          XXXXXX

          [Tim, Christo, Arnold, Chad]           <-->
    API
    DB

### CONFIG-2201 MiX Insight not loading on DEV environment

Hey daar. Ek hoop jy doen baie goed! 

Ek kry nou weer tyd om te kyk na ons Dev environment.
Daar is n issue met ons Insight Reports, maar ek weet dis ons environment.
Ek wou net weet of DIE n klokkie lui?

EXCEPTION! Log on failed. Ensure the user name and password are correct. ---> Microsoft.ReportingServices.Diagnostics.Utilities.

Dit gebeur waar ons die client instantiate.
_client = new InsightApiClient(DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiUrl, DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiSsrsManagementServiceUrl, DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiSsrsExecutionServiceUrl, Session.UserName, Session.AuthToken);

Die Urls lyk als soos die van INT:
DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiUrl = "http://api.dw.int.development.domain.local/"
DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiSsrsManagementServiceUrl = "http://ssrs.dw.int.development.domain.local/ReportServer/ReportService2005.asmx"
DynaMiX.Common.InsightReports.InsightSettings.Current.InsightBiApiSsrsExecutionServiceUrl = "http://ssrs.dw.int.development.domain.local/ReportServer/ReportExecution2005.asmx"

Dit kyk wel vir die username en password na mens se session...
Session.UserName = "mraath@gmail.com"
Session.AuthToken = "62e3d5d1-780f-4266-9307-a102196c98bd"

So ek neem aan daai user van my sal nie regte he op die Microsoft ReportingServices nie.

Dit werk wel op int... met myselfde user...

Ek wou net hoor OF jy enige idees het... NO pressure.
Thanks ou - lekker dag verder

    "message": "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1106732614035324928</RequestId>
  <AuthToken>e6b6f5df-c852-4ef9-8907-ca08892d1542</AuthToken>
  <AccountId>2904277068424365252</AccountId>
  <RequestJson />
  <RequestUrl>GET http://config.dev.mixtelematics.com:80/DynaMiX.API/insight-reports/organisations/3222089765699420885/folders/FM</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! Log on failed. Ensure the user name and password are correct. ---> Microsoft.ReportingServices.Diagnostics.Utilities.LogonFailedException: Log on failed. Ensure the user name and password are correct.
\tException Type: System.Web.Services.Protocols.SoapException
\tStack trace    at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)
   at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)
   at MiX.Insight.Api.Client.InsightApiClient..ctor(String insightApiUrl, String ssrsManagementServiceUrl, String ssrsExecutionServiceUrl, String username, String password, String logFilePath)
   at DynaMiX.Data.DataWarehouse.InsightReportsRepository.GetInsightApiClient() in D:\\b\\2\\_work\\99\\s\\Data\\DynaMiX.Data\\DataWarehouse\\InsightReportsRepository.cs:line 273
   at DynaMiX.Data.DataWarehouse.InsightReportsRepository.GetReportCategories(Int32 organisationId) in D:\\b\\2\\_work\\99\\s\\Data\\DynaMiX.Data\\DataWarehouse\\InsightReportsRepository.cs:line 90
   at DynaMiX.Logic.InsightReports.InsightReportsManager.GetReportCategories(String authToken, Int32 organisationId) in D:\\b\\2\\_work\\99\\s\\Logic\\DynaMiX.Logic\\InsightReports\\InsightReportsManager.cs:line 150
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.<>c__DisplayClass47_0.<GetReportCategoriesFromCache>b__0() in D:\\b\\2\\_work\\99\\s\\API\\DynaMiX.API\\NancyModules\\InsightReports\\InsightReportsModule.cs:line 564
   at DynaMiX.Core.Caching.CacheProvderBase.Get[T](String key, Func`1 refreshMethod, Nullable`1 utcExpiresAt, Int64 correlationId, Boolean cacheShortTerm, Nullable`1 shortTermUtcExpiresAt) in D:\\b\\2\\_work\\99\\s\\Core\\DynaMiX.Core\\Caching\\CacheProviderBase.cs:line 56
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.GetReportCategoriesFromCache(String authToken, Int32 legacyOrgId) in D:\\b\\2\\_work\\99\\s\\API\\DynaMiX.API\\NancyModules\\InsightReports\\InsightReportsModule.cs:line 0
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.GetFolderContents(String authToken, String path, Int64 groupId, String isSubscription) in D:\\b\\2\\_work\\99\\s\\API\\DynaMiX.API\\NancyModules\\InsightReports\\InsightReportsModule.cs:line 580
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.<.ctor>b__28_2(Object args) in D:\\b\\2\\_work\\99\\s\\API\\DynaMiX.API\\NancyModules\\InsightReports\\InsightReportsModule.cs:line 193
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\\b\\2\\_work\\99\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 497
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\\b\\2\\_work\\99\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\99\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\\b\\2\\_work\\99\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148
",



Request URL: http://config.dev.mixtelematics.com/DynaMiX.API/insight-reports/organisations/3222089765699420885/folders/FM
Log on failed. Ensure the user name and password are correct. ---> Microsoft.ReportingServices.Diagnostics.Utilities.LogonFailedException: Log on failed. Ensure the user name and password are correct.<br />
<strong>Error no: 1105935406415314944</strong>

EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1105935406415314944</RequestId>
  <AuthToken>96d9041d-c87c-47c5-958d-123b6bf87a5e</AuthToken>
  <AccountId>2904277068424365252</AccountId>
  <RequestJson />
  <RequestUrl>GET http://config.dev.mixtelematics.com:80/DynaMiX.API/insight-reports/organisations/3222089765699420885/folders/FM</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception
EXCEPTION! Log on failed. Ensure the user name and password are correct. ---> Microsoft.ReportingServices.Diagnostics.Utilities.LogonFailedException: Log on failed. Ensure the user name and password are correct.
	Exception Type: System.Web.Services.Protocols.SoapException
	Stack trace    at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)
   at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)
   at MiX.Insight.Api.Client.InsightApiClient..ctor(String insightApiUrl, String ssrsManagementServiceUrl, String ssrsExecutionServiceUrl, String username, String password, String logFilePath)
   at DynaMiX.Data.DataWarehouse.InsightReportsRepository.GetInsightApiClient() in D:\b\2\_work\100\s\Data\DynaMiX.Data\DataWarehouse\InsightReportsRepository.cs:line 273
   at DynaMiX.Data.DataWarehouse.InsightReportsRepository.GetReportCategories(Int32 organisationId) in D:\b\2\_work\100\s\Data\DynaMiX.Data\DataWarehouse\InsightReportsRepository.cs:line 90
   at DynaMiX.Logic.InsightReports.InsightReportsManager.GetReportCategories(String authToken, Int32 organisationId) in D:\b\2\_work\100\s\Logic\DynaMiX.Logic\InsightReports\InsightReportsManager.cs:line 150
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.<>c__DisplayClass47_0.<GetReportCategoriesFromCache>b__0() in D:\b\2\_work\100\s\API\DynaMiX.API\NancyModules\InsightReports\InsightReportsModule.cs:line 564
   at DynaMiX.Core.Caching.CacheProvderBase.Get[T](String key, Func`1 refreshMethod, Nullable`1 utcExpiresAt, Int64 correlationId, Boolean cacheShortTerm, Nullable`1 shortTermUtcExpiresAt) in D:\b\2\_work\100\s\Core\DynaMiX.Core\Caching\CacheProviderBase.cs:line 56
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.GetReportCategoriesFromCache(String authToken, Int32 legacyOrgId) in D:\b\2\_work\100\s\API\DynaMiX.API\NancyModules\InsightReports\InsightReportsModule.cs:line 0
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.GetFolderContents(String authToken, String path, Int64 groupId, String isSubscription) in D:\b\2\_work\100\s\API\DynaMiX.API\NancyModules\InsightReports\InsightReportsModule.cs:line 580
   at DynaMiX.Api.NancyModules.InsightReports.InsightReportsModule.<.ctor>b__28_2(Object args) in D:\b\2\_work\100\s\API\DynaMiX.API\NancyModules\InsightReports\InsightReportsModule.cs:line 193
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\b\2\_work\100\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 497
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\2\_work\100\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\2\_work\100\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\2\_work\100\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

.............

### SPLIT....


### SR-9282 [Test] Error received every morning when logging in to AU

BE | Local | PR INT

Config/MR/Bug/SR-9282_SiteIdConvertToOrgId.21.2.PROD


OrgId:-5885621891994904038
EXCEPTION

Could not get context for orgId
Is the organisation in the database
KeyNotFoundException

config_groups/0/assetlist
ConfigurationGroupsModule.cs:line 495
EXCEPTION! Group with Id 

Used a Crazy formula
=REPLACE(TRIM(RIGHT(SUBSTITUTE(M26; "#"; REPT(" "; LEN(M26))); LEN(M26)));FIND("|"; TRIM(RIGHT(SUBSTITUTE(M26; "#"; REPT(" "; LEN(M26))); LEN(M26)))); LEN(M26); "")



- HUGE Logz.io
  https://app.logz.io/#/dashboard/kibana/discover?_a=(columns:!(message,AppName),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:AppName,negate:!f,params:(query:DynaMiX.Api),type:phrase),query:(match_phrase:(AppName:DynaMiX.Api))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:SYD),type:phrase),query:(match_phrase:(Env:SYD))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('Could%20not%20get%20context%20for%20orgId','OrgId:-5885621891994904038',config-admin%2Forganisations%2F-5885621891994904038%2Fconfig_groups%2F0%2Fassetlist,config_groups%2F0%2Fassetlist,'Is%20the%20organisation%20in%20the%20database%3F',GetOrganisationGroupForEntity),type:phrases,value:'Could%20not%20get%20context%20for%20orgId,%20OrgId:-5885621891994904038,%20config-admin%2Forganisations%2F-5885621891994904038%2Fconfig_groups%2F0%2Fassetlist,%20config_groups%2F0%2Fassetlist,%20Is%20the%20organisation%20in%20the%20database%3F,%20GetOrganisationGroupForEntity'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'Could%20not%20get%20context%20for%20orgId')),(match_phrase:(message:'OrgId:-5885621891994904038')),(match_phrase:(message:config-admin%2Forganisations%2F-5885621891994904038%2Fconfig_groups%2F0%2Fassetlist)),(match_phrase:(message:config_groups%2F0%2Fassetlist)),(match_phrase:(message:'Is%20the%20organisation%20in%20the%20database%3F')),(match_phrase:(message:GetOrganisationGroupForEntity))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:'2021-06-01T08:45:58.680Z',to:'2021-06-30T09:02:44.313Z'))&accountIds=157986&switchToAccountId=157279




- SMALLER Logz.io
  - 1st June > 10th June... Only 7 distinct
  
    1111993346152230912
    1111993351261065216
    2734508336091930758
    1136940201252790272
    984081830814773248
    5795090669316332414
    -2137415447793950440

    None of them were found in FMOnlineDB.dynamix.Organisations,
    in order to see if they are Sites I need to know which Database
    the user was searching from to know which table to look for...
    eg. XXXXXXXXXXXXXXXXXXXXX.dynamix.Sites

    I think we can leave this for later...
    So this is fine!



AU
adam.robertson@vehicletech.co.nz
Periodic
Org: AU-Direct
/config_groups/?/assetList

FIX:
IOrganisationGroupManager orgGroupManager = DependencyResolver.GetInstance<IOrganisationGroupManager>();
var organisationId = orgGroupManager.GetOrganisationGroupForEntity(orgId, DynaMiX.Common.EntityTypes.GROUP).GroupId;

IOrganisationGroupManager orgGroupManager = DependencyResolver.GetInstance<IOrganisationGroupManager>();
var organisationId = orgGroupManager.GetOrganisationGroupForEntity(orgId, DynaMiX.Common.EntityTypes.GROUP).GroupId;


CALLED FROM

var organisation = this.globalSelectionCriteria.breadcrumbSelection.selectedItems[0];

Then goes to...

	http://vt.au.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5885621891994904038/config_groups/0/assetlist

Could not get context for orgId

public static readonly RouteDefinition GET_CONFIG_GROUP_ASSETS = new RouteDefinition(APISettings.Current.ApiBaseUrl, BASE_PATH, "/organisations/{orgId}/config_groups/{id}/assetlist", Core.Http.Constants.HTTPVerbs.POST);
<RequestUrl>POST http://vt.au.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-5885621891994904038/config_groups/0/assetlist</RequestUrl>

GET_CONFIG_GROUP_ASSETS

GroupId:-5885621891994904038 , GroupName:Auckland, Type:SiteGroup, DisplayTimeZone: New Zealand Standard Time, GroupParentId:-4908245075616946556 , GroupParentName:Toll New Zealand

it might be the miller that still on site level



SELECT top 10 * FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = -4908245075616946556
--4848
Select * FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = 4848

SELECT top 10 * FROM TollNewZealand_2020.dynamix.Sites dmxs
WHERE GroupId = -5885621891994904038
--1
SELECT top 10 * FROM TollNewZealand_2020.dbo.Sites
WHERE liSiteID = 1




### SR-9374 [Open] Live Tracking Not Showing Ignition Status Correctly

  - Jacques
    [16:05] Jacques Van Wyk
        daai is 'n ou laai met FM - status op diagnostics word versoek vanaf die unit, so as hy af is gaan hy niks terugstuur nie
    ​[16:05] Jacques Van Wyk
        die sleutel is die tyd
    ​[16:05] Jacques Van Wyk
        daai waardes is akkuraat vir die unit raw date/time. 
    ​[16:05] Jacques Van Wyk
        Ek dink nie hierdie is ;n verandering werd nie, net kommunikasie
    ​[16:05] Jacques Van Wyk
        Tag asb vir Nicole op die issue


  - Where is data coming from for this asset
    - https://au.mixtelematics.com/#/fleet-admin/asset/details?id=-3737129301022214375&orgId=4089036243479131134

    - Assets live tracking list
      C:\Projects\MiXFleet\UI\Js\Tracking\Templates\live-tracking.html
      Show selected assets
      assetGridVisibleColumns
      assetGridColumns
        C:\Projects\MiXFleet\UI\Js\Tracking\Controllers\LiveTracking.ts
          
          assets

          IAssetRow
          
          * title: 'Ignition status', 'ignitionStatus'
          * title: 'Time in ignition', field: 'timeInIgnition'

          row.ignitionStatus === 'On'

          if ($dynamicScope.assets[i].isRemoraAsset || $dynamicScope.assets[i].isOysterAsset) { response.statuses[index].timeInIgnition = "";


          C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\Tracking\LiveTrackingModule.cs

            PopulateAssets
              getIgnitionStatuses
                GetIgnitionStatusAndEventsForAssets (2 diff calls)
                  Christo Boshoff (2 years ago)
                    TrackingManager.GetIgnitionStatusForAssetsByGroupId
                      
                      ** DeviceStateProxy.GetIgnitionStatesForMobileUnits
                      
                        DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel 
                          (GetIgnitionStatesForMobileUnits)
                            GetDeviceStatesForMobileUnits(mobileUnitIds, 
                            LogicalDevices.ALL_MOBILE_UNITS (0), 
                            Properties.IGNITION_STATE_CHANGE (6401396132085856906))

                              DeviceStateControllerRoutes.GetDeviceStatesForMobileUnits

                                [state].[MobileUnitState_GetStatesForMobileUnits]

                                  SELECT
                                    [MobileUnitId],
                                    [DeviceId],
                                    [PropertyId],
                                    [Value],
                                    [DateUpdated],
                                    [MessageDate]
                                  FROM
                                    [state].[MobileUnitState] mus WITH (NOLOCK) 
                                      INNER JOIN @mobileUnitIds mui ON mus.[MobileUnitId] = mui.[id]
                                                                  AND mus.[DeviceId]     = @deviceId
                                                                  AND mus.[PropertyId]   = @propertyId;



                    TrackingManager.GetIgnitionStatusForAssetsAssetIds

                      ** DeviceStateProxy.GetIgnitionStatesForMobileUnits


                    var timeNowInAssetStorageTimeZone = TimeZoneInfo.ConvertTime(ZonedDateTime.UtcNow.DateTime, TimeZoneInfo.Utc, status.StatusDate.TimeZone);
                    return new AssetIgnitionStatusCarrier
                    {
                      AssetId = status.AssetId.ToString(),
                      IgnitionStatus = status.IgnitionStatus.GetDescription(),
                      TimeInIgnition = status.IgnitionStatus == IgnitionStatus.On ? (timeNowInAssetStorageTimeZone - status.StatusDate.DateTime).ToHoursMinutesSecondsString() : string.Empty
                    };
        

    - Diagnostics window
      
      C:\Projects\MiXFleet\UI\Js\FleetAdmin\Templates\asset-diagnostics.html

        General status information 
        Vehicle mode
          generalStatusInfo.vehicleMode
          generalStatusInfo.vehicleTimeInMode

          generalStatusInfoG52.vehicleMode
          generalStatusInfoG52.vehicleTimeInMode

          generalStatusInfoRemora.vehicleMode
          generalStatusInfoRemora.vehicleTimeInMode

          generalStatusInfoOyster.vehicleMode
          generalStatusInfoOyster.vehicleTimeInMode

          generalStatusInfoYabby.vehicleMode
          generalStatusInfoYabby.vehicleTimeInMode

          mix4KDiagnosticsInfo.vehicleMode

        C:\Projects\MiXFleet\UI\Js\FleetAdmin\Controllers\assetDiagnostics.ts

          C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\DiagnosticsModule.cs

            AssetsManager.GetAssetDiagnosticInfo

              var fleetStatusValues = AssetsClient.GetStatusValuesAsync(orgId, assetId, securityAccounts).ConfigureAwait(false).GetAwaiter().GetResult();
              (MiX.Fleet.Services.Api.Client > GetStatusValuesAsync) <<<<<<< What happens here >>>>>>>
              [returns dto: VehicleStatus]

                -  [dynamix].[AssetStatusValues_Get]

                  SELECT
                    a.AssetId,
                    [VehicleStatus] = es.sValue,
                    [DownloadVehicleNow] = ed.sValue,
                    [VehicleLastOdo] = v.fLastOdo
                  FROM 
                    dbo.Vehicles v
                  INNER JOIN
                    dynamix.Assets a
                    ON a.VehicleId = v.iVehicleID
                  LEFT JOIN
                    ExtensionProperties es
                    ON es.liObjectID = v.iVehicleID AND
                      es.sAppID = 'FMSchedulerPro' AND 
                      es.sProperty = 'VehicleStatus'
                  LEFT JOIN
                    ExtensionProperties ed
                    ON ed.liObjectID = v.iVehicleID AND
                      ed.sAppID = 'FMSchedulerPro' AND 
                      ed.sProperty = 'DownloadVehicleNow'
                  WHERE
                    a.AssetId = @assetId

                var statusValues = fleetStatusValues.ToEntity();
                [puts it into a simpler object]

                  AssetStatusBagConverter.Convert(statusValues, orgId)
                  [puts values.VehicleStatus into bag string. 
                      
                      unitArmed > BagSerialiser.GetBool(bag, "UnitArmed", false); <<<<<<<<<< Different here >>>>>>>>>>
                      if (unitArmed) > assetStatus.TripStatus = TripStatus.OutOfTrip | assetStatus.TripStatus = TripStatus.InTrip;

                      assetStatus.TimeInMode = BagSerialiser.GetTimeSpan(bag, "TimeInMode");
                  ]

                    asd.AssetStatus.TripStatus
                    asd.AssetStatus.TimeInMode

            generalStatusInfo: 


            GeneralStatusInfoG52: 
            generalStatusInfoRemora: 
            generalStatusInfoOyster: 
            generalStatusInfoYabby: 

            mix4KDiagnosticsInfo: deviceStateProxy.GetMobileUnitVehicleMode


  - INTRO
    AU Team have noticed in Toll Group DB that the Ignition Status in Live Tracking is not working correctly
    vehicles are in in trip and Diagnostics screen shows the Asset is In Trip, but no Ignition Status does not show On\Off and sometimes does not show the key

    Organisation:Toll Group
    ![](SR-9374_IgnitionInTripIssue.png)

  - Info
    Comes from: https://jira.mixtelematics.com/browse/SR-1952
    (NOT) single or multiple vehicles independently
    (WORK) site or org
    since 18.5
    vehicles show a movement status but not time in ignition
    Apr 2018
    not always affect all vehicles at the same time and not alywas the same vehicles everytime

    I can confirm from the debug log "DEBUG20180718071936.log " in the attached zip file that the vehicle had Active ignition state (Event ID#32510) change at 10:17:13 and Ignition On was received .
    So the unit is sending the Ignition On event and being received via GPRS but does not update on Live Tracking
    From the FM.ActiveMessagesProcessor log ,does not seem "ignition on " is being captured
    
    after a few seconds to a minute you see the keys loading ... few assets where there key is not updated

    can also be seen in gprs diag vehicle list log

    This happens often enough on various databases (please note it can be any asset and not always the same asset ) and you can pick any database on UK for example and you are bound to catch this
    data-processing database is on its own RDS instance
