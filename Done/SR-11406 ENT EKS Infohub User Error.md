# SR-11406 ENT: EKS Infohub User Error (Exception Type: System.AggregateException)

Client | Local | INT | nuget | WRONG is for .16 need to make one for PROD!!
API | Local | INT
BE | Local | INT | xx TEST...

Config/MR/Bug/SR-11406_NewMethodForEnumWithSTMValue.21.13.PROD.ORI


I wrote a unit test for the old client and it does indeed return values for streamax.
I then saw that there are different classes in the BE and API, however, for other Infohub Streams things still work.

ISSUE Was not below, but the enum in those classes were different - fixed by using new method on new client

In the BE, the class is:
DynaMiX.DeviceConfig.Common.Entities.MobileUnitLevel.MobileUnitMapping
In the API, the class is:
MiX.DeviceIntegration.Common.Entities.MobileUnitLevel.MobileUnitMapping

---------
STM + PaOBC

System.Exception
  HResult=0x80131500
  Message=
{"StatusCode":200,"Body":"[

{\"LegacyOrganisationId\":9609,
\"LegacyVehicleId\":1,
\"OrganisationId\":-8386191436408769566,
\"MobileUnitId\":1175210057527095296,
\"AssetId\":1175210057527095296,
\"MobileDeviceType\":\"PHONE\",
\"UniqueIdentifier\":\"+27777777772\"},

{\"LegacyOrganisationId\":9609,
\"LegacyVehicleId\":2,
\"OrganisationId\":-8386191436408769566,
\"MobileUnitId\":1179100901469630464,
\"AssetId\":1179100901469630464,
\"MobileDeviceType\":\"STREAMAX\",
\"UniqueIdentifier\":null}]"}

  Source=DynaMiX.DeviceConfig.API.Client.Core
  StackTrace:
   at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.GetBody[T](JsonResponse response)
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitMappingsProxy.GetAssetMobileUnitMappingsByAssetIds(List`1 assetIds)
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitsForAssetIds(List`1 assetIds) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 226
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitIdsForCommandHistory(String authToken, Int64 groupId, List`1 assetIds) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 244
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetCommandsHistoryForMoibleUnitWithinDateRangeForList(String authToken, Int64 groupId, List`1 assetIds, DateTime from, DateTime to) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 233
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__7() in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\Feeds\FeedsManager.cs:line 647
   at System.Threading.Tasks.Task`1.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()

---------

IT DOES RETURN SOMETHING:
System.Exception
  HResult=0x80131500
  Message={"StatusCode":200,"Body":"[{\"LegacyOrganisationId\":9629,\"LegacyVehicleId\":2,\"OrganisationId\":-4224457008471550025,\"MobileUnitId\":1177009443285819392,\"AssetId\":1177009443285819392,\"MobileDeviceType\":\"STREAMAX\",\"UniqueIdentifier\":\"002B000A62\"},{\"LegacyOrganisationId\":9629,\"LegacyVehicleId\":4,\"OrganisationId\":-4224457008471550025,\"MobileUnitId\":1181656133991825408,\"AssetId\":1181656133991825408,\"MobileDeviceType\":\"STREAMAX\",\"UniqueIdentifier\":\"S11111M111\"}]"}
  Source=DynaMiX.DeviceConfig.API.Client.Core
  StackTrace:
   at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.GetBody[T](JsonResponse response)
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitMappingsProxy.GetAssetMobileUnitMappingsByAssetIds(List`1 assetIds)
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitsForAssetIds(List`1 assetIds) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 226
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitIdsForCommandHistory(String authToken, Int64 groupId, List`1 assetIds) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 244
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetCommandsHistoryForMoibleUnitWithinDateRangeForList(String authToken, Int64 groupId, List`1 assetIds, DateTime from, DateTime to) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 233
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__7() in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\Feeds\FeedsManager.cs:line 647
   at System.Threading.Tasks.Task`1.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()




>GET http://ent.mixtelematics.com:80/DynaMiX.API/info-hub/info-hub/group/5539479569806309004/stream/1712192615017397242/items?isPageLoad=true
     https://ent.mixtelematics.com/DynaMiX.API/info-hub/info-hub/group/5539479569806309004/stream/1712192615017397242/items?isPageLoad=true

1182114718211862528

"EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>
<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <RequestId>1182114718211862528</RequestId>
  <AuthToken>2c847b4b-c45b-4690-94e9-9eff7ae15905</AuthToken>
  <AccountId>3186871529335506034</AccountId>
  <RequestJson />
  <RequestUrl>GET http://ent.mixtelematics.com:80/DynaMiX.API/info-hub/info-hub/group/5539479569806309004/stream/1712192615017397242/items?isPageLoad=true</RequestUrl>
</ApiRequestInfo>
\tException Type: System.Exception
EXCEPTION! One or more errors occurred.
\tException Type: System.AggregateException
\tStack trace    at System.Threading.Tasks.Task.WaitAll(Task[] tasks, Int32 millisecondsTimeout, CancellationToken cancellationToken)
   at DynaMiX.Logic.Feeds.FeedsManager.GetFeedEntries(String authToken, Int64 orgId, Feed feed, Int64 correlationId, List`1& libraryEvents, Nullable`1 lastItemId, Boolean canAccessJMFeedItems, Boolean isPageLoad, Boolean lightningEnabled, Nullable`1 lastItemDate) in D:\\b\\1\\_work\\1301\\s\\Logic\\DynaMiX.Logic\\Feeds\\FeedsManager.cs:line 683   at DynaMiX.Api.NancyModules.InfoHub.InfoHubListModule.GetStreamItems(String authToken, Int64 orgId, Int64 streamId, String lastStreamItemId, String messageLatestDate, String isPageLoad, String lastStreamItemDate) in D:\\b\\1\\_work\\1301\\s\\API\\DynaMiX.API\\NancyModules\\InfoHub\\InfoHubListModule.cs:line 368
   at DynaMiX.Api.NancyModules.InfoHub.InfoHubListModule.<.ctor>b__20_4(Object args) in D:\\b\\1\\_work\\1301\\s\\API\\DynaMiX.API\\NancyModules\\InfoHub\\InfoHubListModule.cs:line 132
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\\b\\1\\_work\\1301\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 497
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\\b\\1\\_work\\1301\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\1\\_work\\1301\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\\b\\1\\_work\\1301\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148

EXCEPTION! One or more errors occurred.
\tException Type: System.AggregateException
\tStack trace    at System.Threading.Tasks.Task`1.GetResultCore(Boolean waitCompletionNotification)
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__16(Task`1 x) in D:\\b\\1\\_work\\1301\\s\\Logic\\DynaMiX.Logic\\Feeds\\FeedsManager.cs:line 657
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()

EXCEPTION! {\"StatusCode\":200,\"Body\":\"[{\\\"LegacyOrganisationId\\\":905,\\\"LegacyVehicleId\\\":1,\\\"OrganisationId\\\":5539479569806309004,\\\"MobileUnitId\\\":1177485892551995392,\\\"AssetId\\\":1177485892551995392,\\\"MobileDeviceType\\\":\\\"STREAMAX\\\",\\\"UniqueIdentifier\\\":\\\"002B021218\\\"},{\\\"LegacyOrganisationId\\\":905,\\\"LegacyVehicleId\\\":2,\\\"OrganisationId\\\":5539479569806309004,\\\"MobileUnitId\\\":1177486782610976768,\\\"AssetId\\\":1177486782610976768,\\\"MobileDeviceType\\\":\\\"STREAMAX\\\",\\\"UniqueIdentifier\\\":\\\"002B020867\\\"},{\\\"LegacyOrganisationId\\\":905,\\\"LegacyVehicleId\\\":3,\\\"OrganisationId\\\":5539479569806309004,\\\"MobileUnitId\\\":1177487011649335296,\\\"AssetId\\\":1177487011649335296,\\\"MobileDeviceType\\\":\\\"STREAMAX\\\",\\\"UniqueIdentifier\\\":\\\"002B010B09\\\"}]\"}
\tException Type: System.Exception


\tStack trace    at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.GetBody[T](JsonResponse response) in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.API.Client.Core\\ApiProxyBase.cs:line 127
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitMappingsProxy.GetAssetMobileUnitMappingsByAssetIds(List`1 assetIds)



   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitIdsForCommandHistory(String authToken, Int64 groupId, List`1 assetIds) in D:\\b\\1\\_work\\1301\\s\\Logic\\DynaMiX.Logic\\ConfigAdmin\\Integration\\MobileUnitLevel\\CommandManager.cs:line 244
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetCommandsHistoryForMoibleUnitWithinDateRangeForList(String authToken, Int64 groupId, List`1 assetIds, DateTime from, DateTime to) in D:\\b\\1\\_work\\1301\\s\\Logic\\DynaMiX.Logic\\ConfigAdmin\\Integration\\MobileUnitLevel\\CommandManager.cs:line 232
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__15() in D:\\b\\1\\_work\\1301\\s\\Logic\\DynaMiX.Logic\\Feeds\\FeedsManager.cs:line 647
   at System.Threading.Tasks.Task`1.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()
",

----

Secondly I saw this user is working on Streamax Standalone, however, this might not be relevant.

----

EXCEPTION! <?xml version="1.0" encoding="utf-16"?>
<ApiRequestInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RequestId>1181707495542935552</RequestId>
  <AuthToken>db40f729-c782-4d1e-828d-ccef146ed1d1</AuthToken>
  <AccountId>3186871529335506034</AccountId>
  <RequestJson />
  <RequestUrl>GET http://ent.mixtelematics.com:80/DynaMiX.API/info-hub/info-hub/group/5539479569806309004/stream/1712192615017397242/items?isPageLoad=true</RequestUrl>
</ApiRequestInfo>
	Exception Type: System.Exception

EXCEPTION! One or more errors occurred.
	Exception Type: System.AggregateException
	Stack trace    at System.Threading.Tasks.Task.WaitAll(Task[] tasks, Int32 millisecondsTimeout, CancellationToken cancellationToken)
   at DynaMiX.Logic.Feeds.FeedsManager.GetFeedEntries(String authToken, Int64 orgId, Feed feed, Int64 correlationId, List`1& libraryEvents, Nullable`1 lastItemId, Boolean canAccessJMFeedItems, Boolean isPageLoad, Boolean lightningEnabled, Nullable`1 lastItemDate) in D:\b\1\_work\1301\s\Logic\DynaMiX.Logic\Feeds\FeedsManager.cs:line 683
   at DynaMiX.Api.NancyModules.InfoHub.InfoHubListModule.GetStreamItems(String authToken, Int64 orgId, Int64 streamId, String lastStreamItemId, String messageLatestDate, String isPageLoad, String lastStreamItemDate) in D:\b\1\_work\1301\s\API\DynaMiX.API\NancyModules\InfoHub\InfoHubListModule.cs:line 368
   at DynaMiX.Api.NancyModules.InfoHub.InfoHubListModule.<.ctor>b__20_4(Object args) in D:\b\1\_work\1301\s\API\DynaMiX.API\NancyModules\InfoHub\InfoHubListModule.cs:line 132
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args) in D:\b\1\_work\1301\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 497
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1() in D:\b\1\_work\1301\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 287
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\b\1\_work\1301\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 214
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\1301\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 148

EXCEPTION! One or more errors occurred.
	Exception Type: System.AggregateException
	Stack trace    at System.Threading.Tasks.Task`1.GetResultCore(Boolean waitCompletionNotification)
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__16(Task`1 x) in D:\b\1\_work\1301\s\Logic\DynaMiX.Logic\Feeds\FeedsManager.cs:line 657
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()

