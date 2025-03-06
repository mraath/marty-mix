---
status: closed
date: 2023-04-11
comment: 
priority: 8
---

# CONFIG-3663 Make Available Ford OEM

Date: 2023-04-11 Time: 16:32
Parent:: [[Make Available]]
Friend:: [[2023-04-11]]
JIRA:CONFIG-3663 Make Available Ford OEM
[CONFIG-3663 Make Available: Ford OEM - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-3663)

## PRs

- DEV: [Pull request 82378: CONFIG-3663 Make Available Ford OEM. Needed these paramaters for event dependencies of the device. - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/82378)
- PAUL: [Pull request 83268: CONFIG-3663 We no longer require the injection of the event since it was shor... - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/83268?_a=files)
- INT: [Pull request 84189: CONFIG-3663: Merged to INT - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/84189)

## Branch

https://dev.azure.com/MiXTelematics/Common/_git/Database?version=GBConfig/MR/CONFIG-3663
- (ORI) Config/MR/CONFIG-3663
- (INT) Config/MR/CONFIG-3663_INT_NA

## STEPS to get all the parameterIds and fix the make available

### 1) Run the script to get all parameter Ids

```sql
--NOTE: This script will try to get all the top level device event parameter Ids and child dependency device event parameter Ids
DECLARE @systemName NVARCHAR(50) = 'MobileDevice.Ford'; --<-- Specify the Device you want to work with

USE DeviceConfiguration;
DECLARE @libId INT = -1; --Default Library

-- DEVICE
DECLARE @deviceKey INT = (SELECT DeviceKey FROM definition.Devices WHERE SYSTEMNAME = @systemName)

-- Add the above as a devicekey and then add all child devices
DECLARE @deviceKeys TABLE (
 deviceKey INT
);

INSERT INTO @deviceKeys VALUES(@deviceKey);
INSERT INTO @deviceKeys (deviceKey)
(
    SELECT DISTINCT dp.ChildDeviceKey
    FROM definition.DeviceDependencies dp WITH (NOLOCK)
    INNER JOIN library.Devices lpd
    ON dp.ParentDeviceKey = lpd.DeviceKey
    AND dp.DependencyType != 3 --Excluded
    AND lpd.LibraryKey = @libId
    AND dp.ParentDeviceKey = @deviceKey
)

--      Return Parameters (13)
SELECT DISTINCT ParameterId FROM definition.Parameters 
    WHERE ParameterKey IN 
        (SELECT ReturnParameterKey FROM definition.Events WITH (NOLOCK)
            WHERE EventKey IN 
            (SELECT EventKey FROM [definition].[DeviceEventDependencies] ddep WITH (NOLOCK)
                INNER JOIN @deviceKeys dk ON dk.deviceKey = ddep.deviceKey))
    OR ParameterKey IN (
--      Event Condition Parameters ()
        SELECT DISTINCT ParameterKey FROM library.EventConditions WITH (NOLOCK)
            WHERE LibraryKey IN (-1)
            AND EventKey IN 
                (SELECT EventKey FROM [definition].[DeviceEventDependencies] ddep WITH (NOLOCK)
                    INNER JOIN @deviceKeys dk ON dk.deviceKey = ddep.deviceKey))

```
### 2) Get Parameter Examples
- Find an eg. for each parameter in DevicesData.xml
- copy them to the <parameters\> section of this device
- replace the Ids making use of FMOnlineDB.dbo.GenerateBigId()
- Check this in
- Build
- Deploy

### 3) Try to make the Device available
- Check for the parameterId exception
```txt
EXCEPTION_! All required parameters for this event have not been satisfied - ParameterId:
```
- Find which peripheral device is associated with it in order to add all of it's parameter ids
- Look for this in the log 
```txt
Make Required Event Available for definition device " ...
```
- OR go one by one
- OR debug the code here... and look for all definitionDeviceIdsForNewDevicesAdded Ids and then look for all their events > conditions > parameters
```c#
foreach (long definitionDeviceId in definitionDeviceIdsForNewDevicesAdded)
{
	DmXLogger.Log($"Make Required Event Available for definition device {definitionDeviceId} with orgId : {orgId}", LogLevel.Debug);
	MakeRequiredEventsAvailalble(
		authenticationToken, ...
```

