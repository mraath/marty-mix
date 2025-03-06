---
created: 2023-11-02T15:06
updated: 2023-11-02T16:25
---
We had a [[Deployment Issue]]

## Issue

"POST /devices/866561062935899/commands" failed. 500 - Internal Server Error - {"StatusCode":"InternalServerError","Type":"ArgumentException","Message":_"UpdateSettingsCommandDetails requires at least one DeviceSetting"_}

And there have been no successful Config/Settings uploads in UK since _2023-11-01 17:05:07.6400000 +00:00._

```txt
ERROR 2023-11-02T04:20:09+00:00 [tid:12  ] System.Exception: A call to "POST /devices/866561062216431/commands" failed. 500 - Internal Server Error - {"StatusCode":"InternalServerError","Type":"ArgumentException","Message":"UpdateSettingsCommandDetails requires at least one DeviceSetting"}  
   at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.CheckForErrorResponse(IRestResponse& response, IRestRequest request, HttpStatusCode[] ignoredHttpStatusCodes) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/ResourceWrapperHelper.cs:line 71   at MiX.Connect.Devices.Comms.Web.Api.Client.ResourceWrapperHelper.ProcessAddOrUpdateRequestAsync[T](String postUri, String putUri, T resource) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/ResourceWrapperHelper.cs:line 27   at MiX.Connect.Devices.Comms.Web.Api.Client.CommandResourceWrapperCollection.Send(CommandResource commandResource) in /home/vsts/work/1/s/Devices/Comms/MiX.Connect.Devices.Comms.Web.Api.Client/EntityData/CommandResourceWrapperCollection.cs:line 34
```

## FiX

[[ELD]] settings
override in the config gen service [[config file]]
AFTER this RECOMPILE config before uploading again