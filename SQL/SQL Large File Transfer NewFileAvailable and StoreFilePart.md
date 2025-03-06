---
created: 2023-11-08T15:19
updated: 2023-11-08T15:19
---
```sql
-- TESTING Large File Transfer NewFileAvailable and StoreFilePart
USE Dynamix;

--Get some assets and orgs to work with
--SELECT * FROM DeviceConfiguration.mobileunit.AssetMobileUnits WHERE LegacyOrgId IN (172,248,178,265)

--Once you run the code, use this to check the new file and how you add filecontent
SELECT TOP 3 * FROM [LargeFileTransfer].[FileData] fd ORDER BY fd.FileDataKey DESC
SELECT TOP 3 * FROM [LargeFileTransfer].[FileTransfersDownload] ORDER BY CreateDate DESC
```
