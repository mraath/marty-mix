# CONFIG-2954 Config group issue for STM Streamax Standalone

```sql
-- Device
SELECT top 5 * FROM definition.Devices dd WHERE dd.DeviceId = -1064000195705392069

--Mobile Device
SELECT top 5 * FROM definition.MobileDevices dmd WHERE dmd.DeviceKey = 24469

--Mobile Device Line
SELECT top 5 * FROM   definition.MobileDeviceLines dmdl WHERE  dmdl.MobileDeviceKey = 24469

--Mobile Device Line Peripheral Device
SELECT top 5 * FROM   definition.MobileDeviceLinePeripheralDevices dmdlpd WHERE dmdlpd.LineKey = 137 AND dmdlpd.MobileDeviceKey = 24469

--Peripheral Device
SELECT top 5 * FROM definition.Devices dd WHERE DeviceKey IN (19064, 25607)

--EF showing same but faster
SELECT [Extent1].[MobileDeviceLinePeripheralDeviceId] AS [MobileDeviceLinePeripheralDeviceId],[Extent1].[DateUpdated] AS [DateUpdated],[Extent1].[UserName] AS [UserName],[Extent1].[DefinitionMobileDeviceId] AS [DefinitionMobileDeviceId],[Extent1].[DefinitionLineId] AS [DefinitionLineId],[Extent1].[DefinitionPeripheralDeviceId] AS [DefinitionPeripheralDeviceId]
FROM   [dynamix].[MobileDeviceLinePeripheralDevices] AS [Extent1]
WHERE  [Extent1].[DefinitionMobileDeviceId] = -1064000195705392069 /* @p__linq__0 */
```

OLD
			<dependency id="-8855237937362189122" parentId="-1064000195705392069" type="2" autoConnect="1" childRequired="1" info="Streamax Standalone" />
			<dependency id="6687205802664729998" parentId="-1064000195705392069" type="2" autoConnect="1" childRequired="1" info="Streamax Standalone" />
NEW
			<dependency id="-8855237937362189122" parentId="-1064000195705392069" type="1" autoConnect="1" childRequired="1" info="Streamax Standalone" />
			<dependency id="6687205802664729998" parentId="-1064000195705392069" type="1" autoConnect="1" childRequired="1" info="Streamax Standalone" />


"message": "EXCEPTION! <?xml version=\"1.0\" encoding=\"utf-16\"?>

<ApiRequestInfo xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">

 <RequestId>1177333206837587968</RequestId>

 <AuthToken>5d9361c4-cfb5-48f1-888b-835d405321cf</AuthToken>

 <AccountId>8913709627074943104</AccountId>

 <RequestJson />

 <RequestUrl>GET http://integration.mixtelematics.com:80/DynaMiX.API/config-admin/organisations/-4224457008471550025/mobile-device-template-lines/-7112151420158651482</RequestUrl>

</ApiRequestInfo>

\tException Type: System.Exception

EXCEPTION! Sequence contains more than one matching element

\tException Type: System.InvalidOperationException

\tStack trace at System.Linq.Enumerable.SingleOrDefault[TSource](IEnumerable`1 source, Func`2 predicate)

 

at DynaMiX.Api.Carriers.ConfigAdmin.AllLevels.ConfigAdminConverters.CreateLinesCarrier(IMobileDevice md, LibraryMobileDevice libraryMobileDevice, List`1 allLinesForDevice, List`1 allPeriperhalDeviceLinks, List`1 allParameters, List`1 allLibraryDeviceParameters, UserProfile currentUserProfile)
 in D:\\b\\2\\_work\\730\\s\\API\\DynaMiX.API\\Carriers\\ConfigAdmin\\AllLevels\\ConfigAdminConverters.cs:line 769
 
 

at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.MobileDeviceTemplateCrudModule.GetLines(String authToken, Int64 orgId, Int64 mobileDeviceTemplateId, String strDuplicate)
 in D:\\b\\2\\_work\\730\\s\\API\\DynaMiX.API\\NancyModules\\ConfigAdmin\\TemplateLevel\\MobileDeviceTemplateCrudModule.cs:line 211
 
 
at DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.MobileDeviceTemplateCrudModule.<.ctor>b__1_3(Object args)
 in D:\\b\\2\\_work\\730\\s\\API\\DynaMiX.API\\NancyModules\\ConfigAdmin\\TemplateLevel\\MobileDeviceTemplateCrudModule.cs:line 92
 
 

at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_0`1.<RegisterRoute>b__0(Object args)
 in D:\\b\\2\\_work\\730\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 497
 
 
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_1`1.<HandleTyped>b__1()
 in D:\\b\\2\\_work\\730\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 287
 
 
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func`1 method)
 in D:\\b\\2\\_work\\730\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 214
 
 
at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func`1 method)
 in D:\\b\\2\\_work\\730\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 148
"