### 4) A good Log to use for the above, without code debugging
```txt
https://app.logz.io/#/dashboard/osd/discover/?_a=(columns:!(message,AppName),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:DEV),type:phrase),query:(match_phrase:(Env:DEV))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!(oem,'Required%20parameter','All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied','Make%20Required%20Event%20Available%20for%20definition%20device','All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied%20-%20ParameterId'),type:phrases,value:'oem,%20Required%20parameter,%20All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied,%20Make%20Required%20Event%20Available%20for%20definition%20device,%20All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied%20-%20ParameterId'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:oem)),(match_phrase:(message:'Required%20parameter')),(match_phrase:(message:'All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied')),(match_phrase:(message:'Make%20Required%20Event%20Available%20for%20definition%20device')),(match_phrase:(message:'All%20required%20parameters%20for%20this%20event%20have%20not%20been%20satisfied%20-%20ParameterId'))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:'2023-05-08T09:00:00.000Z',to:now))&accountIds=true&switchToAccountId=157279
```





## Trying to find the device dependencies

```c#
var parentPeripheralDevices = from DeviceDependency dp in Context.DeviceDependencies
																		join LibraryPeripheralDevice lpd in Context.LibraryPeripheralDevices
																			on dp.DefinitionParentDeviceId equals lpd.DefinitionDeviceId
																		where lpd.LibraryId == libId
																		select dp;

			var childPeripheralDevices = from DeviceDependency dp in Context.DeviceDependencies
																	 join LibraryPeripheralDevice lpd in Context.LibraryPeripheralDevices
																		 on dp.DefinitionChildDeviceId equals lpd.DefinitionDeviceId
																	 where lpd.LibraryId == libId
																	 select dp;

			var parentLogicalDevices = from DeviceDependency dp in Context.DeviceDependencies
																 join LibraryLogicalDevice lld in Context.LibraryLogicalDevices
																	 on dp.DefinitionParentDeviceId equals lld.DefinitionDeviceId
																 where lld.LibraryId == libId
																 select dp;

			var childLogicalDevices = from DeviceDependency dp in Context.DeviceDependencies
																join LibraryLogicalDevice lld in Context.LibraryLogicalDevices
																	on dp.DefinitionChildDeviceId equals lld.DefinitionDeviceId
																where lld.LibraryId == libId
																select dp;

			return parentPeripheralDevices.Union(childPeripheralDevices.Union(parentLogicalDevices.Union(childLogicalDevices))).Distinct().ToList();
```
allDeviceDependencies.Where(x => x.DefinitionParentDeviceId == definitionDeviceId && x.DependencyType != DeviceDependencyType.Excluded)

## LAST Device dependency


### 20230504

