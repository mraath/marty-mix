```sql
-- FIRST: Delete the config group
-- THEN run the below...
DECLARE @Delete INT = 0; --< if happy... SET THIS TO 1 if you want to actually delete!
-- LASTLY: Make Unavailable

USE DeviceConfiguration
--http://config.dev.mixtelematics.com/#/fleet-admin/asset/details?orgId=801577480108267051
DECLARE @OrganisationId BIGINT = -5785682803802374635 -- (MR Org) OTHER (MR Org Empty) 801577480108267051
DECLARE @Device NVARCHAR(50) = 'MiX3000';
DECLARE @DeviceTemplateName NVARCHAR(50) = 'DEFAULT mobile device template FOR ' + @Device;
DECLARE @EventTemplateName NVARCHAR(50) = 'Default event template for ' + @Device;

DECLARE @librarykey INT = (SELECT ll.LibraryKey
FROM DeviceConfiguration.library.Libraries ll
WHERE LibraryId = @OrganisationId)

DECLARE @templateid BIGINT = (SELECT TOP 1
  tmdt.MobileDeviceTemplateId
FROM template.MobileDeviceTemplates tmdt
WHERE tmdt.LibraryKey = @librarykey
  AND tmdt.Name = @DeviceTemplateName
--'Default mobile device template for MiX4000' --'MR 4K'
ORDER BY MobileDeviceTemplateKey DESC)

DECLARE @templatekey INT = (SELECT MobileDeviceTemplateKey
FROM template.MobileDeviceTemplates tmdt
WHERE tmdt.MobileDeviceTemplateId =  @templateid
  AND tmdt.LibraryKey = @librarykey
  AND tmdt.Name = @DeviceTemplateName)

DECLARE @eventTemplateId BIGINT = (SELECT TOP 1
  EventTemplateId
FROM template.EventTemplates
WHERE LibraryKey = @librarykey
  AND Name = @EventTemplateName
ORDER BY EventTemplatekey DESC
)
/*Also Add in name?*/

DECLARE @eventTemplatekey INT = (SELECT TOP 1
  EventTemplatekey
FROM template.EventTemplates
WHERE EventTemplateId =  @eventTemplateId
  AND Name = @EventTemplateName
  AND LibraryKey = @librarykey)

---- TEST 1 --------------------------------------------

/*
SELECT top 5 *
FROM template.MobileDeviceTemplates
WHERE MobileDeviceTemplateId =  @templateid
SELECT TOP 5 *
FROM template.MobileDeviceTemplates
WHERE LibraryKey = @librarykey
*/

---- DELETE --------------------------------------------

if @Delete = 0
BEGIN
  SELECT 'NOT DELETING' as [STATE]
END

if @Delete = 1
BEGIN

  SELECT 'DELETING' as [STATE]
  
  BEGIN TRANSACTION
    DELETE FROM template.PeripheralDevices WHERE TemplateDeviceKey IN (SELECT TemplateDeviceKey
    FROM template.Devices
    WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey)
    DELETE FROM template.DeviceParameters WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey
    DELETE FROM template.DeviceProperties WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey
    DELETE FROM template.Devices WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey
    DELETE FROM template.MobileDeviceTemplates WHERE MobileDeviceTemplateId =  @templateid AND LibraryKey = @librarykey
    --rollback transaction
  COMMIT TRANSACTION

  begin transaction 
    delete from  template.[EventActions]  where EventTemplatekey = @eventTemplatekey and LibraryKey = @librarykey
    delete from  template.[EventConditions]  where EventTemplatekey = @eventTemplatekey and LibraryKey = @librarykey
    delete from  template.[Events]  where EventTemplatekey = @eventTemplatekey and LibraryKey = @librarykey
    delete from  template.EventTemplates   where eventTemplateId = @eventTemplateId and LibraryKey = @librarykey
  --rollback transaction
  commit transaction

END

---- TEST ----------------------------------------------

SELECT '' [template.MobileDeviceTemplates], *
FROM template.MobileDeviceTemplates
WHERE MobileDeviceTemplateId =  @templateid AND LibraryKey = @librarykey

SELECT '' [template.EventTemplates], *
FROM template.EventTemplates
WHERE LibraryKey = @librarykey
  AND EventTemplateId =  @eventTemplateId

SELECT '' [template.Devices], *
FROM template.Devices
WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey

SELECT '' [template.DeviceParameters], *
FROM template.DeviceParameters
WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey

SELECT '' [template.DeviceProperties], *
FROM template.DeviceProperties
WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey

SELECT '' [template.PeripheralDevices], *
FROM template.PeripheralDevices
WHERE TemplateDeviceKey IN (SELECT TemplateDeviceKey
FROM template.Devices
WHERE MobileDeviceTemplateKey = @templatekey AND LibraryKey = @librarykey)

SELECT '' [template.EventTemplates], *
FROM template.EventTemplates
WHERE eventTemplateId = @eventTemplateId AND LibraryKey = @librarykey

SELECT '' [template.Events], *
FROM template.[Events]
WHERE EventTemplatekey = @eventTemplatekey AND LibraryKey = @librarykey

SELECT '' [template.EventActions], *
FROM template.[EventActions]
WHERE EventTemplatekey = @eventTemplatekey AND LibraryKey = @librarykey

SELECT '' [template.EventConditions], *
FROM template.[EventConditions]
WHERE EventTemplatekey = @eventTemplatekey AND LibraryKey = @librarykey

/*
SELECT '' [library.Events], *
FROM library.Events
WHERE LibraryKey = @librarykey

SELECT '' [definition.Devices], *
FROM definition.Devices
WHERE DeviceKey IN (32,73,102,131,134,142,292,294,301,575,598,607,968,1487,12137,13333,13334,13352,15611)
WHERE DeviceKey IN (32,73,102,131,134,142,292,294,    575,598,607,    1487,12137,13333,13334,13352,15611)
*/


/*

DECLARE @lorgID INT = 5135

--LegacyOrgId
SELECT liGMTOffset, *
FROM FMOnlineDB.dbo.Organisation dboOrg
WHERE dboOrg.liOrgID = @lorgID

--DSV ONLY (Multiple time zone) L3B-UI only
SELECT top 5 *
FROM FMOnlineDB.dynamix.Organisations
WHERE GroupId = 
OrganisationId = @lorgID

SELECT top 5 *
FROM DeviceConfiguration.library.Libraries ll
WHERE LibraryId = -8386191436408769566
*/

```