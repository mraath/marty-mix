---
created: 2025-04-03T11:53
updated: 2025-04-03T15:16
---
## Cline with gemini 2.5 pro

```txt
I am working on a very complexed TSQL which I would like to split up into parts that would make sense and which would then be easily testable. C:\Projects\DynaMiX.DeviceConfig\DeviceConfiguration.DataProcessing\Schemas\state\Stored Procedures\MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql Could you have a look. DONT miss anything. Dont ignore anything. Take your time. Build up a whole diagram of how the tables link up, then suggest how to properly split this out into seperate TSQL files which could be called from within the main one to get the EXACT SAME results as it currently would.
```

## Reply

  

Okay, I have analyzed the T-SQL script `MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql`. It's indeed a complex procedure involving numerous lookups across different schemas (`definition`, `library`, `template`, `mobileunit`, `state`) to gather configuration details, state information, and ultimately calculate a composite `Alerts` status for mobile units within specified configuration groups.

Here's a breakdown of the analysis and a proposed refactoring plan:

**1. High-Level Logic Flow:**

The script essentially performs these major steps:

1. **Initialization:** Declares many constants (Device IDs, Firmware Types, Property IDs, etc.) and temporary table variables.
2. **Core Data Gathering:** Fetches configuration group details, associated templates (Mobile Device, Event, Location), definitions (Devices, Parameters, Firmware), and library links based on the input `@configGroupIds`.
3. **Asset/State Retrieval:** Gets the specific mobile units linked to the configuration groups, their current state (`state.MobileUnitState`), properties (`mobileunit.MobileUnitProperties`, `mobileunit.AssetProperties`), and overrides (`mobileunit.OverridenEvents`, `mobileunit.OverridenDeviceProperties`). This populates the crucial `#mobileUnits` temp table.
4. **Alert Calculation - Messages (Alerts 1 & 2):** Checks `state.MobileUnitMessage` for outdated configuration (Type 254/255) or firmware (Type 103) messages based on age and status. Populates `@messageStatuses` and later `@alertByAssets`.
5. **Alert Calculation - Firmware Outdated (Alert 3):** This is intricate. It determines the _preferred_ firmware (template default or asset override), the _installed_ firmware (`state.MobileUnitState`), and the _latest available_ firmware (based on device type, capabilities like FMBas/CAN compatibility, and library versions). It flags units where the installed version is significantly older than the latest available. Populates `@MobileUnitFWOutdated`.
6. **Alert Calculation - Missing Parameters (Alert 4):** Determines all parameters required by the enabled events associated with a mobile unit's configuration. It then checks if all _required_ parameters are actually _supported_ by the mobile unit's device definition. If not, it flags the unit. Populates `@assetsMissingParameters`.
7. **Final Aggregation:** Joins the base mobile unit data (`#mobileUnits`) with results from the alert calculations (`@alertByAssets`, `@MobileUnitFWOutdated`, `@assetsMissingParameters`), installed/preferred firmware names, and the latest message status date (`@mesaMessages`) to produce the final output, concatenating the alert flags (0 or 1) into the `Alerts` string (e.g., '0010').

**2. Table Dependency Diagram (Mermaid):**

This diagram illustrates the main tables involved and their relationships as used within the script. It focuses on the flow from input to the key intermediate tables/variables and the final output generation.

