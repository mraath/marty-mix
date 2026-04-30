-- OPEN-2029: ConfigDiff schema setup for DeviceConfiguration (INT)
-- Safe to run multiple times — all statements are guarded with IF NOT EXISTS.
-- Run against: DSINTSQL01 / DeviceConfiguration

USE [DeviceConfiguration];

-- ─── Schema ───────────────────────────────────────────────────────────────────

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'configdiff')
    EXEC('CREATE SCHEMA [configdiff] AUTHORIZATION dbo');

-- ─── Audit CT Tables ──────────────────────────────────────────────────────────

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'audit' AND t.name = 'configdiff_ConfigDiffCases_CT')
    CREATE TABLE [audit].[configdiff_ConfigDiffCases_CT]
    (
        [RID]               INT               NOT NULL CONSTRAINT [PK_configdiff_ConfigDiffCases_CT] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [ChangeDate]        DATETIMEOFFSET(0) NOT NULL CONSTRAINT [DF_configdiff_ConfigDiffCases_CT_ChangeDate] DEFAULT (SYSUTCDATETIME()),
        [Operation]         CHAR(1)           NOT NULL,
        [UpdateMask]        INT               NOT NULL,
        [ConfigDiffCaseKey] INT               NOT NULL,
        [Name]              NVARCHAR(255)     NOT NULL,
        [DisplayName]       NVARCHAR(500)     NOT NULL,
        [StandardFilePath]  NVARCHAR(MAX)     NULL,
        [OrganisationId]    NVARCHAR(100)     NULL,
        [ConfigGroupIds]    NVARCHAR(MAX)     NULL,
        [AssetIds]          NVARCHAR(MAX)     NULL,
        [AssetNames]        NVARCHAR(MAX)     NULL,
        [CreatedBy]         NVARCHAR(255)     NULL,
        [CreatedAt]         DATETIMEOFFSET(0) NOT NULL,
        [UpdatedAt]         DATETIMEOFFSET(0) NULL
    );

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'audit' AND t.name = 'configdiff_ConfigDiffCaseAssets_CT')
    CREATE TABLE [audit].[configdiff_ConfigDiffCaseAssets_CT]
    (
        [RID]                    INT               NOT NULL CONSTRAINT [PK_configdiff_ConfigDiffCaseAssets_CT] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [ChangeDate]             DATETIMEOFFSET(0) NOT NULL CONSTRAINT [DF_configdiff_ConfigDiffCaseAssets_CT_ChangeDate] DEFAULT (SYSUTCDATETIME()),
        [Operation]              CHAR(1)           NOT NULL,
        [UpdateMask]             INT               NOT NULL,
        [ConfigDiffCaseAssetKey] INT               NOT NULL,
        [ConfigDiffCaseKey]      INT               NOT NULL,
        [AssetId]                NVARCHAR(100)     NOT NULL,
        [ConfigJson]             NVARCHAR(MAX)     NULL,
        [CreatedAt]              DATETIMEOFFSET(0) NOT NULL
    );

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'audit' AND t.name = 'configdiff_ConfigDiffCaseDiffs_CT')
    CREATE TABLE [audit].[configdiff_ConfigDiffCaseDiffs_CT]
    (
        [RID]                   INT               NOT NULL CONSTRAINT [PK_configdiff_ConfigDiffCaseDiffs_CT] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [ChangeDate]            DATETIMEOFFSET(0) NOT NULL CONSTRAINT [DF_configdiff_ConfigDiffCaseDiffs_CT_ChangeDate] DEFAULT (SYSUTCDATETIME()),
        [Operation]             CHAR(1)           NOT NULL,
        [UpdateMask]            INT               NOT NULL,
        [ConfigDiffCaseDiffKey] INT               NOT NULL,
        [ConfigDiffCaseKey]     INT               NOT NULL,
        [DiffJson]              NVARCHAR(MAX)     NOT NULL,
        [GeneratedAt]           DATETIMEOFFSET(0) NOT NULL
    );

