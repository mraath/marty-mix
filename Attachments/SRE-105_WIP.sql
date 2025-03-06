CREATE PROCEDURE [state].[MobileUnitMessages_GetLatestDaylightSavingsCommands]
  @orgIdsUI       dbo.SelectionIds READONLY,
  @assetIdsUI     dbo.SelectionIds READONLY,
  @typeIdsUI      dbo.SelectionIds READONLY
AS
BEGIN
    ------------------------------------------------------------------- Get all the Parameters -------------------------
    -- In the UI, if the Org is inactive or if the site offset can't be found, the asset is not isplayed, as it won't be able to receive the DST command

    DECLARE @monthsBack INT = -6; --DST is every 6 month
    
    -- ORGS to work with
    DECLARE @orgIds TABLE ( 
        Id BIGINT
    );
    INSERT INTO @orgIds SELECT Id from @orgIdsUI;
    DECLARE @orgIdsCount INT = (SELECT COUNT(*)
    FROM @orgIds);
    IF (@orgIdsCount = 0)
    BEGIN
        --IF no orgs specified, use all
        INSERT INTO @orgIds
        SELECT DISTINCT GroupId
        FROM [DeviceConfiguration].library.libraries WITH (NOLOCK)
    END

    -- ASSETS to work with
    DECLARE @assetIds TABLE (
        Id BIGINT
    );
    INSERT INTO @assetIds SELECT Id from @assetIdsUI;
    DECLARE @assetIdsCount INT = (SELECT COUNT(*)
    FROM @assetIds);
    IF (@assetIdsCount = 0)
    BEGIN
        --IF no assets specified, use all
        INSERT INTO @assetIds
        SELECT DISTINCT AssetId
        FROM [DeviceConfiguration].mobileunit.AssetMobileUnits WITH (NOLOCK)
    END

    -- UNIT TYPES to work with
    DECLARE @typeIds TABLE (
        Id INT
    );
    INSERT INTO @typeIds SELECT Id from @typeIdsUI;
    DECLARE @typeIdsCount INT = (SELECT COUNT(*)
    FROM @typeIds);
    IF (@typeIdsCount = 0)
    BEGIN
        --IF no types specified, use all
        INSERT INTO @typeIds VALUES (1); --FM
        INSERT INTO @typeIds VALUES (3); --MESA
    END


    ------------------------------------------------------------------- Get all Mobile Units and set Blank Messages  -------------------------

    -- BOTH FM AND MESA -----------------------------------------------------------
    -- Get all FM, MESA (4K, 6K) mobile units, for these orgs, assets, types...

    -- GROUPS filtered to minimum info
    DECLARE @Groups TABLE (
        GroupId BIGINT,
        ConfigurationGroupKey INT
    )
    INSERT INTO @Groups
        SELECT ll.GroupId, tcg.ConfigurationGroupKey
        FROM @orgIds orgIds
        JOIN [DeviceConfiguration].library.libraries ll WITH (NOLOCK) on orgIds.id = ll.GroupId
        JOIN [DeviceConfiguration].template.ConfigurationGroups tcg WITH (NOLOCK) ON ll.LibraryKey = tcg.LibraryKey
    
    -- ASSETS filtered to minimum info
    DECLARE @Assets TABLE (
        AssetId BIGINT,
        MobileUnitKey INT,
        LegacyOrgId INT,
        LegacyVehicleId INT
    )
    INSERT INTO @Assets
        SELECT amu.AssetId, amu.MobileUnitKey, amu.LegacyOrgId, amu.LegacyVehicleId
        FROM @assetIds assetIds
        JOIN [DeviceConfiguration].mobileunit.AssetMobileUnits amu WITH (NOLOCK) ON assetIds.id = amu.AssetId 


    -- MobileUnits to return, this will hold all info returned
    IF OBJECT_ID('tempdb..#mobileUnits') IS NOT NULL
        DROP TABLE #mobileUnits;

    CREATE TABLE #mobileUnits (
        GroupId BIGINT,
        AssetId BIGINT,
        MobileUnitId BIGINT,
        sOrganisationName NVARCHAR(250),
        vDesc NVARCHAR(500),
        MobileDeviceTypeDescription NVARCHAR(250),
        LegacyOrgId INT,
        LegacyVehicleId INT,
        MobileUnitKey INT,
        MobileDeviceType INT,
        liGMTOffset INT,
        DisplayTimeZone NVARCHAR(500),
        [Message] NVARCHAR(500),
        [UniqueIdentifier] NVARCHAR(50)
    );

    -- All Mobile units for specified orgids, assetids, unit types
    INSERT INTO #mobileUnits
    SELECT 
        groups.GroupId,
        assets.AssetId, 
        mu.MobileUnitId, 
        '' as sOrganisationName,
        '' as vDesc,
        dmdt.[Description], 
        assets.LegacyOrgId, 
        assets.LegacyVehicleId, 
        mu.MobileUnitKey, 
        dmdt.MobileDeviceType, 
        0 as liGMTOffset, --This could give issues if the GMTOffset for this was not found, however, this shouldn't be the case
        '' as DisplayTimeZone,
        '' as [Message], --By default all devices will return an issue with the blank Message until we retrieve the latest from the DB
        mu.UniqueIdentifier
    FROM @Groups groups
        JOIN [DeviceConfiguration].mobileunit.MobileUnits mu WITH (NOLOCK) ON mu.ConfigurationGroupKey = groups.ConfigurationGroupKey
        JOIN @Assets assets ON mu.MobileUnitKey = assets.MobileUnitKey
        JOIN [DeviceConfiguration].definition.MobileDevices dmd WITH (NOLOCK) ON dmd.DeviceKey = mu.MobileDeviceKey
        JOIN [DeviceConfiguration].definition.MobileDeviceTypes dmdt WITH (NOLOCK) ON dmdt.MobileDeviceType = dmd.MobileDeviceType
        JOIN @typeIds typeIds ON typeIds.id = dmdt.MobileDeviceType
    WHERE mu.ConfigurationStatus NOT IN (0, 17, 18) --Commissioned State only

    ------------------------------------------------------------------- Get all Latest Messages for MESA  -------------------------

    -- MESA --------------------
    -- Find all messages for these mobileunits which are MESA devices

    -- All Messages
    DECLARE @messages TABLE (
        MobileUnitId BIGINT,
        MessageStatus INT,
        ParamsJson NVARCHAR(MAX),
        CreationDateUtc DATETIME
    );
    INSERT INTO @messages
    SELECT DISTINCT
        msg.MobileUnitId,
        msgh.MessageStatus,
        ParamsJson,
        msg.CreationDateUtc
    FROM #mobileUnits mu
        JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessage] msg WITH (NOLOCK) ON mu.MobileUnitId = msg.MobileUnitId
        JOIN [DeviceConfiguration.DataProcessing].[state].[MobileUnitMessageStateHistory] msgh WITH (NOLOCK) ON msgh.MessageKey = msg.MessageKey
    WHERE mu.MobileDeviceType IN (3)
        AND MessageSubType = 45
        AND (
            ( -- Not Expired, so can still be in created state
                ExpiryDateUtc >= GETDATE()
                AND msgh.MessageStatus IN (22) --(22)'Created'
            )
            OR 
            ( -- Post Expired, so must be in some success state
                msgh.MessageStatus IN (13, 25) --13 Acknowledged, 25 Complete
                AND (CreationDateUtc >= DATEADD(MONTH, @monthsBack, GETDATE())  -- After the cutoff time (6 months ago)
                    OR ParamsJson LIKE '%"Param3":946688400,%')                  -- OR No DST, then the param 3 value is this
            )
        );     

    -- Select Only last message for each mobile unit
    DECLARE @lastmessages TABLE (
        MobileUnitId BIGINT,
        MessageStatus INT,
        ParamsJson NVARCHAR(MAX),
        CreationDateUtc DATETIME,
        rn INT
    );
    INSERT INTO @lastmessages
    SELECT *
    FROM (
    SELECT MobileUnitId, MessageStatus, ParamsJson, CreationDateUtc, ROW_NUMBER() OVER (PARTITION BY MobileUnitId ORDER BY CreationDateUtc DESC) AS rn
        FROM @messages
    ) t
    WHERE rn = 1;


    ------------------------------------------------------------------- Get all Latest Messages for FM  -------------------------

    -- FM --------------------

    -- @orgIds holds all the orgids, but these are for mesa and fm
    -- it MIGHT be that once we got only valid mobile units,
    -- that we have fewer orgids to work with...
    -- So I will now just get orgIds for units which have valid mobile units

    DECLARE @validAssetDBOrgIds TABLE (
        Id BIGINT
    );
    INSERT INTO @validAssetDBOrgIds
    SELECT DISTINCT GroupId
    FROM #mobileUnits
    -- we also need SITE info for MESA

    -- Get all Org TZ offsets

    -- FM ORG Information
    DECLARE @organisations TABLE (
        GroupId BIGINT,
        liOrgID INT,
        sOrganisationName NVARCHAR(250),
        sConnectDatabase NVARCHAR(250),
        liGMTOffset INT
    );

    INSERT INTO @organisations
    SELECT GroupId, liOrgID, sOrganisationName, sConnectDatabase, liGMTOffset
    FROM [Fmonlinedb].dbo.organisation dboO WITH (NOLOCK)
        JOIN [Fmonlinedb].[DynaMiX].[Organisations] dynO WITH (NOLOCK) ON dynO.OrganisationId = dboO.liOrgID
        JOIN @validAssetDBOrgIds orgIds ON orgIds.Id = dynO.GroupId
    WHERE bActive = 1

    -- Get all assets > messenges: WIP 

    DECLARE @SQL NVARCHAR(MAX)

    -- Get all Sites for Assets that has units attached
    IF OBJECT_ID('tempdb..#Sites') IS NOT NULL
        DROP TABLE #Sites;

    CREATE TABLE #Sites
    (
        MobileUnitId BIGINT, 
        vDesc NVARCHAR(500),
        liOrgID INT,
        liSiteID INT, 
        sName NVARCHAR(500), 
        DisplayTimeZone NVARCHAR(500)
    )

    -- Store only the latest message for each asset
    IF OBJECT_ID('tempdb..#lastmessagesFM') IS NOT NULL
        DROP TABLE #lastmessagesFM;

    CREATE TABLE #lastmessagesFM 
    (
        MobileUnitId BIGINT,
        MessageStatus INT,
        ParamsJson NVARCHAR(MAX),
        CreationDateUtc DATETIME,
        rn INT
    );


    DECLARE @dbName NVARCHAR(500)
    DECLARE @orgid INT
    DECLARE dbCursor CURSOR FOR
    SELECT sConnectDatabase, liOrgID
    FROM @organisations

    OPEN dbCursor
    FETCH NEXT FROM dbCursor INTO @dbName, @orgid

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = N'USE ' + QUOTENAME(@dbName) + N';

            --Get all Site information needed for ALL assets
            INSERT INTO #Sites
                SELECT 
                mu.MobileUnitId, 
                v.sDesc as vDesc,
                mu.LegacyOrgId as liOrgID,
                s.liSiteID, 
                s.sName, 
                g.DisplayTimeZone
                FROM #mobileUnits mu
                INNER JOIN dbo.Vehicles v WITH (NOLOCK) ON v.iVehicleID = mu.LegacyVehicleId
                INNER JOIN dbo.Sites s WITH (NOLOCK) ON s.liSiteID = v.liSiteID
                INNER JOIN dynamix.Sites ds WITH (NOLOCK) ON ds.SiteID = v.liSiteID
                INNER JOIN [DynaMiX].[DynaMiX_Groups].[Groups] g WITH (NOLOCK) ON g.GroupId = ds.GroupId
                WHERE mu.LegacyOrgId = ' + CAST(@orgid AS NVARCHAR(250)) + N';

            --Get all Messages For FMs
            DECLARE @messagesFM TABLE (
                MobileUnitId BIGINT,
                MessageStatus INT,
                ParamsJson NVARCHAR(MAX),
                CreationDateUtc DATETIME
            );
            INSERT INTO @messagesFM
            SELECT DISTINCT
                mu.MobileUnitId,
                m.ucState as MessageStatus,
                m.sParams as ParamsJson,
                m.dtStarts as CreationDateUtc
            FROM #mobileUnits mu
                JOIN [dbo].[Messages] m WITH (NOLOCK) ON m.iVehicleID = mu.LegacyVehicleId
                --INNER JOIN dbo.messagestatehistory msh  WITH (NOLOCK) ON m.limessageid=msh.limessageid
            WHERE mu.MobileDeviceType IN (1) --FM
                AND REPLACE(sParams, '' '', '''') LIKE ''CommandID=45;%''
                AND (
                    ( -- Not expired so could still be in Created state
                        dtExpires >= GETDATE()
                        AND m.ucState IN (2)    -- (2) Pending
                    )
                    OR
                    ( -- Expired, so must be in success state
                        m.ucState IN (9) --9 Received
                        AND (dtStarts >= DATEADD(MONTH, ' + CAST(@monthsBack AS NVARCHAR(250)) + N', GETDATE()) 
                            OR REPLACE(sParams, '' '', '''') LIKE ''%dword:946688400;%'')
                    )
                );

            --Get only last Message for each Asset with a Mobile Unit - FM
            INSERT INTO #lastmessagesFM
            SELECT *
            FROM (
            SELECT MobileUnitId, MessageStatus, ParamsJson, CreationDateUtc, ROW_NUMBER() OVER (PARTITION BY MobileUnitId ORDER BY CreationDateUtc DESC) AS rn
                FROM @messagesFM
            ) t
            WHERE rn = 1;

            '

        EXEC sp_executesql @SQL
        ---

        FETCH NEXT FROM dbCursor INTO @dbName, @orgid
    END

    CLOSE dbCursor
    DEALLOCATE dbCursor


    --------------------- Only the last messages combined (FM and MESA)

    DECLARE @combinedLastMessages TABLE
    (
        MobileUnitId BIGINT,
        ParamsJson NVARCHAR(MAX),
        DisplayTimeZone NVARCHAR(500),
        liGMTOffset INT
    )


    -- Get Each MobileUnit with it's appropriate last message, if any
    -- AND site TimeZone, to test if this paramsJson is actually the correct last one
    INSERT INTO @combinedLastMessages
    SELECT 
        mu.MobileUnitId,
        CASE 
            WHEN mu.MobileDeviceType = '3' THEN lastM.ParamsJson --MESA
            WHEN mu.MobileDeviceType = '1' THEN lastF.ParamsJson --FM
            ELSE NULL
        END as ParamsJson,
        s.DisplayTimeZone,
        o.liGMTOffset
    FROM #mobileUnits mu
    LEFT JOIN #Sites s on s.MobileUnitId = mu.MobileUnitId
    LEFT JOIN @organisations o ON o.liOrgID = s.liOrgID
    LEFT JOIN @lastmessages lastM on lastM.MobileUnitId = mu.MobileUnitId
    LEFT JOIN #lastmessagesFM lastF on lastF.MobileUnitId = mu.MobileUnitId
    --WHERE messageSent IS NULL

    -- NOW add all the potential messages, offsets, timezone info to the MobileUnits
    UPDATE mu
    SET
        mu.[Message] = m.ParamsJson,
        mu.DisplayTimeZone = m.DisplayTimeZone,
        mu.liGMTOffset = m.liGMTOffset,
        mu.sOrganisationName = o.sOrganisationName,
        mu.vDesc = s.vDesc
    FROM #mobileUnits mu
    JOIN @combinedLastMessages m ON mu.MobileUnitId = m.MobileUnitId
    JOIN #Sites s ON s.MobileUnitId = mu.MobileUnitId
    JOIN @organisations o ON o.GroupId = mu.GroupId


    SELECT * 
    FROM #mobileUnits

END