EXCEPTION! {"StatusCode":200,"Body":"[{\"LegacyOrganisationId\":905,\"LegacyVehicleId\":1,\"OrganisationId\":5539479569806309004,\"MobileUnitId\":1177485892551995392,\"AssetId\":1177485892551995392,\"MobileDeviceType\":\"STREAMAX\",\"UniqueIdentifier\":\"002B021218\"},{\"LegacyOrganisationId\":905,\"LegacyVehicleId\":2,\"OrganisationId\":5539479569806309004,\"MobileUnitId\":1177486782610976768,\"AssetId\":1177486782610976768,\"MobileDeviceType\":\"STREAMAX\",\"UniqueIdentifier\":\"002B020867\"},{\"LegacyOrganisationId\":905,\"LegacyVehicleId\":3,\"OrganisationId\":5539479569806309004,\"MobileUnitId\":1177487011649335296,\"AssetId\":1177487011649335296,\"MobileDeviceType\":\"STREAMAX\",\"UniqueIdentifier\":\"002B010B09\"}]"}
	Exception Type: System.Exception
	Stack trace    at DynaMiX.DeviceConfig.API.Client.Core.ApiProxyBase.GetBody[T](JsonResponse response) in C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.API.Client.Core\ApiProxyBase.cs:line 127
   at DynaMiX.DeviceConfig.Services.API.Client.Proxies.MobileUnitLevel.MobileUnitMappingsProxy.GetAssetMobileUnitMappingsByAssetIds(List`1 assetIds)
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetMobileUnitIdsForCommandHistory(String authToken, Int64 groupId, List`1 assetIds) in D:\b\1\_work\1301\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 244
   at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.GetCommandsHistoryForMoibleUnitWithinDateRangeForList(String authToken, Int64 groupId, List`1 assetIds, DateTime from, DateTime to) in D:\b\1\_work\1301\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 232
   at DynaMiX.Logic.Feeds.FeedsManager.<>c__DisplayClass86_0.<GetFeedEntries>b__15() in D:\b\1\_work\1301\s\Logic\DynaMiX.Logic\Feeds\FeedsManager.cs:line 647
   at System.Threading.Tasks.Task`1.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()