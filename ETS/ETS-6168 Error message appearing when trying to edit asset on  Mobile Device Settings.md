---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-10-06T14:31
---

# ETS-6168 Error message appearing when trying to edit asset on  Mobile Device Settings

Date: 2025-10-06 Time: 12:46
Parent:: ==xxxx==
Friend:: [[2025-10-06]]
JIRA:ETS-6168 Error message appearing when trying to edit asset on  Mobile Device Settings
[JIRA](https://powerfleet.atlassian.net/browse/ETS-6168)


## TODO
```dataviewjs
function callout(text, type) {
    const allText = ` [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Shorter Description

Please assist to investigate an fix an issue with Mobile Device Settings Error.

Client receives the following Error when trying to access Mobile Device Settings from Edit asset.  
I can replicate it.

**Error no: 1710364084475101184**

I tried removing VIN, Fleet number, modify asset description and Rego but still received the same error.  
NOC can confirm this matter is not widespread and only affecting the assets  
-----------------------------------------

AU Server  
Database: Kangaroo Bus Lines  

Assets:  
KBL109 - vehicle id: 84
KBL132 - vehicle id: 162
KBL133 - vehicle id: 163
KBL137 - vehicle id: 168

---
New error code: **1710761460204969984**

{"appName":"DynaMiX.Api", "correlationId":"0f0f787d-99e3-4165-8426-dc5ce92200f8", "env":"AU", "level":"_Exception_", "machine":"HSSYDIIS57", "message":"_EXCEPTION_! ?xml version="1.0" encoding="utf-16"?  
ApiRequestInfo xmlns:xsd="[XML Schema](http://www.w3.org/2001/XMLSchema) " xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance "http://www.w3.org/2001/XMLSchema-instance")"  
RequestId1710761460204969984/RequestId  
AuthTokendc45b332-7d16-4d68-b9d8-3b1f283d0e4a/AuthToken  
AccountId-1097352631732482421/AccountId  
RequestJson /  
RequestUrlGET [http://au.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/1361650601860089062/-2402082675730223969/RequestUrl](http://au.mixtelematics.com/DynaMiX.API/fleet-admin/assets/commissioning/1361650601860089062/-2402082675730223969%3C/RequestUrl%3E%3E "http://au.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/1361650601860089062/-2402082675730223969%3C/RequestUrl%3E%3E")  
/ApiRequestInfo  
_Exception_ Type: System._Exception_  
_EXCEPTION_! Sequence contains more than one matching element  
_Exception_ Type: System.InvalidOperationException  
Stack trace at System.Linq.Enumerable.SingleOrDefault[TSource](IEnumerable`1 source, Func`2 predicate)  
at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.**GetAssetConfigDetails**(String authToken, Int64 orgId, Int64 assetId) in D:\b\1\_work\499\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 731  
at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.GetPreChangeAssetSnapshot(String authToken, Int64 orgId, Int64 assetId, IMobileUnitManager mobileUnitManager, IMobileDevice resolvedMobileDevice, MobileUnit mobileUnit, ConfigurationGroup configurationGroup) in D:\b\1\_work\499\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 255  
at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.GetPreChangeAssetSnapshotNote(String authToken, Int64 orgId, Int64 assetId, IMobileUnitManager mobileUnitManager, IMobileDevice resolvedMobileDevice, MobileUnit mobileUnit, ConfigurationGroup configurationGroup) in D:\b\1\_work\499\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 312  
at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.GetAssetCommissioning(String authToken, Int64 groupId, Int64 assetId) in D:\b\1\_work\499\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 1219  
at DynaMiX.Core.Http.Nancy.ModuleBase.c__DisplayClass46_0`1.RegisterRouteb__0(Object args) in D:\\b\\1\\_work\\499\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 499 at DynaMiX.Core.Http.Nancy.ModuleBase.c__DisplayClass27_1`1.HandleTypedb__1() in D:\b\1\_work\499\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 288  
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method) in D:\\b\\1\\_work\\499\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 215 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method) in D:\b\1\_work\499\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 149  
", "otherData":{"CorrelationId64":"1710761460204969984"}, "severity":"info", "team":"Common"}


## Code

IProperty gprsContextProperty = gprsDevice.Properties.FirstOrDefault(p => p.DefinitionPropertyId == ConfigConstants.Properties.GPRS_CONTEXT);
GPRS_CONTEXT = 3931884001975002043L

IPeripheralDevice speedInput = resolvedMobileDevice.AllPeripheralDevices.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.SPEED_SENDER)
SPEED_SENDER = 4772957056880862604L

MobileUnitProperty speedCalibrationDateProperty = mobileUnit.MobileUnitProperties.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.SPEED_SENDER && x.DefinitionPropertyId == ConfigConstants.Properties.CALIBRATION_DATE)
SPEED_SENDER = 4772957056880862604L
CALIBRATION_DATE = 1858632875970657593L

MobileUnitProperty speedCalibrationPulsesProperty = mobileUnit.MobileUnitProperties.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.SPEED_SENDER && x.DefinitionPropertyId == ConfigConstants.Properties.CALIBRATION_PULSES)
SPEED_SENDER = 4772957056880862604L
CALIBRATION_PULSES = -1839190682764262989L


IPeripheralDevice rpmInput = resolvedMobileDevice.AllPeripheralDevices.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.RPM_SIGNAL
RPM_SIGNAL = -8257517697897011867L

MobileUnitProperty rpmCalibrationDateProperty = mobileUnit.MobileUnitProperties.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.RPM_SIGNAL && x.DefinitionPropertyId == ConfigConstants.Properties.CALIBRATION_DATE)
RPM_SIGNAL = -8257517697897011867L
CALIBRATION_DATE = 1858632875970657593L

MobileUnitProperty rpmCalibrationPulsesProperty = mobileUnit.MobileUnitProperties.FirstOrDefault(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.RPM_SIGNAL && x.DefinitionPropertyId == ConfigConstants.Properties.CALIBRATION_PULSES
RPM_SIGNAL = -8257517697897011867L
CALIBRATION_PULSES = -1839190682764262989L





