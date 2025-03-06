---
status: closed
date: 2023-06-12
comment: Edwin busy testing
priority: 1
---

# BME-7 New Config Endpoint for Mesa with Magix

Date: 2023-06-12 Time: 14:48
Parent:: ==xxxx==
Friend:: [[2023-06-12]]
JIRA:BME-7 New Config Endpoint for Mesa with Magix
[BME-7 Config End Point for Magix enabled MESA assets - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/BME-7)

## Branch

- Config/MR/Feature/BME-7_GetMAgixEnabledDevices.INT.23.10.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...


## Enhancements

- Fix up the stored proc to be faster
	- [x] Zonika idea re commissioned units only ✅ 2023-07-07
	- [x] Zonika idea re Split mu into muMesa and mu2K ✅ 2023-06-21

## Message to Edwin

Hi Edwin.

Nicole het gevra dat ek net vir jou laat weet sodra ons Client reg is vir julle.

En dit is ⁠![Smile](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png?v=v82) Ek copy net ook vir Zonika in want ek gaan so stuk-stuk op verlof.

Hier is meer inligting. ASB laat weet as enige iets nie lekker werk nie.

Client: MiX.DeviceConfig.Api.Client   
    - Version: 2023.11.20230622.1   
    - Method: GetAssetsWithMagixEnabled  
    - Eg: DeviceConfigClient.MobileUnits.GetAssetsWithMagixEnabled(authToken, assetIds

## Test Data Generator

```txt
C:\Projects\_MiXTelematicsFiles\SQL\BME-7 Getting test data.sql
```

## Dev Testing

Steps I will follow to test:  
- [x] Ensure swagger is present ✅ 2023-06-22
- [x] Test swagger ✅ 2023-06-22
- [x] Get different units that meet different requirements ✅ 2023-06-22
- [x] Ensure the end-point returns what was expected ✅ 2023-06-22
- [x] Run the same test against the DEV Client ✅ 2023-06-22 NOT going to do this
Once all of this works I will merge the work into INT, do a quick smoke test (as per the above steps) and then notify Edwin that the client is ready for their testing.


[5053773743511449532,-3028975957513854309,-257800022027621760,-8738319009525872963,453419282973214646,1306659720780808192,-563295055051394035,3142237181704029682,453419282973214646,1306659720780808192,-8855274534670356739,-8095217398774153496,-9074228615869797807,-9041178464723512786,1171605900751024128,1245816480703991808]

## INT Smoke Testing

- [x] SP ✅ 2023-06-23
- [x] Common ✅ 2023-06-22
	- MiX.DeviceIntegration.Common.2023.11.20230622.2
- [x] Client ✅ 2023-06-22
	- MiX.DeviceConfig.Api.Client.2023.11.20230622.1
- [x] API ✅ 2023-06-23

Steps I will follow to test:  
- [x] Ensure swagger is present ✅ 2023-06-23
	- http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnit/MobileUnit_GetAssetsWithMagixEnabled
- [x] Test swagger ✅ 2023-06-23
- [x] Get different units that meet different requirements ✅ 2023-06-23
- [x] Ensure the end-point returns what was expected ✅ 2023-06-23
- [x] Run the same test against the INT Client ✅ 2023-06-23
	- Client: MiX.DeviceConfig.Api.Client 
	- Version: 2023.11.20230622.1 
	- Method: GetAssetsWithMagixEnabled
	- Eg: DeviceConfigClient.MobileUnits.GetAssetsWithMagixEnabled(authToken, assetIds

[-30156720251069003,982522234087915674,4652568470569725043,-6001402197670163376,-3568704900018955967,-8798513244981487643,-939744863415457496,6768955903611875805,-2010430715896929118,902610260701687808,-1420821188649460346,1048352635867435008,-9216778440535481252,-9102057751495072954,1240074017994993664,1260692708024733696]

```c#
//Call
GetAssetsWithMagixEnabled_Test(authToken.Result.AuthToken).Wait();

//Test
private static async Task GetAssetsWithMagixEnabled_Test(string authToken)
{
	try
	{
		long correlationId = 1234567890;
		List<long> assetIds = new List<long>()
		{
			-30156720251069003, 982522234087915674, 4652568470569725043, -6001402197670163376, -3568704900018955967, -8798513244981487643, -939744863415457496, 6768955903611875805, -2010430715896929118, 902610260701687808, -1420821188649460346, 1048352635867435008, -9216778440535481252, -9102057751495072954, 1240074017994993664, 1260692708024733696
		};
		var result = await DeviceConfigClient.MobileUnits.GetAssetsWithMagixEnabled(authToken, assetIds, correlationId).ConfigureAwait(false);
	}
	catch (Exception ex)
	{
		throw new Exception($"GetAssetsWithMagixEnabled_Test Exception: {ex}");
	}
}
```


|Description|
|'IDeviceStateRepository' does not contain a definition for 'SetAssetCurrentDriver' and no accessible extension method 'SetAssetCurrentDriver' accepting a first argument of type 'IDeviceStateRepository' could be found (are you missing a using directive or an assembly reference?)|
|'IDeviceStateRepository' does not contain a definition for 'GetAssetCurrentDriver' and no accessible extension method 'GetAssetCurrentDriver' accepting a first argument of type 'IDeviceStateRepository' could be found (are you missing a using directive or an assembly reference?)|
|'IDynamicCANRepository' does not contain a definition for 'GetSciptsByVinNumbers' and no accessible extension method 'GetSciptsByVinNumbers' accepting a first argument of type 'IDynamicCANRepository' could be found (are you missing a using directive or an assembly reference?)|
|'IDynamicCANRepository' does not contain a definition for 'GetSciptsByPartialVinAndProfile' and no accessible extension method 'GetSciptsByPartialVinAndProfile' accepting a first argument of type 'IDynamicCANRepository' could be found (are you missing a using directive or an assembly reference?)|
|There is no argument given that corresponds to the required parameter 'isDefaultScript' of 'IDynamicCANRepository.GetParametersByVinAndProfile(string, string, string, long?, string, bool, long?)'|
|There is no argument given that corresponds to the required parameter 'isDefaultScript' of 'IDynamicCANRepository.SetDefaultConfigurationGroup(string, long, long, InstallationProfile, string, bool, long?)'|

## PRs

- 

## Notes

- GetAssetsWithMagixEnabled
- GetAssetsWithMagixEnabled = "assets/assets-magix-enabled"
- [x] Just investigate where IMEI comes from here: MobileUnitDiagnosticData ✅ 2023-06-15
	- [mobileunit].[MobileUnit_GetDiagnosticData]


## Description

**OVERVIEW**

With the production of the MiX2000 coming to an end and more Teltonika devices being installed the SVR / Consumer pool of MBSs are dwindling

We want to be able to use the Fleet units, that report into MiX Fleet Manager, to assist in the SVR recoveries by being able to update the Beame hotlist on these units

Lightning will interact with the SVR system to provide them with the details of units that can be used and the SVR system will then use MiX Connect to send the command to update the hotlist on said units

**SOLUTION**

Lightning will provide Config with a **list of assets**
- I guess it can be mixed from different orgs

Config then need to check which of the assets are MESA devices as well as MagiX enabled and provide the list back to Lightning
 - Check Mesa, Magix enabled
Result list needs to include **AssetId** and **IMEI** number.
- return AssetId, IMEI

[[MESA]] devices that are supported are MiX2000, MiX2310i, MiX4000, MiX6000, MiX6000LTE
- Ensure all these form part of base mesa - I think NOT, so need to do check for all of these?

The MiX4000, MiX6000, MiX6000LTE all have a logical on the Mobile device called MagiX which can be enabled. Config needs to check for assets where this is enabled as well as set to “South Africa” in the region dropdown list on the logical
- id="2661058860026395155" systemName="MobileDevice.Logical.Base.MESA"
	- id="3352815766478435451" parentId="-5678077773610990815"  info="MobileDevice.MiX3000"
	- id="1631390394071057047" parentId="6183256567829462590" info="MobileDevice.MiX4000"
	- id="9204629559663997882" parentId="-7681409220681262334" info="MobileDevice.MiX6000" 
	- id="-8905517274669236579" parentId="7771696109990054209" info="MobileDevice.MiX6000LTE"
- 4k, 6k, 6kLTE: Magix enabled and set to South Africa
- [x] How do I find out this value (state?) ✅ 2023-07-07
- MagixRegion = -4936028342195377168
- MESA_MAGIX = 5877065296627456209
- MIX_2000_MAGIX_SWITCH = -597238459336397838
- LibraryFeatures.MIX_2000_MAGIX_SWITCH
- assetsWithMagixENabled.AddRange(_mobileUnitManager.GetAllAssetsThatHaveDeviceEnabled(orgId, LogicalDevices.REMOTE_COMMAND));
	- [mobileunit].[MobileUnit_GetAllAssetsThatHaveDeviceEnabled]
	- [[SQL Is Device Enabled]]
	- 
- device id="5877065296627456209" type="130" systemName="System.Logical.MESA.Magix" legacyId="-600011"

The MiX2000/2310i make use of a Database Admin / Organisation setting to enable MagiX so this option needs to be checked when filtering the list for MiX2000/2310i
- 2K, 2310i
- id="3628142212283117612" systemName="MobileDevice.Logical.MIX2XXX"
	- id="295341957383281927" info="MobileDevice.MiX2310i"
	- id="-7108317066627388644" parentId="-4791134254654685492" info="MobileDevice.MiX2500"
	- ? MobileDevice.MiX2000 id: -4791134254654685492
- [x] How read DB Admin / Org Settings ✅ 2023-06-12
- [x] First check UI for this ✅ 2023-06-12
- ![[BME-7 New Config Endpoint for Mesa with Magix DB Admin Org Settings.png | 400]]
- https://integration.mixtelematics.com/DynaMiX.API/operations/database-admin/organisations/-745583745890447042/details
- ![[BME-7 New Config Endpoint for Mesa with Magix DB Org Settings Fuller Picture.png]]
- org.MiX2310iMagixSwitch = DeviceConfigClient.Library.GetMagixSwitch(authToken, orgId).ConfigureAwait(false).GetAwaiter().GetResult();
- org.MiX2310iMagixEnabled = org.MiX2310iMagixSwitch.SwitchEnabled;
- MiX2310iMagixEnabled
- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\LibraryLevel\LibrariesManager.cs
	- GetMagixSwitch

## Next steps

- [x] Zonika? From what I could see all the IMEI values are their unique identifiers ✅ 2023-06-15
- [x] SP create and add to DEV  ✅ 2023-06-21
	- [mobileunit].[MobileUnit_GetAssetsWithMagixEnabled]
- [x] Common class to return SP vals  ✅ 2023-06-21
	- AssetIMEI
	- Local Nuget: MiX.DeviceIntegration.Common.2023.6.15.1-_alpha_
	- DEV: MiX.DeviceIntegration.Common.2023.6.19.1-_beta_
- [x] API to call SP  ✅ 2023-06-21
- [x] Client to call API  ✅ 2023-06-21
	- Local Nuget: MiX.DeviceConfig.Api.Client.2023.10.20230615.1-alpha
	- DEV: MiX.DeviceConfig.Api.Client.2023.11.20230619.1-_beta_

## Tests performed on INT

- Ensured that swagger was working and giving correct results.
- Tested these results against SQL results.
- Values tested:
	- 2k with magix enabled (2 of 2 returned correctly)
	- 2k without magix enabled (0 of 2 returned correctly)
	- Mesa with magix enabled (2 of 2 returned correctly)
	- Mesa with magix disabled (0 of 2 returned correctly)
	- Mesa with SA region selected (2 of 2 returned correctly)
	- Mesa with other region selected (0 of 2 returned correctly)
	- 2 units of type 3k,  2 units of type FM (0 of 4 returned correctly)
- Final: From 16 units tested. 6 were expected to be returned and they were correctly.
- The client also returned the same results correctly.
- Once finalised I will release the client to the Lightning team for testing.


## API idea

- Get List from Lightning
	- [x] SP1: Send to DB ✅ 2023-06-15
		- Only return units that are: MiX4000, MiX6000, MiX6000LTE, MiX2000, MiX2310i 
			- Dictionary long, string  GetAssetIdsByMobileDeviceType(int mobileDeviceType);
				- EF
			- Something like [mobileunit].[MobileUnit_GetDefinitionMobileDeviceType] but for all AssetIds sent in
			- COULD do this and all below in ONE, however, maybe better to resuse logic if not too many calls
		- Return: OrgId, MobileUnitId, AssetId, IMEI, DeviceType
			- ? Properties.UNIT_IMEI (imei.PropertyId = 9188780602356317147)
			- List MobileUnitDeviceProperty GetEffectiveDevicePropertiesForOrganisation(long groupId, List long deviceIds, List long propertyIds);
				- [mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets]
			- 
	- Get from these only 
		- [x] SP2: 1) MiX4000, MiX6000, MiX6000LTE (MAGIX only, no reuse) ✅ 2023-06-15
			- Magix endow and 
				- ? assetsWithMagixEnabled.AddRange(_mobileUnitManager.GetAllAssetsThatHaveDeviceEnabled(orgId, LogicalDevices.MESA_MAGIX)); -- 5877065296627456209
				- bool magixEnabled = buildContext.IsDeviceEnabled(ConfigConstants.LogicalDevices.MESA_MAGIX);
				- var region = buildContext.DevicePropertyValue string (ConfigConstants.LogicalDevices.MESA_MAGIX, DeviceProperties.MagixRegion); -- MagixRegion = -4936028342195377168L;
			- set to South Africa
				- ? Above ?
			- Mobileunit.cs
				- List AssetIdDeviceEnabled  DoesAssetsHaveDeviceEnabled(List long  assetId, long deviceId);
					- [mobileunit].[MobileUnit_DoesAssetsHaveDeviceEnabled] <<
				- Task List MobileUnitDeviceProperty GetEffectiveDevicePropertyForAssets(long deviceId, long propertyId, List long  assetIds);
					- [mobileunit].[MobileUnit_GetEnabledDevicePropertyForAssets] <<
 
		- [x] REUSE Call: 2) MiX2000, MiX2310i ✅ 2023-06-15
			- LibrariesManager.cs (GetMagixSwitch) (for each unique orgid)


