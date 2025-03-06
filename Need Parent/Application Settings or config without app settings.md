
- Add eg. applications.json

```json
{
	"AppName": "DynaMiX.DeviceConfig.Utilities.DaylightSavingsTimeService"
}
```

- In your console app
```c#
using Microsoft.Extensions.Configuration;

//Main section
IConfiguration config = new ConfigurationBuilder()
	.SetBasePath(AppContext.BaseDirectory)
	.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
	.Build();

// Read individual settings using the IConfiguration object 
string appName = config["AppName"];
```
