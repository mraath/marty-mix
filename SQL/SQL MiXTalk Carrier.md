---
created: 2024-02-29T17:06
updated: 2024-02-29T17:09
---
```sql
CREATE TABLE [audit].[mobileunit_MiXTalkCarrierPhoneNumber_CT]
(
  [RID]                             INT                 NOT NULL CONSTRAINT PK_mobileunit_MiXTalkCarrierPhoneNumber_CT PRIMARY KEY CLUSTERED IDENTITY (1,1),
  [ChangeDate]                      DATETIMEOFFSET(0)   NOT NULL CONSTRAINT DF_mobileunit_MiXTalkCarrierPhoneNumber_CT_ChangeDate  DEFAULT (SYSUTCDATETIME()),
  [Operation]                       CHAR(1)             NOT NULL,
  [UpdateMask]                      INT                 NOT NULL,
  [CarrierID]                       INT                 NOT NULL,
  [PhoneNumber]                     nvarchar(25)        NOT NULL,
  [SMSCNumber]                      nvarchar(25)        NULL
);
GO

ALTER TABLE [audit].[mobileunit_MiXTalkCarrierPhoneNumber_CT] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);
GO


----


CREATE PROCEDURE [mobileunit].[GetMiXTalkCarrierInfo]
  @CarrierID INT
AS

Select 
  C.Carrier, P.PhoneNumber, P.SMSCNumber
FROM 
  [mobileunit].[MiXTalkCarrier] C (NOLOCK)
  LEFT OUTER JOIN [mobileunit].[MiXTalkCarrierPhoneNumber] P (NOLOCK) ON C.[CarrierID] = P.[CarrierID]
WHERE 
  C.[CarrierID] = @CarrierID


----


CREATE PROCEDURE [mobileunit].[GetMiXTalkCarriers]
AS
Select 
  CarrierID, Carrier
FROM 
  [mobileunit].[MiXTalkCarrier] C (NOLOCK)

----

CREATE TABLE [mobileunit].[MiXTalkCarrier](
	[CarrierID] [int] NOT NULL CONSTRAINT [PK_MiXTalkCarrier] PRIMARY KEY CLUSTERED IDENTITY (1, 1),
	[Carrier]   [nvarchar](50) NOT NULL,
)
GO

----


CREATE TABLE [mobileunit].[MiXTalkCarrierPhoneNumber](
	[CarrierID]   [int] NOT NULL,
	[PhoneNumber] [nvarchar](25) NOT NULL,
	[SMSCNumber] [nvarchar](25) NULL,

  CONSTRAINT [FK_MiXTalkCarrierPhoneNumber_MiXTalkCarrier] FOREIGN KEY ([CarrierID]) REFERENCES [mobileunit].[MiXTalkCarrier] ([CarrierID])
)
GO

-- Audit Triggers
CREATE TRIGGER [mobileunit].[MiXTalkCarrierPhoneNumber_CT_ITrig] ON [mobileunit].[MiXTalkCarrierPhoneNumber]
FOR INSERT AS
IF @@ROWCOUNT = 0 RETURN;

SET NOCOUNT ON

DECLARE @updateMask INT = 0xFFFFFFFF;
INSERT INTO  audit.mobileunit_MiXTalkCarrierPhoneNumber_CT
            (
              [Operation],
              [UpdateMask],
              [CarrierID],
              [PhoneNumber],
              [SMSCNumber]
            )
      SELECT 'I',
             @updateMask,
             [CarrierID],
             [PhoneNumber],
             [SMSCNumber]
      FROM
        inserted;
GO

EXEC sp_settriggerorder @triggername=N'[mobileunit].[MiXTalkCarrierPhoneNumber_CT_ITrig]', @order=N'Last', @stmttype=N'INSERT'
GO

CREATE TRIGGER [mobileunit].[MiXTalkCarrierPhoneNumber_CT_UTrig] ON [mobileunit].[MiXTalkCarrierPhoneNumber]
FOR UPDATE AS
IF @@ROWCOUNT = 0 RETURN;

SET NOCOUNT ON

DECLARE @updateMask INT = 0;

IF UPDATE( [CarrierID] )   SET @updateMask |= 0x80000000;
IF UPDATE( [PhoneNumber] ) SET @updateMask |= 0x40000000;
IF UPDATE( [SMSCNumber] )  SET @updateMask |= 0x20000000;

IF @updateMask != 0
  BEGIN
    INSERT INTO  [audit].[mobileunit_MiXTalkCarrierPhoneNumber_CT]
            (
              [Operation],
              [UpdateMask],
              [CarrierID],
              [PhoneNumber],
              [SMSCNumber]
            )
      SELECT 'U',
             @updateMask,
             [CarrierID],
             [PhoneNumber],
             [SMSCNumber]
      FROM
        inserted;
  END
GO

EXEC sp_settriggerorder @triggername=N'[mobileunit].[MiXTalkCarrierPhoneNumber_CT_UTrig]', @order=N'Last', @stmttype=N'UPDATE'
GO

CREATE TRIGGER [mobileunit].[MiXTalkCarrierPhoneNumber_CT_DTrig] ON [mobileunit].[MiXTalkCarrierPhoneNumber]
FOR DELETE AS
IF NOT EXISTS (SELECT * FROM deleted) RETURN;

SET NOCOUNT ON

DECLARE @updateMask INT = 0xFFFFFFFF;

INSERT INTO  audit.mobileunit_MiXTalkCarrierPhoneNumber_CT
            (
              [Operation],
              [UpdateMask],
              [CarrierID],
              [PhoneNumber],
              [SMSCNumber]
            )
      SELECT 'D',
             @updateMask,
             [CarrierID],
             [PhoneNumber],
             [SMSCNumber]
      FROM
        deleted;
GO

EXEC sp_settriggerorder @triggername=N'[mobileunit].[MiXTalkCarrierPhoneNumber_CT_DTrig]', @order=N'Last', @stmttype=N'DELETE'
GO


----


CREATE PROCEDURE [state].[MobileUnitMessage_GetMiXTalkDevicesWithMasterNumbersSet]
  @mobileUnitIds [dbo].[SelectionIds] READONLY
AS

DECLARE @messages TABLE (
  MobileUnitId BIGINT, 
  CreationDateUtc DATETIMEOFFSET(7), 
  ExpiryDateUtc DATETIMEOFFSET(7), 
  MessageStatusDateUtc DATETIMEOFFSET(7), 
  MessageStatus TINYINT, 
  ParamsJson NVARCHAR(400)
)

INSERT INTO @messages
  SELECT MobileUnitId, CreationDateUtc, ExpiryDateUtc, MessageStatusDateUtc, MessageStatus, ParamsJson
    FROM [state].[MobileUnitMessage] mum WITH (NOLOCK)
  JOIN 
    @mobileUnitIds muIds ON muIds.id = mum.MobileUnitId
  WHERE
    ParamsJson like '%"CommandType":"MasterNumber%'
    AND MessageStatus <> 11 --Exclude Rejected

;WITH lastMessages AS
(
   SELECT MobileUnitId, CreationDateUtc, ExpiryDateUtc, MessageStatusDateUtc, MessageStatus, ParamsJson,
         ROW_NUMBER() OVER (PARTITION BY MobileUnitId ORDER BY CreationDateUtc DESC) AS rownumber
   FROM @messages
)

--Ensure these three required properties are still there
--MiXTalkIMEI (1471065106778105997), MiXTalkSIMNumber (-6213542348403873926), MiXTalkCarrierID (-6024391627074329223)
SELECT AssetId
FROM [DeviceConfiguration].[mobileunit].[AssetProperties] ap WITH (NOLOCK)
WHERE
  AssetId IN
    (SELECT MobileUnitId
    FROM lastMessages
    WHERE 
      rownumber = 1
      AND MessageStatus IN (25, 28))
  AND PropertyId IN (1471065106778105997, -6213542348403873926, -6024391627074329223)
Group By AssetId
HAVING Count(AssetId) >= 3




----



```