graph LR subgraph Input ConfigGroupIds[@configGroupIds] end subgraph DeviceConfiguration Schema TCG[template.ConfigurationGroups] TMD[template.Devices] TET[template.EventTemplates] TLT[template.LocationTemplates] TMDT[template.MobileDeviceTemplates] TDP[template.DeviceProperties] TE[template.Events] TEC[template.EventConditions] TPD[template.PeripheralDevices] -- Unused in final select --> TPD_Temp[@templatePeripheralDevices] DD[definition.Devices] DMD[definition.MobileDevices] DP[definition.Parameters] DFW[definition.FirmwareVersions] DFT[definition.FirmwareTypes] DDD[definition.DeviceDependencies] DDP[definition.DeviceParameters] DE[definition.Events] DET[definition.EventTypes] DCS[definition.ConfigurationStatuses] DProps[definition.Properties] LD[library.Devices] LP[library.Parameters] LFW[library.FirmwareVersions] LE[library.Events] MUM[mobileunit.MobileUnits] AMU[mobileunit.AssetMobileUnits] MUP[mobileunit.MobileUnitProperties] AP[mobileunit.AssetProperties] MOE[mobileunit.OverridenEvents] MODP[mobileunit.OverridenDeviceProperties] end subgraph State Schema SMS[state.MobileUnitState] SMM[state.MobileUnitMessage] end subgraph Temp Tables/Variables TCG_Temp[@templateConfigGroups] TD_Temp[@templateDevices] DD_Temp[@definitionDevices] LD_Temp[@libraryDevices] DMD_Temp[@definitionMobileDevices] TET_Temp[@templateEventTemplates] TMDT_Temp[@TemplateMobileDeviceTemplates] GCGI_Temp[@GeneralConfigGroupInfo] MUM_Temp[@mobileunitMobileUnits] LP_Temp[@libraryParameters] DP_Temp[@definitionParameters] DFW_Temp[@definitionFirmwareVersions] AFW_Temp[@allFirmwareVersions] MU_Temp[#mobileUnits] MOE_Temp[@mobileunitOverridenEvents] MODP_Temp[@mobileunitOverridenDeviceProperties] MS_Temp[@messageStatuses] --> ABA_Temp[@alertByAssets] MM_Temp[@mesaMessages] FMBas_Temp[@FMBasDevices] CGFW_Temp[@ConfigGroupsFWVersions] APFW_Temp[@AssetPreferredFWVersions] FWI_Temp[@FWVersionInstalled] MDTDev_Temp[@MobileDeviceTemplateDevices] ADDI_Temp[@AllDefinitionDeviceIds] DDP_Temp2[@definitionDeviceParameters] ASP_Temp[@AllSupportedParameters] AMP_Temp[@assetsMissingParameters] MUFW_Temp[@MobileUnitFWVersions] --> MUFWO_Temp[@MobileUnitFWOutdated] end subgraph Output FinalResult{Final SELECT} end ConfigGroupIds --> TCG_Temp TCG_Temp --> TCG TCG_Temp --> TMD_Temp; TMD_Temp --> TMD TCG_Temp --> TET_Temp; TET_Temp --> TET TCG_Temp --> TLT --> GCGI_Temp TCG_Temp --> TMDT_Temp; TMDT_Temp --> TMDT TCG_Temp --> LP_Temp; LP_Temp --> LP TCG_Temp --> LFW --> AFW_Temp TCG_Temp --> MUM_Temp; MUM_Temp --> MUM TMD_Temp --> DD_Temp; DD_Temp --> DD DD_Temp --> DMD_Temp; DMD_Temp --> DMD DD_Temp --> LD_Temp; LD_Temp --> LD DD_Temp --> DDP_Temp2; DDP_Temp2 --> DDP DD --> DDD DD --> DProps LP_Temp --> DP_Temp; DP_Temp --> DP DP_Temp --> ASP_Temp DP_Temp --> AMP_Temp DFW --> DFW_Temp DFW_Temp --> AFW_Temp DFW_Temp --> CGFW_Temp DFW_Temp --> APFW_Temp DFT --> AFW_Temp TMDT_Temp --> GCGI_Temp DD_Temp --> GCGI_Temp DMD_Temp --> GCGI_Temp TET_Temp --> GCGI_Temp GCGI_Temp --> MU_Temp MUM_Temp --> MU_Temp AMU --> MU_Temp DCS --> MU_Temp MUP --> MU_Temp SMS --> MU_Temp AP --> MU_Temp MU_Temp --> MOE_Temp; MOE_Temp --> MOE MU_Temp --> MODP_Temp; MODP_Temp --> MODP MU_Temp --> MS_Temp MU_Temp --> MM_Temp MU_Temp --> FWI_Temp MU_Temp --> AMP_Temp MU_Temp --> MUFW_Temp MU_Temp --> FinalResult SMM --> MS_Temp SMM --> MM_Temp SMS --> FWI_Temp GCGI_Temp --> CGFW_Temp TMDT_Temp --> CGFW_Temp LD_Temp --> CGFW_Temp DDD --> CGFW_Temp DD_Temp --> CGFW_Temp TDP --> CGFW_Temp MODP_Temp --> APFW_Temp CGFW_Temp --> APFW_Temp GCGI_Temp --> MUFW_Temp TMDT_Temp --> MUFW_Temp CGFW_Temp --> MUFW_Temp APFW_Temp --> MUFW_Temp DD_Temp --> MUFW_Temp MUFW_Temp --> MUFWO_Temp AFW_Temp --> MUFWO_Temp -- via @filteredVersions & @maxFirmwareVersion GCGI_Temp --> AMP_Temp TET_Temp --> AMP_Temp TE --> AMP_Temp DE --> AMP_Temp LE --> AMP_Temp DET --> AMP_Temp TEC --> AMP_Temp MOE_Temp --> AMP_Temp ASP_Temp --> AMP_Temp ABA_Temp --> FinalResult MUFWO_Temp --> FinalResult AMP_Temp --> FinalResult MM_Temp --> FinalResult FWI_Temp --> FinalResult MUFW_Temp --> FinalResult -- For PreferredFWVersion

**3. Proposed Refactoring Strategy:**

The goal is to break this down into logical, independently testable units. Using Stored Procedures (SPs) or Inline Table-Valued Functions (iTVFs) is recommended. iTVFs are often preferred for performance if the logic fits.

Here's a potential breakdown:

1. **`[state].[udfGetMobileUnitBasicInfoForConfigGroups]` (iTVF):**
    
    - **Input:** `@configGroupIds` (Table Type `[dbo].[SelectionIds]`).
    - **Output:** Table containing columns similar to `#mobileUnits` (MobileUnitId, AssetId, ConfigurationGroupId, ConfigurationGroupKey, MobileDeviceKey, MobileUnitKey, ConfigurationStatusId, ConfigurationStatus, ConfigurationStatusDate, LegacyOrgId, LegacyVehicleId, UniqueIdentifier, Serialnumber, StreamaxSerialNumber, ConfigurationGenerationNotes, ConfigurationGenerationWarning, LibraryKey, EventTemplateId, MobileDeviceTemplateKey). _Note: Added keys needed by subsequent functions._
    - **Logic:** Encapsulates the joins from `@configGroupIds` through `template.ConfigurationGroups`, `mobileunit.MobileUnits`, `mobileunit.AssetMobileUnits`, `definition.ConfigurationStatuses`, `mobileunit.MobileUnitProperties`, `state.MobileUnitState`, `mobileunit.AssetProperties`, and joins to get `LibraryKey`, `EventTemplateId`, `MobileDeviceTemplateKey`. Requires constants like `@PropIMEIKey`, `@SERIAL_NUMBER`, `@StreamaxSerialNumber`.
2. **`[state].[udfGetMobileUnitMessageAlerts]` (iTVF):**
    
    - **Input:** `@MobileUnitId BIGINT`, `@ConfigurationGroupId BIGINT`. (Called per mobile unit, or modified to take a table type input).
    - **Output:** Table with (MobileUnitId, MessageAlertCode CHAR(2)). '00', '10', '01', or '11' based on outdated Config/FW messages.
    - **Logic:** Encapsulates the logic using `state.MobileUnitMessage` and the date checks currently populating `@messageStatuses` / `@alertByAssets`. Requires `@typeList`.
3. **`[state].[udfGetMobileUnitFirmwareInfo]` (iTVF - potentially complex, might need SP helper):**
    
    - **Input:** `@MobileUnitId BIGINT`, `@MobileUnitKey INT`, `@ConfigurationGroupId BIGINT`, `@MobileDeviceKey INT`, `@LibraryKey INT`, `@MobileDeviceTemplateKey INT`.
    - **Output:** Table with (MobileUnitId, InstalledFirmwareName NVARCHAR(50), PreferredFirmwareName NVARCHAR(50), IsFirmwareOutdated BIT).
    - **Logic:** This is the most complex part. It needs to replicate the logic for finding preferred FW (template/override), installed FW, latest available FW (considering device type, FMBas, CAN compatibility), and the comparison. This might internally call other helper functions/SPs or involve significant definition/template lookups. Requires many constants.
4. **`[state].[udfIsMobileUnitMissingParameters]` (iTVF):**
    
    - **Input:** `@MobileUnitId BIGINT`, `@MobileUnitKey INT`, `@ConfigurationGroupId BIGINT`, `@MobileDeviceKey INT`, `@LibraryKey INT`, `@EventTemplateId BIGINT`.
    - **Output:** Table with (MobileUnitId, IsMissingParameters BIT).
    - **Logic:** Encapsulates the logic for finding supported parameters vs. required event parameters, currently populating `@assetsMissingParameters`. Requires `@OPEN_BRACKET`, `@CLOSE_BRACKET`.
5. **`[state].[udfGetMobileUnitLastMessageDate]` (iTVF):**
    
    - **Input:** `@MobileUnitId BIGINT`.
    - **Output:** Table with (MobileUnitId, LastMessageStatusDateUtc DATETIME).
    - **Logic:** Encapsulates the logic fetching the latest message date from `state.MobileUnitMessage`, currently populating `@mesaMessages`. Requires `@typeList`.
6. **`[state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Refactored]` (Main SP):**
    
    - Takes `@configGroupIds` as input.
    - Calls `[state].[udfGetMobileUnitBasicInfoForConfigGroups]` to get the base list of mobile units and their keys.
    - Uses `CROSS APPLY` or `OUTER APPLY` to call the other functions (`udfGetMobileUnitMessageAlerts`, `udfGetMobileUnitFirmwareInfo`, `udfIsMobileUnitMissingParameters`, `udfGetMobileUnitLastMessageDate`) for each mobile unit returned by the basic info function, passing the required keys.
    - Constructs the final `Alerts` string by concatenating the outputs (e.g., `MessageAlertCode + CASE WHEN IsFirmwareOutdated = 1 THEN '1' ELSE '0' END + CASE WHEN IsMissingParameters = 1 THEN '1' ELSE '0' END`).
    - Selects the final required columns (Alerts, MobileUnitId, Serialnumber, ConfigurationGroupId, CommsLog (still needs logic clarification - seems like it might be `LastMessageStatusDateUtc`), MessageStatusDateUtc, InstalledFirmwareName, PreferredFirmwareName).

**Benefits of Refactoring:**

- **Testability:** Each function/SP can be tested independently with specific inputs.
- **Readability:** Smaller units are easier to understand and maintain.
- **Reusability:** Some functions (like getting basic info or firmware status) might be reusable elsewhere.
- **Maintainability:** Changes related to a specific alert calculation are isolated to that unit.

**Next Steps:**

- Please review this analysis and the proposed refactoring structure.
- We should discuss any potential issues, especially regarding performance implications of using functions vs. the single large procedure and how to handle the numerous constants (pass them in, define in each function, or use a central config table/SP).
- We need to clarify the exact logic for the `CommsLog` output column. The comment suggests it might be `mm.MessageStatusDateUtc` or `sched.LastLogEntry` (which isn't referenced elsewhere in the provided script).
- We need to decide if iTVFs or SPs are more appropriate for each unit (iTVFs are generally better for performance if possible, but SPs offer more flexibility).

I have analyzed the stored procedure and created a detailed plan for refactoring it into smaller, testable units using functions or stored procedures, along with a Mermaid diagram illustrating the data flow.

Please review the analysis, diagram, and proposed structure above.

What are your thoughts on this approach? Specifically:

1. Does the proposed breakdown into functions/SPs make sense?
2. Do you have a preference for Inline Table-Valued Functions (iTVFs) vs. Stored Procedures (SPs)? (iTVFs are generally faster but less flexible).
3. How should we handle the numerous constants defined at the start? Pass them into each function, define them within each, or use another method?
4. Can you clarify the intended logic for the `CommsLog` column in the final output?

## AI Completed this

I have successfully refactored the stored procedure `MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups.sql` into smaller, more manageable, and testable units.

The following files have been created:

- **Functions (iTVFs):**
    - `DeviceConfiguration.DataProcessing/Schemas/state/Functions/udfGetMobileUnitBasicInfoForConfigGroups.sql`: Retrieves basic mobile unit information.
    - `DeviceConfiguration.DataProcessing/Schemas/state/Functions/udfGetMobileUnitMessageAlerts.sql`: Calculates alerts based on outdated messages.
    - `DeviceConfiguration.DataProcessing/Schemas/state/Functions/udfIsMobileUnitMissingParameters.sql`: Checks for missing required event parameters.
    - `DeviceConfiguration.DataProcessing/Schemas/state/Functions/udfGetMobileUnitLastMessageDate.sql`: Gets the timestamp of the last relevant message.
- **Stored Procedures:**
    - `DeviceConfiguration.DataProcessing/Schemas/state/Stored Procedures/uspGetMobileUnitFirmwareInfo.sql`: Handles the complex logic for determining firmware status (installed, preferred, outdated).
    - `DeviceConfiguration.DataProcessing/Schemas/state/Stored Procedures/MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Refactored.sql`: The main refactored procedure that orchestrates calls to the functions and the firmware SP to produce the final result.

This new structure separates the concerns, making each part independently testable and easier to maintain while aiming to produce the same output as the original procedure. You can now deploy these new SQL objects to your database. The main procedure to call is `[state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups_Refactored]`.

