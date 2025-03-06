---
created: 2023-02-27T09:17
updated: 2023-10-19T08:15
---

Parent:: [[Config Support]]
[[Video]]

## Zonika

### Eg Log

```txt
https://app.logz.io/#/dashboard/osd/discover/?_a=(columns:!(AppName,message),filters:!((%27$state%27:(store:appState),meta:(alias:!n,disabled:!f,index:%27logzioCustomerIndex*%27,key:Env,negate:!f,params:(query:ZA),type:phrase),query:(match_phrase:(Env:ZA)))),index:%27logzioCustomerIndex*%27,interval:auto,query:(language:lucene,query:%22GetCameraSettingsExtendedV2%22),sort:!(!(%27@timestamp%27,desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-5h,to:now))&accountIds=true&switchToAccountId=157279
```


### SQL

```sql
use DeviceConfiguration  
declare @StandaloneKey int  = (select DeviceKey from definition.MobileDevices where MobileDeviceType = 11)  
declare @activeUnits  dbo.SelectionIds ;  
declare @affectedUnits  dbo.SelectionIds ;

--------------------------

declare @CommissionedMobileUnits  dbo.SelectionIds ;

  
insert into @CommissionedMobileUnits  
select mu.MobileUnitId from   
mobileunit.MobileUnits mu  
where  
--mu.MobileUnitId in (select Id from @MobileUnits) and   
( mu.MobileDeviceKey = @StandaloneKey and mu.UniqueIdentifier is not null)

insert into @CommissionedMobileUnits  
select mu.MobileUnitId from   
mobileunit.MobileUnits mu  
left join mobileunit.AssetProperties ap on mu.MobileUnitId = ap.AssetId and PropertyId  = -4477362625925416557  
where  
--mu.MobileUnitId in (select Id from @MobileUnits) and   
(mu.MobileDeviceKey != @StandaloneKey and ap.Value is not null)

--select * from @CommissionedMobileUnits  
--exec library.GetConnectedStreamaxInfo @CommissionedMobileUnits

declare @CameraDeviveKeys dbo.selectionIds  
insert into @CameraDeviveKeys select DeviceKey from definition.Devices where DeviceId in (-7099857649368562188,311792233444052589,-565349616809011552)

insert into @activeUnits  
select mu.MobileUnitId /*, case when (mu.MobileDeviceKey = @StandaloneKey) then 1 else 0 end as IsStandalone,  
case when (ap.value is null) then mu.UniqueIdentifier else ap.value end as SerialNo,  
d.DeviceId ,lpd.Description */  
from mobileunit.MobileUnits mu  
inner join template.ConfigurationGroups cg on mu.ConfigurationGroupKey = cg.ConfigurationGroupKey   
inner join template.MobileDeviceTemplates mut on cg.MobileDeviceTemplateKey = mut.MobileDeviceTemplateKey  
inner join template.Devices td on cg.MobileDeviceTemplateKey = td.MobileDeviceTemplateKey and IsEnabled = 1 and td.DeviceKey in (select id from @CameraDeviveKeys)  
inner join definition.Devices d on td.DeviceKey = d.DeviceKey   
inner join library.Devices ld on td.DeviceKey = ld.devicekey and ld.LibraryKey = cg.LibraryKey  
inner join library.PeripheralDevices lpd on lpd.LibraryDeviceKey = ld.LibraryDeviceKey  
left join mobileunit.AssetProperties ap on mu.MobileUnitId = ap.AssetId and PropertyId  = -4477362625925416557  
where  
mu.MobileUnitId in (select Id from @CommissionedMobileUnits)

--------------------------

insert into @affectedUnits  
select * from @activeUnits where id not in (

Select    mu.MobileUnitId /*as MobileUnitId,  
        SUBSTRING(ldc.Channel, 3,5) as Channel,  
        ISNULL(lcn.Name,ldc.Channel) as 'Description'*/  
from  
        [mobileunit].[MobileUnits] mu  
        INNER JOIN   
        @CommissionedMobileUnits ids ON ids.id = mu.MobileUnitId  
        JOIN   
        [template].[ConfigurationGroups] cg on mu.ConfigurationGroupKey = cg.ConfigurationGroupKey  
        JOIN   
        [template].[DeviceChannels] dc WITH (NOLOCK) on cg.MobileDeviceTemplateKey = dc.MobileDeviceTemplateKey  
        JOIN  
        [library].[DeviceChannels] ldc on dc.DeviceChannelKey = ldc.LibraryDeviceChannelKey  
        LEFT OUTER JOIN  
        [library].[CameraNames] lcn on dc.LibraryCameraNameKey = lcn.LibraryCameraNameKey  
  
        )  
select count (*) from @affectedUnits

select mu.ConfigurationGroupKey, MobileUnitId, librarykey, mobiledevicetemplatekey from mobileunit.MobileUnits mu  
inner join template.ConfigurationGroups cg on mu.ConfigurationGroupKey = cg.ConfigurationGroupKey  
   where MobileUnitId in (select id from @affectedUnits) order by 3

select distinct librarykey  from template.ConfigurationGroups a where a.ConfigurationGroupKey in (  
select ConfigurationGroupKey from mobileunit.MobileUnits where MobileUnitId in (select id from @affectedUnits))  
order by 1
```