-- ─── Main Tables ──────────────────────────────────────────────────────────────

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'configdiff' AND t.name = 'ConfigDiffCases')
BEGIN
    CREATE TABLE [configdiff].[ConfigDiffCases]
    (
        [ConfigDiffCaseKey]  INT               NOT NULL CONSTRAINT [PK_ConfigDiffCases] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [Name]               NVARCHAR(255)     NOT NULL,
        [DisplayName]        NVARCHAR(500)     NOT NULL,
        [StandardFilePath]   NVARCHAR(MAX)     NULL,
        [OrganisationId]     NVARCHAR(100)     NULL,
        [ConfigGroupIds]     NVARCHAR(MAX)     NULL,
        [AssetIds]           NVARCHAR(MAX)     NULL,
        [AssetNames]         NVARCHAR(MAX)     NULL,
        [CreatedBy]          NVARCHAR(255)     NULL,
        [CreatedAt]          DATETIMEOFFSET(0) NOT NULL,
        [UpdatedAt]          DATETIMEOFFSET(0) NULL,
        CONSTRAINT [UQ_ConfigDiffCases_Name] UNIQUE NONCLUSTERED ([Name])
    );
END;

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'configdiff' AND t.name = 'ConfigDiffCaseAssets')
BEGIN
    CREATE TABLE [configdiff].[ConfigDiffCaseAssets]
    (
        [ConfigDiffCaseAssetKey] INT               NOT NULL CONSTRAINT [PK_ConfigDiffCaseAssets] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [ConfigDiffCaseKey]      INT               NOT NULL,
        [AssetId]                NVARCHAR(100)     NOT NULL,
        [ConfigJson]             NVARCHAR(MAX)     NULL,
        [CreatedAt]              DATETIMEOFFSET(0) NOT NULL,
        CONSTRAINT [UQ_ConfigDiffCaseAssets_CaseKey_AssetId] UNIQUE NONCLUSTERED ([ConfigDiffCaseKey], [AssetId]),
        CONSTRAINT [FK_ConfigDiffCaseAssets_ConfigDiffCases] FOREIGN KEY ([ConfigDiffCaseKey]) REFERENCES [configdiff].[ConfigDiffCases] ([ConfigDiffCaseKey]) ON DELETE CASCADE
    );

    CREATE NONCLUSTERED INDEX [IX_ConfigDiffCaseAssets_ConfigDiffCaseKey]
        ON [configdiff].[ConfigDiffCaseAssets] ([ConfigDiffCaseKey]);
END;

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'configdiff' AND t.name = 'ConfigDiffCaseDiffs')
BEGIN
    CREATE TABLE [configdiff].[ConfigDiffCaseDiffs]
    (
        [ConfigDiffCaseDiffKey] INT               NOT NULL CONSTRAINT [PK_ConfigDiffCaseDiffs] PRIMARY KEY CLUSTERED IDENTITY(1, 1),
        [ConfigDiffCaseKey]     INT               NOT NULL,
        [DiffJson]              NVARCHAR(MAX)     NOT NULL,
        [GeneratedAt]           DATETIMEOFFSET(0) NOT NULL,
        CONSTRAINT [FK_ConfigDiffCaseDiffs_ConfigDiffCases] FOREIGN KEY ([ConfigDiffCaseKey]) REFERENCES [configdiff].[ConfigDiffCases] ([ConfigDiffCaseKey]) ON DELETE CASCADE
    );

    CREATE NONCLUSTERED INDEX [IX_ConfigDiffCaseDiffs_ConfigDiffCaseKey]
        ON [configdiff].[ConfigDiffCaseDiffs] ([ConfigDiffCaseKey]);
END;

