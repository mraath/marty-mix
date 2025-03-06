---
created: 2023-04-03T16:35
updated: 2023-11-01T15:08
---

## Run service as windows console app

1) Inside programs.cs main method
```c#
DaylightSavingAdjustmentService service1 = new DaylightSavingAdjustmentService();
service1.TestStartupAndStop(null);
//ServiceBase.Run(new ServiceBase[] { new DaylightSavingAdjustmentService() });
```
2) Inside the service:
```c#
internal void TestStartupAndStop(string[] args)
{
  this.OnStart(args);
  Console.ReadLine();
  this.OnStop();
}
```
3) Change startup project and output type to console app
4) Set app as startup
5) App.Config
```xml
<setting name="LogFilePath" serializeAs="String">
	<value>c:\Services\DynaMiX.Services.DaylightSavingAdjustment\DynaMiX.Services.DaylightSavingAdjustment.log</value>

<dynamix>
		<dynamix.api 
			...
			MiX4000LatestFirmwareVersion="4.8.44" MiX3000LatestFirmwareVersion="5.2.0"

```


- If it still doesnt work check the error, internal error.
- Sometimes you need some more values within your config file, eg. MiX4000LatestFirmwareVersion="4.8.44" MiX3000LatestFirmwareVersion="5.2.0" CreateOverrideTemplates="true" UseNewDSTLogic="true"
- 