---
created: 2023-11-09T14:03
updated: 2023-11-09T14:03
---
```sql
-- TESTING Large File Transfer: Cancel
USE Dynamix;

--GET Values for testing FileTransfer to UpdateProgress
SELECT TOP 10    lft.FileTransferId,    lft.AssetId,    lft.DisplayName,    lft.[Status],    lft.NumberOfBytesSent,    lfd.FileDataId,     lft.Notes,    lft.CreateDate,    lft.CompleteDate,    lft.DateStarted,    lft.DateScheduled,    CONVERT(nvarchar(MAX), lft.LargeFileCommand) LargeFileCommand
  FROM [LargeFileTransfer].[FileTransfers] lft
  INNER JOIN [LargeFileTransfer].[FileData] lfd ON lft.FileDataKey = lfd.FileDataKey
  --WHERE Status = 0
  WHERE lft.FileTransferId = 4684
```

