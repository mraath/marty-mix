---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-11-18T10:54
---

# OE-519 API Populate Lastposition for Asset List

Date: 2024-05-08 Time: 08:02
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-05-08]]
JIRA:OE-519 [API] Populate Lastposition for Asset List
[JIRA](https://csojiramixtelematics.atlassian.net/browse/OE-519)

## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Image Summary

ADD IMAGE

## Description

![[OE-519 API Populate Lastposition for Asset List Fleet page.png|400]]

## Current Code

- [ ] Last Position
	- FE: **lastAvl**
		- getAssetListPage
	- BE: getAssetListPage
		- GET_ASSET_LIST_PAGE
		- GetAssetListPage
		- carrier.Items.Add(assetDetails.**ToAssetListItem**(LanguagingGateway, groups, CurrentUserProfile, canIAddAssets, canIEditAssets, canIDeleteAssets, canIAccessAssetDiagnostics, canISeeTimeline, canAccessHistoricalTracking, canAccessAdministrativeInformation, canResendCommissioningRequest, historicalTimeZonesForEntities, sourceDataTimezone, licenceReminder, serviceReminder, rwcReminder, canAccessConfigGroups, aempAssets));
			- carrier.LastAvl = assetDetails.**AssetConfigDetails.LastAvl**?.ToHistoricalTimeZone(assetDetails.Asset.AssetId, historicalTimeZonesForEntities, sourceDataTimezone).ToCarrier();
			- if (carrier.LastAvl != null)
				carrier.LastAvlInUtc = ZonedDateTime.**ToTimeZone**(carrier.LastAvl.ToZonedDateTime(), TimeZoneInfo.Utc.DisplayName).ToCarrier();
			
		- taskGetLatestPositionsForAssetsByGroupId = Task List GPSReading Factory.StartNew(() => TrackingManager.GetLatestPositionsForAssetsByGroupId(authToken: authToken, orgId: org.GroupId, groupIds: new Listlong () { groupId }, correlationId: correlationId, filter: false)).ContinueWith(a => positions = a.Result);
		- ...
		- GetLatestPositionsForAssetsByAssetIds (A LOT HAPPENS)
			- SPLIT... BASE_BEACON_FUNCTIONALITY = -2156593089855370790
				-   DECLARE @DeviceKey INT = (SELECT [DeviceKey] FROM [definition].[Devices] WITH (NOLOCK) WHERE [DeviceId] = @deviceId);
					- LOADS
				- LightningTrackingRepository.GetLatestPositionsForAssets
				- BeaconPositionsRepository.GetLatestBeaconPositions
					- beaconPosition.CalculatedPosition
					- ResourceDataClient.BeaconPositions.GetLatestAsync (can we ignore this????)

```txt
//this should be removed when MiX.Fleet.Services is included
private ITrackingRepository _lightningTrackingRepository;
[ExcludeFromCodeCoverage]
public ITrackingRepository LightningTrackingRepository
{
	get { return _lightningTrackingRepository ?? (_lightningTrackingRepository = DynaMiX.Data.Lightning.Tracking.TrackingRepository.Instance); }
	set { _lightningTrackingRepository = value; }
}

var positions = LightningTrackingRepository.GetLatestPositionsForAssets(orgId, assetIdsNoTabs, correlationId, out List<long> otherTabAssetIds, useDefaultDriverIfNotAvailable: useDefaultDriverIfNotAvailable, cachedSince: cachedSince, reverseGeo: reverseGeo);

```

## Fleet 

Repo: [LatestPositions - Search Code - Search](https://dev.azure.com/MiXTelematics/Fleet/_search?action=contents&text=LatestPositions&type=code&lp=buildrelease-Project&filters=ProjectFilters%7BFleet%7D&pageSize=25&result=DefaultCollection/Fleet/Fleet.Services.LatestPositions/GBmaster//Fleet.Services.LatestPositions/Fleet.Services.LatestPositions.Dtos/ApiControllerRoutes.cs)

- LatestPositions.ByAssetIds
- var result = await FleetServicesRealtimeTrackingDataClient.LatestPositions.GetLatestByAssetIdsAsync("a", new List long> { 2 }, 10,null).ConfigureAwait(false);
- Fleet.Services.LatestPositions.Logic.GroupManager
	- GetAuthorisedAssetIdsAsync

- Client?: MiX.Fleet.Services.Api.Client.GetLatestByAssetIdsAsync
	- IList Position> positions = await FleetServicesDataClient.Positions.GetLatestByAssetIdsAsync(TestParams.AssetIds, 10, null).ConfigureAwait(false);
	- PagedResult Position> pagedResult = await FleetServicesDataClient.Positions.GetSinceByAssetIdsPagedAsync(assetIds, DateTime.UtcNow.AddHours(-2), 100).ConfigureAwait(false);
- **ERROR**: Type not found, please register MiX.Fleet.Services.Api.Client.IPositionsRepository


## Test Bench Units Ettienne

3b1def7d-2c49-4e21-9ff5-ed0f90f54f59

-7094567047859310012

Config Groups sent: 
[-2803813420773469362,2557659825063191210,-6039078778185809084,3189959622678903378,-6578464666737983883,1989001888637459309,-9078750292130215188,1232298188016006398,4631052128945276764,-3251388662902899727,-1624999688046064271,6805621304279462498,5918913735931167160,-2573155336697877595,4129288096883125748,8727678327962475491,5763517337881168111,-6234566316505424845,-3695105512554797542,-5831608836261800088,8799631723342597089,8312559892687542597,-1323496424401963304,1913716828197566524,5621177276048465690,-1304497542036362428,-8126655682067440340,-6836621200088256507,3780592447908270856,-7193205268329688567,1223784011986591945,-3366261590319731458,-2413576874196688261,-7392764503748298046,-7629839428314466340,7187708927592996236,-1635591222982510535,-6151357456724753887,-5912082017677079777,-5390337933230695538,-4067179943998429825,1364631742777966163,-7653538731568077332,-7668187040444806181,4208572072426061348,3362884251134407151,-3893536691584770708,-6084966262084607888,3774723236452900354,-2723417818245426945,7518319533563758380,3813205176926613669,5916945531324722255,-5159253166163790691,-2147059355369176559,60036256406525452,767833652034630589,-6328313109361883502,1287625066743264402,2505696365882641504,1240957115574012888,-2374899645906010889,3739189965094689367,8235264728202292851,-1136609960426082090,4505193432618700901,6775426529790173259,-3798194295803321659,-8871627763454545305,-2110415703208626075,6143152948325390557,2237002883694620525,-6366678994605550120,881148683257612107,3559248872843565414,3168786260864673578,-8642220154752102213,5009320484667002586,-8507561780508819492,7115023718153513169,8724893352726780856,-383605210349505097,-2310911944299775966,-2320806248371712183,-5340634987676521615,4263282101255212968]

## Maybe like this

```c#
FleetServicesDataClient.RegisterRepository(GetType().Namespace, Settings.FleetServicesApiUrl);
services.AddSingleton(FleetServicesDataClient.Positions);

private IAssetsRepository _assetsRepo;
public IAssetsRepository AssetsRepo
{
	get
	{
		if (_assetsRepo == null)
		{
			if (!DependencyRegistry.IsRegistered<IAssetsRepository>())
			{
				FleetServicesDataClient.RegisterRepository(GetType().Namespace,
					SettingsProviderFactory.GetProvider(CoreConstants.ServiceName).GetString(CoreConstants.SettingNames.MiXFleetServicesApiUrl));
				DependencyRegistry.Register(() => FleetServicesDataClient.Assets);
			}
			_assetsRepo = DependencyRegistry.GetInstance<IAssetsRepository>(false);
		}
		return _assetsRepo;
	}
	set
	{
		_assetsRepo = value;
	}
}
```

## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## TESTING

### Issue

```xml
"StackTrace": " at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.ConfigurationGroupManager.<ConvertToAssetsListCarrier>d__24.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\TemplateLevel\\ConfigurationGroupManager.cs:line 301\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at 
System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at System.Runtime.CompilerServices.TaskAwaiter`1.GetResult()\r\n at DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.ConfigurationGroupManager.<SetAdditionalAssetsListValues>d__23.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\TemplateLevel\\ConfigurationGroupManager.cs:line 279\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at 
System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at 
System.Runtime.CompilerServices.TaskAwaiter`1.GetResult()\r\n at 
DynaMiX.DeviceConfig.Logic.Managers.TemplateLevel.ConfigurationGroupManager.<GetConfigurationGroupsMultiselectAssetsList>d__21.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Logic\\Managers\\TemplateLevel\\ConfigurationGroupManager.cs:line 251\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at 
System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.TemplateLevel.ConfigurationGroupController.<>c__DisplayClass3_0.<<GetConfigurationGroupsMultiselectAssetsList>b__0>d.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.Services.API\\Controllers\\TemplateLevel\\ConfigurationGroupController.cs:line 107\r\n--- End of stack trace from previous location where exception was thrown ---\r\n at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n at System.Runtime.CompilerServices.ConfiguredTaskAwaitable`1.ConfiguredTaskAwaiter.GetResult()\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.<HandledResponseAsync>d__3`1.MoveNext() in C:\\Projects\\DynaMiX.DeviceConfig\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 105",
```


## Code

- PR : [Pull request 114222: OE-519: Added logic to retrieve the last position - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/114222)

## Current Status

![[OE-519 API Populate Lastposition for Asset List No all expected ones have last positions.png]]

- Taking this up with Fleet
- TEST VALS:

21fca4d2-31d8-4439-8d38-e3304ef101f8

OrgId:
-7094567047859310012
Config Groups sent: 
-2803813420773469362,2557659825063191210,-6039078778185809084,3189959622678903378,-6578464666737983883,1989001888637459309,-9078750292130215188,1232298188016006398,4631052128945276764,-3251388662902899727,-1624999688046064271,6805621304279462498,5918913735931167160,-2573155336697877595,4129288096883125748,8727678327962475491,5763517337881168111,-6234566316505424845,-3695105512554797542,-5831608836261800088,8799631723342597089,8312559892687542597,-1323496424401963304,1913716828197566524,5621177276048465690,-1304497542036362428,-8126655682067440340,-6836621200088256507,3780592447908270856,-7193205268329688567,1223784011986591945,-3366261590319731458,-2413576874196688261,-7392764503748298046,-7629839428314466340,7187708927592996236,-1635591222982510535,-6151357456724753887,-5912082017677079777,-5390337933230695538,-4067179943998429825,1364631742777966163,-7653538731568077332,-7668187040444806181,4208572072426061348,3362884251134407151,-3893536691584770708,-6084966262084607888,3774723236452900354,-2723417818245426945,7518319533563758380,3813205176926613669,5916945531324722255,-5159253166163790691,-2147059355369176559,60036256406525452,767833652034630589,-6328313109361883502,1287625066743264402,2505696365882641504,1240957115574012888,-2374899645906010889,3739189965094689367,8235264728202292851,-1136609960426082090,4505193432618700901,6775426529790173259,-3798194295803321659,-8871627763454545305,-2110415703208626075,6143152948325390557,2237002883694620525,-6366678994605550120,881148683257612107,3559248872843565414,3168786260864673578,-8642220154752102213,5009320484667002586,-8507561780508819492,7115023718153513169,8724893352726780856,-383605210349505097,-2310911944299775966,-2320806248371712183,-5340634987676521615,4263282101255212968
AssetIds
6965744936508783037,-351340188657890982,561063410736288763,-1509415348226618365,718292796933432336,-1629872805059908821,4330632591323826186,5471039436101346631,8591433084324666187,-7898078755312382716,-5571036686525372154,-487099210781207563,-2400739638495017620,2605092282528473783,3980370543921406804,-3568704900018955967,-7372220517297457835,6619140184874941023,1960215487085322743,-5398209883147130589,8453184716134157942,-1420821188649460346,-8798513244981487643,-77084972695804791,6352868507267210399,9041905456165491651,-2566631210551839364,-8154404092019945206,1487203582401446190,6110269613484206734,385546989186155125,428038740665402589,9037182319420900846,-6093589015108786614,5462472039999562707,-9103134062234322075,-1436518455494287400,3065190090238196290,-7880200560742896983,-4601934880781338916,5220957640519426075,-7944612955031932038,6202634302154772208,-5289234407494698690,-5778725809378181741,-5741934008120200948,285627126655899114,5789784288897901485,-1048316439302019403,-2010430715896929118,5820972418063655678,2470993014782142827,815570521779811467,-6001402197670163376,4652568470569725043,8472800361954900260,875152636819304448,875153008833097728,875153519347003392,876177853005955072,877710264581238784,891045912992641024,896048144449376256,896049209051811840,896049509624025088,897912059234684928,898669516716036096,902610260701687808,903770958271782912,906620209168420864,910581628547760128,918999411886190592,921162922238017536,921876619485716480,929075052857430016,939666162685087744,961771371649101824,963923937065295872,991822140767916032,992584879909847040,994671091961847808,1001613961174667264,1012760267171442688,1025877634710908928,1032708589107937280,1049836233367126016,1050512003934437376,1058508924801683456,1086004667345240064,1086005172591616000,1090810795210461184,1103468413108256768,1126282101021749248,1129866710152437760,1165090258749702144,1169761256085917696,1174121359466622976,1190746654440419328,1203125089031266304,1218337931713843200,1218663808783880192,1260466398248566784,1261022055236780032,1268715391402156032,1271956122944516096,1281416329857847296,1286359368359346176,1300872402540445696,1300900116186021888,1304944792448704512,1312134441394237440,1328864713399943168,1330271646099005440,1352074163187445760,1357761845640413184,1367583529694339072,1377406610580889600,1383257475299938304,1401709835162300416,1403102293298126848,1415760817642536960,1419106263577133056,1450923827225116672,1469076319857348608,1469095385309450240,1469096269519065088,1473200846719332352,1488621931651624960,1530033300976836608,1535591859690287104,1535592576039804928,1544808996514410496,1557797963201785856,1567997168892022784,1580637547360481280,1582451417241710592,1586129270148222976

- Fixed by changing 10 to 1
- PR: [Pull request 114328: OE-519: Fixed up the Fleet call to get last positions - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/114328)
- 

## TEST 2

![[OE-519 API Populate Lastposition for Asset List All Matched.png|700]]
## Test Values

![[OE Swagger Test]]