---
created: 2023-11-09T09:44
updated: 2023-11-09T09:45
---
## Old Client

```c#
var rest = new DynaMiX.Services.Api.LargeFileTransfer.Client.LargeFileTransfer("http://localhost/");
var update = rest.UpdateProgress(241, 888);
```

## New Client

```c#
LargeFileTransfer largeFileTransfer = new LargeFileTransfer() { Offset = 888, TransferId = 241 };
DeviceConfigClient.LargeFileTransferParameter.UpdateProgress(authtoken, largeFileTransfer).ConfigureAwait(false).GetAwaiter().GetResult();	
```