```xml
<device id="-3492265442579611717" type="0" systemName="MobileDevice.Ford">
	<mobile description="Ford OEM" handler="10" sort="250" tracer="1" legacy="160" dsiType="Ford" uniqueProperty="VIN" mobileDeviceType="10" />
	<parameters>
		<parameter id="419758195567078910" parameterId="981729539706373388" info="(" />
		<parameter id="-5471605322550817983" parameterId="-8722384628719264678" calibrationType="8" info="In trip (drive)" />
		<parameter id="7967239613507134593" parameterId="-3161730702566266071" calibrationType="9" info="Fuel level" />
		<parameter id="13819618129808016" parameterId="-8380423587615480304" info=")" />
		<parameter id="-8087611402605218563" parameterId="-2155824911768570108" calibrationType="9" info="In Sub-trip" />
		<parameter id="-4165867368246880923" parameterId="-2360174318529543484" calibrationType="9" info="EV CAN: State of charge thousands" />
		<parameter id="-3297533164098710664" parameterId="73181982975249219" calibrationType="9" info="FM CAN: Seat Belt State" />
		<parameter id="8400052578983629865" parameterId="837209246865036953" calibrationType="9" info="FM CAN: Passenger Seat Belt Status" />
		<parameter id="3932346976772481079" parameterId="2638979532023225991" calibrationType="9" info="FMS Engine fault" />
		<parameter id="-4986396588964006578" parameterId="-3690537839026879670" calibrationType="9" info="FMS Active Diagnostic Trouble Codes" />
		<parameter id="7171833288533579745" parameterId="7168821117511843328" calibrationType="31" info="Engine RPM" />
		<parameter id="-6105720283000561634" parameterId="-7959039106706272406" calibrationType="9" info="FMS Engine Coolant Temperature" />
		<parameter id="3893726022664282059" parameterId="-8883477110877699683" calibrationType="9" info="TT: Block 0 Status 11" />
		<parameter id="-4277457492590473450" parameterId="-343203349928911591" calibrationType="9" info="FMS DM Engine Oil Pressure" />
		<parameter id="-309879192672146780" parameterId="-7139874048079947737" calibrationType="9" info="TT: Block 0 Status 13" />
		<parameter id="6772498241048877762" parameterId="5994588348526028024" calibrationType="9" info="FMS Engine Oil Level" />
		<parameter id="338506025309405609" parameterId="-997280659822459764" calibrationType="29" info="Acceleration" />
		<parameter id="850094350382255384" parameterId="-3361659057359657382" calibrationType="29" info="Deceleration" />
		<parameter id="4462967261420742565" parameterId="-4138506370119513461" calibrationType="8" info="System.IgnitionOn" />
		<parameter id="-1648949361184441066" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
		<parameter id="-8261885677649654097" parameterId="-8456574128637028132" calibrationType="9" info="CAN.CTVAL" />
		<parameter id="8622757785626377409" parameterId="6004312178450985728" calibrationType="1" default="1" calibration1="7065" value1="9" info="System.PTOEngaged" />
		<parameter id="-8085330650015851490" parameterId="-3731545217573397882" calibrationType="23" allowDuplicate="1" info="At location" />
		<parameter id="4744764400153412199" parameterId="2180402635850434920" calibrationType="9" info="Speed.Monitoring.PostedSpeed" />
	</parameters>
		<requiredEvents>
		<event id="50250694746183801" eventId="-4950190839529718443" info="* Ignition Off" />
		<event id="-495193446774169818" eventId="8242796377286834188" info="* Ignition On" />
		<event id="7006933938425728226" eventId="297912159654229926" info="Trip Start" />
		<event id="7611860366220653" eventId="862100186336151561" info="Trip End" />
		<event id="5050800263203100027" eventId="-1436104788329512077" info="Start of trip fuel tank level percentage" />
		<event id="4119113711833778079" eventId="-170173368564016851" info="End of trip fuel tank level percentage" />
		<event id="-477925475923605733" eventId="5390829139648223269" info="Start of trip state of charge" />
		<event id="-3991999609074546769" eventId="5748917249111149801" info="End of trip state of charge" />
		<event id="-4596761290991128163" eventId="5160625119091753479" info="Driver seatbelt not engaged" />
		<event id="5502348836300702837" eventId="5371300709033963442" info="Passenger seatbelt not engaged" />
		<event id="-2861698103707910904" eventId="-2439674153577661748" info="Engine light (MIL) on" />
		<event id="-1985043708450122439" eventId="-4082655169988672233" info="Diagnostic trouble code" />
		<event id="-9012980052836493009" eventId="-6079465181680378697" info="Engine coolant temperature high" />
		<event id="4548623395409669104" eventId="6010815209500410149" info="Engine Oil Pressure low" />
		<event id="-5700940987216498903" eventId="4765990693530272682" info="Engine Oil level low" />
		<event id="8029470759544558914" eventId="-7456037637456725921" info="Energy recuperated (Total)" />
		<event id="-7890155689072669962" eventId="-6629726376832163583" info="Energy consumed (Total)" />
		<event id="7795807986391333111" eventId="6454149451280645233" info="Harsh acceleration" />
		<event id="954349072485382005" eventId="4750800303282680186" info="Harsh braking" />
		<event id="9202143976860429405" eventId="-3393530750645328945" info="Idle" />
		<event id="-7371597662614440454" eventId="4650840888823746694" info="Idle - excessive" />
		<event id="-7890219672217155923" eventId="-7372181092478897411" info="Over revving" />
		<event id="2275872591267852987" eventId="-3890646499157906515" info="Over speeding" />
		<event id="7201727756572855671" eventId="-2864371101042705250" info="Road Speed Overspeeding" />
	</requiredEvents>
</device>
```

## 20230503


Once on line where it loops through all the new devicedependencies...
(The second time, as the first time is the actual device...)
**NOPE** I think the ORG is busted - try on new org or something - FIRST clean DB and reuse 37
USing 52 now...


