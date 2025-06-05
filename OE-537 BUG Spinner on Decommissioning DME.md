---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-06-05T12:09
---

# OE-537 BUG Spinner on Decommissioning DME

Date: 2025-06-05 Time: 11:26
Parent:: [[Remove Mobile Device]]
Friend:: [[2025-06-05]]
JIRA:OE-537 BUG Spinner on Decommissioning DME
https://powerfleet.atlassian.net/browse/OE-537


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

## Shorter Description

- Remove mobile device
- manually refreshing page
	- error
	- BUT this error could be due to refreshing this while data has now changed in the backend

When navigating out of Assets page and then going back in, the asset has been successfully decommissioned.

Error: 1574916149047824384
```xml
EXCEPTION! <?xml version="1.0" encoding="utf-16"?>  
<ApiRequestInfo xmlns:xsd="[http://www.w3.org/2001/XMLSchema](http://www.w3.org/2001/XMLSchema)" xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)">  
<RequestId>1574916149047824384</RequestId>  
<AuthToken>6dc2afaa-04e3-45e8-9d17-a61d81847ab2</AuthToken>  
<AccountId>3311992934800910971</AccountId>  
<RequestJson />  
<RequestUrl>GET <[http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/2307906436721054420/1567976447281238016</RequestUrl>>](http://integration.mixtelematics.com:80/DynaMiX.API/fleet-admin/assets/commissioning/2307906436721054420/1567976447281238016%3C/RequestUrl%3E%3E)  
</ApiRequestInfo>  
Exception Type: System.Exception  
EXCEPTION! **Object reference not set** to an instance of an object.  
Exception Type: System.NullReferenceException  
Stack trace at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.**GetAssetCommissioning**(String authToken, Int64 groupId, Int64 assetId) in D:\b\2\_work\1603\s\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\**AssetCommissioningModule.cs:line 712**  
at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass46_01.<RegisterRoute>b__0(Object args) in D:\\b\\2\\_work\\1603\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 499 at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass27_11.<HandleTyped>b__1() in D:\b\2\_work\1603\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 288  
at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessTypedResponse[T](Func1 method) in D:\\b\\2\\_work\\1603\\s\\Core\\DynaMiX.Core.Http\\Nancy\\ModuleBase.cs:line 215 at DynaMiX.Core.Http.Nancy.ModuleBase.HandledTypedResponse[T](Func1 method) in D:\b\2\_work\1603\s\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 149
```

