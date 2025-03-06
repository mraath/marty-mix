---
status: closed
date: 2023-06-19
comment: 
priority: 8
---

# MTT-498 Command Sent twice

Date: 2023-06-19 Time: 11:22
Parent:: [[Command]] [[IMEI]]
Friend:: [[2023-06-19]]
JIRA:MTT-498 Command Sent twice
[MTT-498 REG - Allocating IMEI to MiX3000 seems to go through twice, resulting in a "not defined" message - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/MTT-498)

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## PRs

- 

## Description

- Triggered twice for 3000
- Mobile Unit Id: 1327783003366899712
- IMEI: 300020236131645
- mobile-units/1327783003366899712/imei/300020236131645/allocate-imei
- allocate-imei
- already has an IMEI assigned to it
	- C:\Projects\DynaMiX.DeviceConfig\DynaMiX.DeviceConfig.Logic\Managers\MobileUnitLevel\MobileUnitManager.cs
		- AllocateMobileUnitIMEI
	- client: AllocateMobileUnitIMEI
	- API
		- Route: AllocateMobileUnitIMEI
	- Logging?
		- AllocateMobileUnitIMEI mobileUnitId
		- Attempting to allocate IMEI to asset
		- 
	- Swagger:
		- http://api.deviceconfig.int.development.domain.local/swagger/ui/index#!/MobileUnit/MobileUnit_AllocateMobileUnitIMEI
```Log
https://app.logz.io/#/dashboard/osd/discover/?_a=(columns:!(message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('AllocateMobileUnitIMEI%20mobileUnitId','Attempting%20to%20allocate%20IMEI%20to%20asset',AllocateMobileUnitIMEI,'already%20has%20an%20IMEI%20assigned%20to%20it'),type:phrases,value:'AllocateMobileUnitIMEI%20mobileUnitId,%20Attempting%20to%20allocate%20IMEI%20to%20asset,%20AllocateMobileUnitIMEI,%20already%20has%20an%20IMEI%20assigned%20to%20it'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'AllocateMobileUnitIMEI%20mobileUnitId')),(match_phrase:(message:'Attempting%20to%20allocate%20IMEI%20to%20asset')),(match_phrase:(message:AllocateMobileUnitIMEI)),(match_phrase:(message:'already%20has%20an%20IMEI%20assigned%20to%20it'))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-10d,to:now))&accountIds=157986&switchToAccountId=157279
```

## INT Test

[MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/commissioning?id=1405594814812758016&orgId=-7950239061577934052)
id=1405594814812758016
orgId=-7950239061577934052
IMEI: 862096045420663

[MiX Telematics - Assets](https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=1407712035682283520&orgId=-7950239061577934052&mobileNumber=)
id=1407712035682283520
orgId=-7950239061577934052
IMEI: 862096045420000

{ "ErrorMessage": "AllocateMobileUnitIMEI mobileUnitId : 1407712035682283520 | Exception message: Specified argument was out of the range of valid values.\r\nParameter name: Device registration failed - incorrect mobile device specified | Inner message: ", "StackTrace": " at DynaMiX.DeviceConfig.Logic.Managers.MobileUnitLevel.MobileUnitManager.AllocateMobileUnitIMEI(String authToken, Int64 mobileUnitId, Int64 Imei) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Logic\\Managers\\MobileUnitLevel\\MobileUnitManager.cs:line 3160\r\n at DynaMiX.DeviceConfig.Services.API.Controllers.MobileUnitLevel.MobileUnitController.<>c__DisplayClass65_0.<AllocateMobileUnitIMEI>b__0() in D:\\a\\1\\s\\DynaMiX.DeviceConfig.Services.API\\Controllers\\MobileUnitLevel\\MobileUnitController.cs:line 1382\r\n at MiX.DeviceIntegration.Core.Controllers.ControllerBase.HandledResponse[T](String route, Func`1 method) in D:\\a\\1\\s\\DynaMiX.DeviceConfig.API.Core\\Controllers\\ControllerBase.cs:line 45", "ExceptionType": "System.Exception" }

ID: 1405594814812758016
IMEI: 862096045420663

## Notes

- Derek mentions it also happens via swagger. This shows it it not tool specific, but the end-point call is causing this.
- MiX.DeviceConfig.Api.Client
- 