-- ─── Audit Triggers ───────────────────────────────────────────────────────────

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCases_CT_ITrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCases_CT_ITrig] ON [configdiff].[ConfigDiffCases] FOR INSERT AS IF @@ROWCOUNT = 0 RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCases_CT] ([Operation],[UpdateMask],[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt]) SELECT ''I'',@updateMask,[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt] FROM inserted;');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCases_CT_UTrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCases_CT_UTrig] ON [configdiff].[ConfigDiffCases] FOR UPDATE AS IF @@ROWCOUNT = 0 RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0; IF UPDATE([Name]) SET @updateMask |= 0x40000000; IF UPDATE([DisplayName]) SET @updateMask |= 0x20000000; IF UPDATE([StandardFilePath]) SET @updateMask |= 0x10000000; IF UPDATE([OrganisationId]) SET @updateMask |= 0x08000000; IF UPDATE([ConfigGroupIds]) SET @updateMask |= 0x04000000; IF UPDATE([AssetIds]) SET @updateMask |= 0x02000000; IF UPDATE([AssetNames]) SET @updateMask |= 0x01000000; IF UPDATE([CreatedBy]) SET @updateMask |= 0x00800000; IF UPDATE([CreatedAt]) SET @updateMask |= 0x00400000; IF UPDATE([UpdatedAt]) SET @updateMask |= 0x00200000; IF @updateMask != 0 BEGIN INSERT INTO [audit].[configdiff_ConfigDiffCases_CT] ([Operation],[UpdateMask],[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt]) SELECT ''U'',@updateMask,[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt] FROM inserted; END');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCases_CT_DTrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCases_CT_DTrig] ON [configdiff].[ConfigDiffCases] FOR DELETE AS IF NOT EXISTS (SELECT * FROM deleted) RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCases_CT] ([Operation],[UpdateMask],[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt]) SELECT ''D'',@updateMask,[ConfigDiffCaseKey],[Name],[DisplayName],[StandardFilePath],[OrganisationId],[ConfigGroupIds],[AssetIds],[AssetNames],[CreatedBy],[CreatedAt],[UpdatedAt] FROM deleted;');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCaseAssets_CT_ITrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCaseAssets_CT_ITrig] ON [configdiff].[ConfigDiffCaseAssets] FOR INSERT AS IF @@ROWCOUNT = 0 RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCaseAssets_CT] ([Operation],[UpdateMask],[ConfigDiffCaseAssetKey],[ConfigDiffCaseKey],[AssetId],[ConfigJson],[CreatedAt]) SELECT ''I'',@updateMask,[ConfigDiffCaseAssetKey],[ConfigDiffCaseKey],[AssetId],[ConfigJson],[CreatedAt] FROM inserted;');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCaseAssets_CT_DTrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCaseAssets_CT_DTrig] ON [configdiff].[ConfigDiffCaseAssets] FOR DELETE AS IF NOT EXISTS (SELECT * FROM deleted) RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCaseAssets_CT] ([Operation],[UpdateMask],[ConfigDiffCaseAssetKey],[ConfigDiffCaseKey],[AssetId],[ConfigJson],[CreatedAt]) SELECT ''D'',@updateMask,[ConfigDiffCaseAssetKey],[ConfigDiffCaseKey],[AssetId],[ConfigJson],[CreatedAt] FROM deleted;');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCaseDiffs_CT_ITrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCaseDiffs_CT_ITrig] ON [configdiff].[ConfigDiffCaseDiffs] FOR INSERT AS IF @@ROWCOUNT = 0 RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCaseDiffs_CT] ([Operation],[UpdateMask],[ConfigDiffCaseDiffKey],[ConfigDiffCaseKey],[DiffJson],[GeneratedAt]) SELECT ''I'',@updateMask,[ConfigDiffCaseDiffKey],[ConfigDiffCaseKey],[DiffJson],[GeneratedAt] FROM inserted;');

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'ConfigDiffCaseDiffs_CT_DTrig')
    EXEC('CREATE TRIGGER [configdiff].[ConfigDiffCaseDiffs_CT_DTrig] ON [configdiff].[ConfigDiffCaseDiffs] FOR DELETE AS IF NOT EXISTS (SELECT * FROM deleted) RETURN; SET NOCOUNT ON; DECLARE @updateMask INT = 0xFFFFFFFF; INSERT INTO [audit].[configdiff_ConfigDiffCaseDiffs_CT] ([Operation],[UpdateMask],[ConfigDiffCaseDiffKey],[ConfigDiffCaseKey],[DiffJson],[GeneratedAt]) SELECT ''D'',@updateMask,[ConfigDiffCaseDiffKey],[ConfigDiffCaseKey],[DiffJson],[GeneratedAt] FROM deleted;');

-- ─── Permissions ─────────────────────────────────────────────────────────────

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[configdiff] TO [FMWeb];

PRINT 'OPEN-2029: ConfigDiff schema setup complete.';