BUILD SQL to do this for us... Get all Unique Params needed... into a SQL from Below
- GET ALL OF THEM... definitionDeviceId.... (DevicesData.xml)
	- (Could one of the device's dependencies maybe cause > events > params?) } (NOT SURE IF WE SHOULD ITERATE FROM HERE AGAIN?)
	- (Also maybe look for Params??)
	- FOR EACH get required events (EventsData.xml)
		- FOR EACH get params
			- ADD EACH param

```xml
<!-- Double check these parameters -->
-8773503912069575223 - YES
2180402635850434920 - TODO at bottom
-3731545217573397882

<!-- Peripherals -->
-3492265442579611717 done
461810553627904383 NA
1033708229995056213 NA
-7567965444832338102 NA
-454496733429815087 NA
3347847402828392724 NA
4431036879423407377
			<event id="-5165332681519789185" eventId="-1009815199714528629" info="In-cab road speed over speeding" />
				-8773503912069575223
			<event id="-4338241828768624340" eventId="-2296465401251079776" info="In-cab road speed over speeding - EXCESSIVE DURATION" />
				2180402635850434920
			<event id="-5695656046695487744" eventId="4817078994107181378" info="In-cab road speed over speeding - EXCESSIVE SPEED" />
				2180402635850434920
				
			    <parameter id="-9119097038981318518" parameterId="2180402635850434920" calibrationType="9" info="Speed.Monitoring.PostedSpeed" />
      
-3505785715361263248
	      <event id="-4596269900191457380" eventId="-4596269900191457380" info="Over speeding - TIERED" />
		      -8773503912069575223
5695480675736568992 NA
-9084522846345424310 NA
-2677973217952751564 NA
-2231271351705479521
			<event id="4360614301289230131" eventId="4360614301289230131" info="Over speeding in location" />
				-8773503912069575223
			<event id="1062305132618114225" eventId="1062305132618114225" info="Over speeding in location - EXCESSIVE DURATION" />
				-3731545217573397882
			<event id="-8136342741862439235" eventId="-8136342741862439235" info="Over speeding in location - EXCESSIVE SPEED" />
				-3731545217573397882

<!--ALREADY GOT PARAMS-->
definitionDeviceId -2231271351705479521
ParameterId: -3731545217573397882
			<event id="xxxx" eventId="4360614301289230131" info="Over speeding in location" />
			<event id="xxxx" eventId="1062305132618114225" info="Over speeding in location - EXCESSIVE DURATION" />
			<event id="-xxxx" eventId="-8136342741862439235" info="Over speeding in location - EXCESSIVE SPEED" />

2637272309604290496
      <event id="-5885026884290222700" eventId="-5885026884290222700" info="End of trip call back request" />
	      NA
-7255325733681205281 NA
-3296749568061906497 NA
2504657096565856585 NA
6059035664735974023 NA
<parameter id="xxxxxxxxxxxx" parameterId="-3731545217573397882" calibrationType="23" allowDuplicate="1" info="At location" />
<parameter id="xxxxxxxxxxxx" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
<parameter id="xxxxxxxxxxxx" parameterId="2180402635850434920" calibrationType="9" info="Speed.Monitoring.PostedSpeed" />

<!--STILL TODO-->

_EXCEPTION_! All required parameters for this event have not been satisfied - ParameterId:5527345990296514983
EVENT 3027302644652935131

```


## 20230425

GPT

- coordinate with those processes
- required fields are null, 
- if any foreign key constraints are satisfied, 
- or if any unique constraints are violated
- try disabling entity validation (ValidateOnSaveEnabled property to false)
- examining the SQL statements being generated by Entity Framework

```error
Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.  
**Stack trace:**  

   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminDbContext.SaveChanges(ISession session) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminDbContext.cs:line 292
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.SaveEFContext() in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs:line 428
   at DynaMiX.Data.ConfigAdmin.ConfigAdminRepository.AddEvent(LibraryEvent entity) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminRepository.cs:line 761
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeLibraryEventAvailable(IConfigAdminRepository repo, IGlobalData globalData, LibraryEvent sourceEvent, Int64 targetOrgId, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 587
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeRequiredEventsAvailalble(String authToken, IGlobalData globalData, IConfigAdminRepository repo, List`1 allDeviceEventDependencies, Int64 sourceOrgId, Int64 targetOrgId, Int64 sourceLogicalDeviceId, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents, List`1 defaultEventCameras, IConfigAdminSqlRepository sqlRepo, String updatedBy) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 205
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeDependanciesAvailable(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, ILibraryDevice sourceDevice, ILibraryDevice targetDevice, Int64 orgId, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents, IConfigAdminSqlRepository sqlRepo, String updatedBy) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 157
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeLibraryMobileDeviceAvaialble(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, LibraryMobileDevice sourceMobileDevice, Int64 destinationLibraryid, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents, IConfigAdminSqlRepository sqlRepo, String updatedBy) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 348
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble(String authToken, Int64 orgId, Int64 mobileDeviceId, Int64 correlationId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs:line 278
   at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.MakeAvailableForLibrary(String authToken, Int64 orgId, Int64 mobileDeviceId) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 126
   at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.<.ctor>b__1_2(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 55
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.b__1(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
```

## 20230419

```error
Communication with the underlying transaction manager has failed.
Stack trace:
   at System.Transactions.Oletx.OletxTransactionManager.ProxyException(COMException comException)
   at System.Transactions.Oletx.DtcTransactionManager.Initialize()
   at System.Transactions.Oletx.DtcTransactionManager.get_ProxyShimFactory()
   at System.Transactions.TransactionInterop.GetOletxTransactionFromTransmitterPropigationToken(Byte[] propagationToken)
   at System.Transactions.TransactionStatePSPEOperation.PSPEPromote(InternalTransaction tx)
   at System.Transactions.TransactionStateDelegatedBase.EnterState(InternalTransaction tx)
   at System.Transactions.EnlistableStates.Promote(InternalTransaction tx)
   at System.Transactions.Transaction.Promote()
   at System.Transactions.TransactionInterop.ConvertToOletxTransaction(Transaction transaction)
   at System.Transactions.TransactionInterop.GetExportCookie(Transaction transaction, Byte[] whereabouts)
   at System.Data.SqlClient.SqlInternalConnection.GetTransactionCookie(Transaction transaction, Byte[] whereAbouts)
   at System.Data.SqlClient.SqlInternalConnection.EnlistNonNull(Transaction tx)
   at System.Data.SqlClient.SqlInternalConnection.Enlist(Transaction tx)
   at System.Data.ProviderBase.DbConnectionInternal.ActivateConnection(Transaction transaction)
   at System.Data.ProviderBase.DbConnectionPool.PrepareConnection(DbConnection owningObject, DbConnectionInternal obj, Transaction transaction)
   at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, UInt32 waitForMultipleObjectsTimeout, Boolean allowCreate, Boolean onlyOneCheckConnection, DbConnectionOptions userOptions, DbConnectionInternal& connection)
   at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal& connection)
   at System.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at System.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at System.Data.SqlClient.SqlConnection.TryOpenInner(TaskCompletionSource`1 retry)
   at System.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at System.Data.SqlClient.SqlConnection.Open()
   at DynaMiX.Data.ConfigAdmin.ConfigAdminSqlRepository.GetDefaultEventCameras(String authenticationToken, Int64 orgId) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminSqlRepository.cs:line 1532
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeDependanciesAvailable(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, ILibraryDevice sourceDevice, ILibraryDevice targetDevice, Int64 orgId, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents, IConfigAdminSqlRepository sqlRepo, String updatedBy) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 128
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeLibraryMobileDeviceAvaialble(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, LibraryMobileDevice sourceMobileDevice, Int64 destinationLibraryid, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents, IConfigAdminSqlRepository sqlRepo, String updatedBy) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 321
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble(String authToken, Int64 orgId, Int64 mobileDeviceId, Int64 correlationId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs:line 272
   at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.MakeAvailableForLibrary(String authToken, Int64 orgId, Int64 mobileDeviceId) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 126
   at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.<.ctor>b__1_2(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 55
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.b__1(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
   at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121

```

## 17 April

- CONFIG-3663: Discussed this with Paul. Removed the dependency of a non existing event (-8411064564578656408 PTO engaged")
- Still missing some:
	- -3731545217573397882
	- "At location"

```txt
  net start "DynaMiX Database Maintenance Service"
```
📷
## ERROR

- [Ford OEM Logz.io](https://app.logz.io/#/dashboard/osd/discover/doc/logzioCustomerIndex*/logzioCustomerIndex230410_v21.account-157986?_g=()&id=vG5ub4cBZO3bvDiW6CoK&type=doc&accountIds=157523&accountIds=157528&accountIds=158424&accountIds=157529&accountIds=157986&accountIds=157734&accountIds=157735&accountIds=157736&accountIds=157737&accountIds=157422&accountIds=157426&accountIds=158898&accountIds=157424&accountIds=158452&accountIds=159157&accountIds=160250&accountIds=157752&accountIds=337300&accountIds=157279&switchToAccountId=157279)
- EXCEPTION! All required parameters for this event have not been satisfied - ParameterId:-7959039106706272406 ("FMS Engine Coolant Temperature")

## Notes

- allTargetLibraryParameters only has one, 2180402635850434920
- Can't find 
- Comes from event: "Engine coolant temperature high"
- ID: -6079465181680378697

Should we use this as a general make available chat?
If so - Ford OEM fails for a specific parameter... it tries to use it when making dependent events available
HOWEVER, no logicals or peripherals ever nor this device ever finds this param as a dependency... so it cant
AT LEAST THIS MAKES SENSE - not like the other stuff ⁠
I then had a look at the XML... it is a dependency on Ford... will now just double check if ford == ford oem ⁠

## Aan Paul

YO - trust jy is OK?
Ek kyk na make available van Ford OEM.
Dit fail wanneer dit dependencies available maak...
Dit fail wanneer dit die event Engine coolant temperature high (ID: -6079465181680378697) probeer available maak.
Rede is die bg event het n dependency op  ParameterId:-7959039106706272406
Hierdie param is nie n param op die Ford OEM nie - so dit bestaan nie om gebruik te word wanneer die event available gemaak word nie
(Ek sien dis wel op ander devices wat daai selfde event dependency het, op daai devices is die bg param ook verklaar)
(eg. MobileDevice.Teltonika, MobileDevice.Scania, MobileDevice.Stellantis, System.CAN.Dynamic)

Maar dis nie een v.d. params op:
device id="-3492265442579611717" type="0" systemName="MobileDevice.Ford"
Dink jy ons kan dit daar insit en dan behoort die event available gemaak te kan word?
Thanks

## Required Events Found

```xml
<requiredEvents>
	<event id="50250694746183801" eventId="-4950190839529718443" info="* Ignition Off" />
	<event id="-495193446774169818" eventId="8242796377286834188" info="* Ignition On" />
	<event id="7006933938425728226" eventId="297912159654229926" info="Trip Start" />
	<event id="7611860366220653" eventId="862100186336151561" info="Trip End" />
	<event id="5050800263203100027" eventId="-1436104788329512077" info="Start of trip fuel tank level percentage" />
	<event id="4119113711833778079" eventId="-170173368564016851" info="End of trip fuel tank level percentage" />
	<event id="-477925475923605733" eventId="5390829139648223269" info="Start of trip state of charge" />
	<event id="-3991999609074546769" eventId="5748917249111149801" info="End of trip state of charge" />
	<event id="-4596761290991128163" eventId="5160625119091753479" info="Driver seatbelt not engaged" />
	<event id="5502348836300702837" eventId="5371300709033963442" info="Passenger seatbelt not engaged" />
	<event id="-2861698103707910904" eventId="-2439674153577661748" info="Engine light (MIL) on" />
	<event id="-1985043708450122439" eventId="-4082655169988672233" info="Diagnostic trouble code" />
	<event id="-9012980052836493009" eventId="-6079465181680378697" info="Engine coolant temperature high" />
	<event id="4548623395409669104" eventId="6010815209500410149" info="Engine Oil Pressure low" />
	<event id="-5700940987216498903" eventId="4765990693530272682" info="Engine Oil level low" />
	<event id="8029470759544558914" eventId="-7456037637456725921" info="Energy recuperated (Total)" />
	<event id="-7890155689072669962" eventId="-6629726376832163583" info="Energy consumed (Total)" />
	<event id="-103197290368897301" eventId="-8411064564578656408" info="PTO engaged" />
	<event id="7795807986391333111" eventId="6454149451280645233" info="Harsh acceleration" />
	<event id="954349072485382005" eventId="4750800303282680186" info="Harsh braking" />
	<event id="9202143976860429405" eventId="-3393530750645328945" info="Idle" />
	<event id="-7371597662614440454" eventId="4650840888823746694" info="Idle - excessive" />
	<event id="-7890219672217155923" eventId="-7372181092478897411" info="Over revving" />
	<event id="2275872591267852987" eventId="-3890646499157906515" info="Over speeding" />
	<event id="7201727756572855671" eventId="-2864371101042705250" info="Road Speed Overspeeding" />
</requiredEvents>
```

## Param Issues


### -3731545217573397882

```xml

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\DevicesData.xml:
  13224:      <parameter id="-844089866498372571" parameterId="-3731545217573397882" calibrationType="23" allowDuplicate="1" info="At location" />
  13267:      <parameter id="2556099698526106074" parameterId="-3731545217573397882" calibrationType="23" allowDuplicate="1" info="At location" />
  14611:      <parameter id="7019145789957464122" parameterId="-3731545217573397882" calibrationType="23" allowDuplicate="1" info="At location" />

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\EventsData.xml:

<event id="-8835267647836467053" type="2" legacyId="163" description="Alarm: No Go RSA Border">
  4207:       <condition id="-704553430395316897" sequence="12" parameterId="-3731545217573397882" operator="" value="-2999027776819851821.000000" flags="1" join="||" info="At location" />

  4208:       <condition id="8830158897190275906" sequence="13" parameterId="-3731545217573397882" operator="" value="-1562870495250535275.000000" flags="1" join="||" info="At location" />

  4209:       <condition id="-8977905350957667890" sequence="14" parameterId="-3731545217573397882" operator="" value="6418176855556323127.000000" flags="1" join="||" info="At location" />

  4210:       <condition id="-6789501090382703105" sequence="15" parameterId="-3731545217573397882" operator="" value="-7548336899312356206.000000" flags="1" join="||" info="At location" />

  4211:       <condition id="-1235935213499935534" sequence="16" parameterId="-3731545217573397882" operator="" value="-8156216281307139103.000000" flags="1" info="At location" />

  

  6562:   <event id="1062305132618114225" type="4" legacyId="12000" returnActionType="3" returnParameterId="-3731545217573397882" description="Over speeding in location - EXCESSIVE DURATION" />

  6563:   <event id="-8136342741862439235" type="4" legacyId="12001" returnActionType="3" returnParameterId="-3731545217573397882" description="Over speeding in location - EXCESSIVE SPEED" />

  

Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\ParametersData.xml:

  576:  <parameter id="-3731545217573397882" legacyId="31121" description="At location" valueFormat="10" />

  

MiX.DeviceIntegration.Core\MiX.DeviceIntegration.Common\Constants\Parameters.cs:

  5  

  6:    public const long AT_LOCATION = -3731545217573397882;

  7     public const long NOT_AT_LOCATION = -1599766058585427097;
```

## Hmmm

```csv
28	-7372181092478897411	1	OVREV	1	398	NULL	2015-08-13 23:32:13 +02:00	System Load
52	-4950190839529718443	4	NULL	NULL	NULL	NULL	2015-08-13 23:32:13 +02:00	System Load
63	-3890646499157906515	1	OVSPD	1	9	NULL	2015-08-13 23:32:13 +02:00	System Load
67	-3393530750645328945	1	NULL	NULL	NULL	NULL	2015-08-13 23:32:13 +02:00	System Load
72	-2864371101042705250	4	NULL	3	9	NULL	2015-08-13 23:32:13 +02:00	System Load
160	4650840888823746694	1	EXIDL	NULL	NULL	NULL	2015-08-13 23:32:13 +02:00	System Load
164	4750800303282680186	1	HRBRK	1	149	NULL	2015-08-13 23:32:13 +02:00	System Load
182	6454149451280645233	1	HRACC	1	199	NULL	2015-08-13 23:32:13 +02:00	System Load
206	8242796377286834188	4	NULL	NULL	NULL	NULL	2015-08-13 23:32:13 +02:00	System Load
35198	-6079465181680378697	1	NULL	1	902	NULL	2020-08-26 20:25:13 +02:00	System Load
35200	-4082655169988672233	1	NULL	3	889	NULL	2020-08-26 20:25:13 +02:00	System Load
35201	-2439674153577661748	1	NULL	3	1178	NULL	2020-08-26 20:25:13 +02:00	System Load
35202	-1436104788329512077	1	NULL	3	154	NULL	2020-08-26 20:25:13 +02:00	System Load
35203	-170173368564016851	1	NULL	3	154	NULL	2020-08-26 20:25:13 +02:00	System Load
35205	4765990693530272682	1	NULL	0	876	NULL	2020-09-10 15:38:40 +02:00	System Load
35206	5160625119091753479	1	NULL	3	557	NULL	2020-08-26 20:25:13 +02:00	System Load
35207	5371300709033963442	1	NULL	3	579	NULL	2020-08-26 20:25:13 +02:00	System Load
35208	5390829139648223269	1	NULL	3	1177	NULL	2020-08-26 20:25:13 +02:00	System Load
35209	5748917249111149801	1	NULL	3	1177	NULL	2020-08-26 20:25:13 +02:00	System Load
35210	6010815209500410149	1	NULL	0	1039	NULL	2020-09-10 15:38:40 +02:00	System Load
35252	297912159654229926	4	NULL	NULL	NULL	NULL	2021-03-17 08:00:38 +02:00	System Load
35253	862100186336151561	4	NULL	NULL	NULL	NULL	2021-03-17 08:00:38 +02:00	System Load
35273	-7456037637456725921	11	NULL	NULL	NULL	NULL	2021-05-03 12:53:52 +02:00	System Load
35274	-6629726376832163583	11	NULL	NULL	NULL	NULL	2021-05-03 12:53:52 +02:00	System Load
```

## Event Ids > condition params > params only

```txt
<parameters>
	<parameter id="xxxxxxxxxxxx" parameterId="981729539706373388" info="(" />
	<parameter id="xxxxxxxxxxxx" parameterId="-8722384628719264678" calibrationType="8" info="In trip (drive)" />
	<parameter id="xxxxxxxxxxxx" parameterId="-3161730702566266071" calibrationType="9" info="Fuel level" />
	<parameter id="xxxxxxxxxxxx" parameterId="-8380423587615480304" info=")" />
	<parameter id="xxxxxxxxxxxx" parameterId="-2155824911768570108" calibrationType="9" info="In Sub-trip" />
	<parameter id="xxxxxxxxxxxx" parameterId="-2360174318529543484" calibrationType="9" info="EV CAN: State of charge thousands" />
	<parameter id="xxxxxxxxxxxx" parameterId="73181982975249219" calibrationType="9" info="FM CAN: Seat Belt State" />
	<parameter id="xxxxxxxxxxxx" parameterId="837209246865036953" calibrationType="9" info="FM CAN: Passenger Seat Belt Status" />
	<parameter id="xxxxxxxxxxxx" parameterId="2638979532023225991" calibrationType="9" info="FMS Engine fault" />
	<parameter id="xxxxxxxxxxxx" parameterId="-3690537839026879670" calibrationType="9" info="FMS Active Diagnostic Trouble Codes" />
	<parameter id="xxxxxxxxxxxx" parameterId="7168821117511843328" calibrationType="31" info="Engine RPM" />
	<parameter id="xxxxxxxxxxxx" parameterId="-7959039106706272406" calibrationType="9" info="FMS Engine Coolant Temperature" />
	<parameter id="xxxxxxxxxxxx" parameterId="-8883477110877699683" calibrationType="9" info="TT: Block 0 Status 11" />
	<parameter id="xxxxxxxxxxxx" parameterId="-343203349928911591" calibrationType="9" info="FMS DM Engine Oil Pressure" />
	<parameter id="xxxxxxxxxxxx" parameterId="-7139874048079947737" calibrationType="9" info="TT: Block 0 Status 13" />
	<parameter id="xxxxxxxxxxxx" parameterId="5994588348526028024" calibrationType="9" info="FMS Engine Oil Level" />
	<parameter id="xxxxxxxxxxxx" parameterId="-997280659822459764" calibrationType="29" info="Acceleration" />
	<parameter id="xxxxxxxxxxxx" parameterId="-3361659057359657382" calibrationType="29" info="Deceleration" />
	<parameter id="xxxxxxxxxxxx" parameterId="-4138506370119513461" calibrationType="8" info="System.IgnitionOn" />
	<parameter id="xxxxxxxxxxxx" parameterId="-8773503912069575223" calibrationType="29" info="Road speed" />
	<parameter id="xxxxxxxxxxxx" parameterId="-8456574128637028132" calibrationType="9" info="CAN.CTVAL" /> <!--diff-->
	<parameter id="xxxxxxxxxxxx" parameterId="6004312178450985728" calibrationType="1" default="1" calibration1="7065" value1="9" info="System.PTOEngaged" /> <!--diff-->
</parameters>
```

## REMOVE THIS?

Should we remove this...
Event id: -8411064564578656408 (PTO engaged) 
(Still on Ford, Hino, CAN)

## Error Description

```log
EXCEPTION! All required parameters for this event have not been satisfied - ParameterId:-7959039106706272406
	Exception Type: System.ArgumentException
	Stack trace    at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeLibraryEventAvailable(IConfigAdminRepository repo, IGlobalData globalData, LibraryEvent sourceEvent, Int64 targetOrgId, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters) in D:\b\2\_work\376\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 504
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeRequiredEventsAvailalble(IGlobalData globalData, IConfigAdminRepository repo, List`1 allDeviceEventDependencies, Int64 sourceOrgId, Int64 targetOrgId, Int64 sourceLogicalDeviceId, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents) in D:\b\2\_work\376\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 163
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeDependanciesAvailable(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, ILibraryDevice sourceDevice, ILibraryDevice targetDevice, Int64 orgId, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents) in D:\b\2\_work\376\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 123
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.MakeAvailableHelper.MakeLibraryMobileDeviceAvaialble(String authenticationToken, IConfigAdminRepository repo, IGlobalData globalData, ILibraryManager libraryManager, LibraryMobileDevice sourceMobileDevice, Int64 destinationLibraryid, Dictionary`2 allSourceLibraryLogicalDeviceAggregates, Dictionary`2 allSourceLibraryPeripheralDeviceAggregates, Dictionary`2 allTargetLibraryLogicalDeviceAggregates, Dictionary`2 allTargetLibraryPeripheralDeviceAggregates, List`1 allDeviceEventDependencies, List`1 allDeviceDependencies, Dictionary`2 allSourceLibraryParameters, Dictionary`2 allTargetLibraryParameters, Dictionary`2 allSourceEvents, Dictionary`2 allLibraryEvents) in D:\b\2\_work\376\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\MakeAvailableHelper.cs:line 275
   at DynaMiX.Logic.ConfigAdmin.LibraryLevel.LibraryMobileDeviceManager.MakeLibraryMobileDeviceAvaialble(String authToken, Int64 orgId, Int64 mobileDeviceId, Int64 correlationId) in D:\b\2\_work\376\s\Logic\DynaMiX.Logic\ConfigAdmin\LibraryLevel\LibraryMobileDeviceManager.cs:line 266
   at DynaMiX.Api.NancyModules.ConfigAdmin.LibraryLevel.LibraryMobileDevicesModule.MakeAvailableForLibrary(String authToken, Int64 orgId, Int64 mobileDeviceId) in D:\b\2\_work\376\s\API\DynaMiX.API\NancyModules\ConfigAdmin\LibraryLevel\LibraryMobileDevicesModule.cs:line 124
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.<RegisterRoute>b__1(Object args) in D:\b\2\_work\376\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
   at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.<HandleVoid>b__1() in D:\b\2\_work\376\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 282
   at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in D:\b\2\_work\376\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 191
   at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in D:\b\2\_work\376\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 121
```

## Call Stack

![[CONFIG-3663 Make Available Ford OEM Call Stack.png]]

## Description

- 