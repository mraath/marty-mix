---
created: 2023-11-08T15:20
updated: 2023-11-08T15:22
---
## OLD Client

```c#
// OLD CODE
// Reverse LFT testing
Console.WriteLine("Reverse LFT testing...");

bool success = rest.NewFileAvailable(172, 66, -11113, 1024, "Test.file.A7", 0);
Console.WriteLine("Reverse LFT NewFileAvailable: " + success);

List<String> pendingDownloads = rest.GetPendingDownloads();

if (pendingDownloads == null)
{ 
	Console.WriteLine("No reverse LFT Pending download found");
}
else
{
	int i = 1;
	foreach (String session in pendingDownloads)
	{
		Console.WriteLine("Reverse LFT Pending download:   " + i++);
	}
}

int offset = -1;
int partSize = 0;
LargeFileTransferStatus status = rest.GetNextFilePartToDownload(-11113, 256, out offset, out partSize);

Console.WriteLine("Reverse LargeFileTransfer next offset=" + offset + " for Session ID -11113" + " partSize=" + partSize + " status=" + status);

byte[] data  = new byte[256];

int ii = 0;
while (ii < 256)
{
	data[ii] = 0xFF;
	ii++;
}

success = rest.StoreFilePart(-11113, 0, 256, data);

Console.WriteLine("Eeverse LFT StoreFilePart: " + success);

ii = 0;
while (ii < 256)
{
	data[ii] = 0xAA;
	ii++;
}

success = rest.StoreFilePart(-11113, 256, 256, data);

Console.WriteLine("Eeverse LFT StoreFilePart: " + success);

offset = -1;
partSize = 0;
status = rest.GetNextFilePartToDownload(-11113, 256, out offset, out partSize);

Console.WriteLine("Reverse LargeFileTransfer next offset=" + offset + " for Session ID -11113" + " partSize=" + partSize + " status=" + status);
```

## New Client

```c#
//New Client Code
// Reverse LFT testing
Console.WriteLine("Reverse LFT testing...");

LargeFileTransfer largeFileTransfer =
	new LargeFileTransfer() { ORG = 172, vehicleID = 66, TransferId = -11112, Size = 1024, fileName = "Test.file.A5", FileAtrtributes = 0 };
DeviceConfigClient.LargeFileTransferParameter.NewFileAvailable(authtoken, largeFileTransfer).ConfigureAwait(false).GetAwaiter().GetResult();


List<String> pendingDownloads = DeviceConfigClient.LargeFileTransferParameter.RequestPendingDownloads(authtoken).ConfigureAwait(false).GetAwaiter().GetResult();

if (pendingDownloads == null)
{
	Console.WriteLine("No reverse LFT Pending download found");
}
else
{
	int i = 1;
	foreach (String session in pendingDownloads)
	{
		Console.WriteLine("Reverse LFT Pending download:   " + i++);
	}
}

int offset = -1;
int partSize = 0;
var status = DeviceConfigClient.LargeFileTransferParameter.GetNextFilePartToDownload(authtoken, -11112, 256).ConfigureAwait(false).GetAwaiter().GetResult();
Console.WriteLine("Reverse LargeFileTransfer next offset=" + offset + " for Session ID -11112" + " partSize=" + partSize + " status=" + status);

byte[] data = new byte[256];

int ii = 0;
while (ii < 256)
{
	data[ii] = 0xFF;
	ii++;
}

//success = rest.StoreFilePart(-11112, 0, 256, data);
//HERE:
var data64 = Convert.ToBase64String(data);
LargeFileTransfer largeFileTransfer2 =
	new LargeFileTransfer() { TransferId = -11112, Offset = 0, PartSize = 256, dataBase64 = data64 };
DeviceConfigClient.LargeFileTransferParameter.StoreFilePart(authtoken, largeFileTransfer2).ConfigureAwait(false).GetAwaiter().GetResult();


Console.WriteLine("Eeverse LFT StoreFilePart: ");

ii = 0;
while (ii < 256)
{
	data[ii] = 0xAA;
	ii++;
}

//success = rest.StoreFilePart(-11112, 256, 256, data);
var data64b = Convert.ToBase64String(data);
LargeFileTransfer largeFileTransfer3 =
	new LargeFileTransfer() { TransferId = -11112, Offset = 256, PartSize = 256, dataBase64 = data64b };
DeviceConfigClient.LargeFileTransferParameter.StoreFilePart(authtoken, largeFileTransfer3).ConfigureAwait(false).GetAwaiter().GetResult();

Console.WriteLine("Eeverse LFT StoreFilePart: ");

offset = -1;
partSize = 0;
//status = rest.GetNextFilePartToDownload(-11112, 256, out offset, out partSize);
var statusC = DeviceConfigClient.LargeFileTransferParameter.GetNextFilePartToDownload(authtoken, -11112, 256).ConfigureAwait(false).GetAwaiter().GetResult();
Console.WriteLine("Reverse LargeFileTransfer next offset=" + offset + " for Session ID -11112" + " status=" + statusC);

Console.WriteLine("Reverse LargeFileTransfer next offset=" + offset + " for Session ID -11112" + " partSize=" + partSize + " status=" + status);

```