## To test swagger against INT

[1359564563752579072, 890287547921436672, -8306991262843924143, 1181656133991825408, 1273119596725624832, 896048144449376256, -6001402197670163376, 921876619485716480, 876177853005955072, 1058508924801683456, 285627126655899114, -7944612955031932038, 4652568470569725043, 3980370543921406804, -3568704900018955967, -8798513244981487643, 8183302055614241769, -4095364047729793634, -2010430715896929118, -2201749711304336601, -4233403834547652329, 5595870818868450099, 1266118685836046336, 1266463391764152320, 1268715391402156032, 1289747749118976000, 1296555112851664896]

## Temp Results

|GroupId|MobileUnitId|AssetId|MobileDeviceType|UniqueIdentifier|MobileUnitKey|ConfigurationGroupKey|IsEnabled|MobileUnitId|Value|
|---|---|---|---|---|---|---|---|---|---|
|-7094567047859310012|896048144449376256|896048144449376256|3|357865090007407|43292|13346|0|NULL|NULL|
|-7094567047859310012|-6001402197670163376|-6001402197670163376|2|358014092582732|42006|11794|NULL|NULL|NULL|
|-7094567047859310012|921876619485716480|921876619485716480|2|357865090097275|43467|11157|NULL|NULL|NULL|
|-7094567047859310012|876177853005955072|876177853005955072|3|352739092727301|42202|13259|0|NULL|NULL|
|-7094567047859310012|1058508924801683456|1058508924801683456|3|867698043689473|51807|14845|1|1058508924801683456|1|
|-7094567047859310012|285627126655899114|285627126655899114|2|357520070024209|40696|11157|NULL|NULL|NULL|
|-7094567047859310012|-7944612955031932038|-7944612955031932038|2|358014091272038|40464|8993|NULL|NULL|NULL|
|-7094567047859310012|4652568470569725043|4652568470569725043|2|357865090002556|40830|11795|NULL|NULL|NULL|
|-7094567047859310012|3980370543921406804|3980370543921406804|3|NULL|39184|9049|1|3980370543921406804||
|-7094567047859310012|-3568704900018955967|-3568704900018955967|3|359739070333653|39306|9077|1|-3568704900018955967|1|
|-7094567047859310012|-8798513244981487643|-8798513244981487643|3|359739070335021|39438|11820|1|-8798513244981487643|1|
|9071626151746619630|8183302055614241769|8183302055614241769|3|352753090097443|40350|20939|1|8183302055614241769|1|
|9071626151746619630|-4095364047729793634|-4095364047729793634|3|NULL|40410|8239|1|-4095364047729793634|1|
|-7094567047859310012|-2010430715896929118|-2010430715896929118|3|359739071743991|40741|11811|1|-2010430715896929118|1|
|-7750872404908407349|-2201749711304336601|-2201749711304336601|3|352739092829057|40769|11784|1|-2201749711304336601|2|
|-7750872404908407349|-4233403834547652329|-4233403834547652329|3|359739075961045|40770|11784|1|-4233403834547652329|2|
|9071626151746619630|5595870818868450099|5595870818868450099|3|111112222233333|40809|11791|1|5595870818868450099|1|
|8308618011429325423|1266118685836046336|1266118685836046336|3|357796109970105|81477|20887|1|1266118685836046336|1|
|8308618011429325423|1266463391764152320|1266463391764152320|3|862096042559430|81579|20887|1|1266463391764152320|1|
|-7094567047859310012|1268715391402156032|1268715391402156032|3|862096045423881|82253|14174|1|1268715391402156032|1|

