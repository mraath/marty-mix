---
created: 2023-11-09T09:43
updated: 2023-11-09T09:43
---
```sql
-- TESTING Large File Transfer: UpdateProgress
USE Dynamix;

--GET Values for testing FileTransfer to UpdateProgress
SELECT TOP 10    lft.FileTransferId,    lft.AssetId,    lft.DisplayName,    lft.[Status],    lft.NumberOfBytesSent,    lfd.FileDataId,     lft.Notes,    lft.CreateDate,    lft.CompleteDate,    lft.DateStarted,    lft.DateScheduled,    CONVERT(nvarchar(MAX), lft.LargeFileCommand) LargeFileCommand
  FROM [LargeFileTransfer].[FileTransfers] lft
  INNER JOIN [LargeFileTransfer].[FileData] lfd ON lft.FileDataKey = lfd.FileDataKey
  WHERE lft.FileTransferId = 241

--Used this to GET SOME DATA to work with. Chose older ones which has FileData and 
/*
SELECT TOP 3 * FROM [LargeFileTransfer].[FileTransfers] WHERE FileTransferId IN (241,242,243,244,245,249,250,252,253,254)
--AND FileTransferId = 241
SELECT TOP 3 * FROM [LargeFileTransfer].[FileData] fd WHERE FileDataKey IN (252,253,254,255,256,260,261,263,264)
--AND FileDataKey = 252
*/
```