### Servers

- Check of API OK is
- Check of stadig is...
	- TODO: MR: Figure out how

## Zeshan

```sql
SELECT * FROM FMOnlineDB.dbo.organisation with (NOLOCK) WHERE liOrgID = (SELECT Organisationid FROM  [FMOnlineDB].dynamix.Organisations do  where groupid = -1475012061198152466)

use UnitedNationsNiger_2019;

select CONCAT(',', CAST(AssetId as varchar)) stsId  
from dynamix.assets;
```

- I take the groupid from the alert. 
- And then run the V2 endpoint for the outputs from dynamix.assets query. 
	- Mobile Unit
	- http://api.deviceconfig.za.dub.production.local/swagger/ui/index#!/MobileUnit/MobileUnit_GetCameraSettingsExtendedV2
- Then we check for items which are provider type Streamax/MixVision but not returning any channels.

Zonika has a finer script where she checks the whole IDC for issues - I suggest you take hers as well.

## A typical issue

EXCEPTION! Unable to retrieve GetCameraSettingsExtendedV2 from Device Config for organisation -8208289087590769024. Exception Type: System.Exception EXCEPTION! The request was canceled due to the configured HttpClient.Timeout of 120 seconds elapsing. Exception Type: System.Threading.Tasks.TaskCanceledException Stack trace at MiX.Core.Retries.ElasticRetryStrategy.ShouldRetry(String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExitRetryAsync(String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Retries.RetryStrategy.ExecuteActionWithTraceAsync[T](Func`1 func, Action`1 validateResult, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.Core.Clients.HttpRetries.GetAsync[T](Func`1 requestFunc, String callerMemberName, String callerFilePath, Int32 callerLineNumber) at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitRepository.GetCameraSettingsExtendedV2(String authToken, Int64 groupId, List`1 assetIds, Nullable`1 correlationId) at MiX.Video.Services.Logic.Assets.AssetManager.GetDeviceConfigCameraSettingsAsync(Int64 organisationId, List`1 assetIds, Nullable`1 correlationId) in /home/ubuntu/myagent2/_work/5652/s/MiX.Video.Services.Logic/Assets/AssetManager.cs:line 985 EXCEPTION! The operation was canceled. Exception Type: System.TimeoutException EXCEPTION! The operation was canceled. Exception Type: System.Threading.Tasks.TaskCanceledException Stack trace at System.Net.Http.HttpConnection.SendAsyncCore(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken) at System.Net.Http.HttpConnectionPool.SendWithVersionDetectionAndRetryAsync(HttpRequestMessage request, Boolean async, Boolean doRequestAuth, CancellationToken cancellationToken) at System.Net.Http.DiagnosticsHandler.SendAsyncCore(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken) at System.Net.Http.DecompressionHandler.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken) at System.Net.Http.HttpClient.<SendAsync>g__Core|83_0(HttpRequestMessage request, HttpCompletionOption completionOption, CancellationTokenSource cts, Boolean disposeCts, CancellationTokenSource pendingRequestsCts, CancellationToken originalCancellationToken) EXCEPTION! Unable to read data from the transport connection: Operation canceled. Exception Type: System.IO.IOException Stack trace at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.ThrowException(SocketError error, CancellationToken cancellationToken) at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.System.Threading.Tasks.Sources.IValueTaskSource<System.Int32>.GetResult(Int16 token) at System.Net.Http.HttpConnection.InitialFillAsync(Boolean async) at System.Net.Http.HttpConnection.SendAsyncCore(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken) EXCEPTION! Operation canceled Exception Type: System.Net.Sockets.SocketException


## Remote Jumpbox IISRESET

- Powershell
- psexec \\hsentiis42 cmd
- iisreset