## Orgs with 2K Magix switch on

|GroupId|SwitchEnabled|
|---|---|
|718936554657957186|true|
|1686880341835301320|true|
|-3546769396127904813|true|
|2307906436721054420|true|
|5385940956949618384|true|
|-5070807911028103534|true|
|-5084765707469832155|true|
|1725370532876952291|true|
|8308618011429325423|true|
|-5904178910191067669|true|
|636686262553736774|true|
|8071296543227367712|true|
|-7950239061577934052|true|
|4213776961640473572|true|
|1663677034850116341|true|
|-2651494262647416239|true|
|8312047944944256095|true|
|6254858201810488363|true|
|-8289142940340318290|true|
|-3357872117347178042|true|
|1533302774335945922|true|
|-8838767714224234488|true|


## Test data

3980370543921406804
-3568704900018955967
-8798513244981487643
8183302055614241769
-4095364047729793634
-2010430715896929118
-2201749711304336601
-4233403834547652329
5595870818868450099
1266118685836046336
1266463391764152320
1268715391402156032
1289747749118976000
1296555112851664896
1296618197666852864
1296669911870697472
987407718801211392
981339706032013312
981342248732344320
981342976272121856
981343937208139776
1087897616120922112
1087898440490401792
1087899887198126080
1087900542067392512
1088626124914176000
1088626727891513344
1095805091155349504
1095930912368459776
1103468413108256768
966780056903172096
1118287453895991296
1119755518265102336
1121594177851879424
1123408597808381952
997267908188672000
997960999805390848
1006664005020061696
1229888245660397568
1231347515182120960
1233199317626839040
1241067456829632512
1241074068776595456
1241156988148285440
1241173216113770496
1241499140705271808
1243325742038913024
1241093193554288640
1248696042079469568
1259272230648549376
1358184293731315712
1298446878021255168
1303768644246278144
982804581716074496
1307107437339590656
1296534226421510144
934578293987999744
1033119244225961984
1038216097570762752
1055183117946544128
1058508924801683456
1062877358247784448
1065007198718320640
1070040646364872704
1070865422769045504
1086005172591616000
1086432405619081216
1086715405999521792
1086720958729535488
1086721908311572480
1086726492464480256
-5652648187454626571
902610260701687808
916814065809768448
916844281969180672
921864525742809088
921864649416056832
921865388636971008
921865682989031424
921865943274954752
921865007542509568
923637896576532480
929075052857430016
933072920995459072
933075831372673024
933078799140548608
933091859569864704
933093183090880512
934569668640899072
934571333174689792
934574533450530816
934575770300448768
934577263878602752
957416195949666304
5555179247145043406
1180306726709129216
1181678400530583552
1181727744879132672
1188141773441318912
1190054656369377280
1066464376694390784
1195764336946081792
1206994340894609408
1221156044810207232
1222221269480202240
1162166496051109888
1165450040487145472
1166455758635888640
1099083105329283072
1148682708207599616
1150220084081082368
1157441158900621312
1157448205192929280
1157462144555425792
1157800888393158656
1128384873414344704
1312520538482106368
1313913631005425664
1243602756271247360
1322300161978978304
1328829321233645568
1341551524062945280
1352074163187445760
1311761990979985408
1367868816215670784
1369418902007709696
1387242671361097728
1391162816179523584
1390139981072822272
3772523737395817690
938466701555871744
1395482110318391296
1398051663322787840
1400868297840279552
1403443740501114880