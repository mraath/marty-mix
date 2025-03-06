---
created: 2024-02-16T10:12
updated: 2024-02-16T12:08
---
GetTransferStatuses  
- Uri: NOT as per Comms request  
- Memory pointers mentioned before, not sure if it is needed or not.

- OLD: [http://localhost/DynaMiX.Services.Api/largefiletransfers/lft:](http://localhost/DynaMiX.Services.Api/largefiletransfers/lft: "http://localhost/DynaMiX.Services.Api/largefiletransfers/lft:") NA  
- Old Client: NA  
- Findings: NA  

- **NEW CLIENT**: large-file-transfer/org-ids/{orgId}/transfer-statuses?authToken={authToken}
- **NEW API**: large-file-transfer/org-ids/{orgId}/transfer-statuses
- New Client: GetTransferStatuses  
	- Findings: I made use of the client tests found. It successfully found the API end-point from the client.
	- **SUCCESS** (Consistent URI between Client and API. I can't however say if the result was accurate, but the end-point works)

