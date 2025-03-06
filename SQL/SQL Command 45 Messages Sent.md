
Parent:: [[Command 45]]

## Messages Sent: FM and Mesa

```sql
-- FM LATEST command45 receiced per unit

SELECT m.liMessageID, msh.liMessageID, msh.dtEntered, m.ucstate, sParams, m.dtStarts, m.sNotes, msh.sNotes, msh.dtTimeStamp, *
--Lastest command45 received
FROM dbo.messages m WITH (NOLOCK)
INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
WHERE
sParams LIKE '%CommandID=45 ;%'
AND iVehicleID = 893
ORDER BY m.liMessageID DESC

  

-- MESA Command 45 DEVICECONFIG

SELECT TOP 50
MessageId, MessageSubType, ParamsJson, *
FROM [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] mum
WHERE ParamsJson LIKE '%"CommandId":45,%'
  AND mum.MobileUnitId = 1290745962778677248
Order by CreationDateUtc DESC
```
