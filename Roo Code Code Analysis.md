---
created: 2025-04-08T16:21
updated: 2025-04-08T16:21
---
Okay, here is the textual breakdown of the C# logic flow for determining the "Missing Parameters" status, synthesizing the information from the different files:

**1. Entry Point & Initial Data Loading (`MobileUnitEventsModule.GetEventTemplate`)**

- **Lines 77-81:** Loads the primary data aggregates needed:
    - `Asset` (via `IAssetManager`)
    - `MobileUnit` aggregate (including overrides) via `IMobileUnitManager.GetMobileUnitAggregate` (which calls `ConfigAdminRepository.GetMobileUnitAggregate`).
    - `ConfigurationGroup` (via `IConfigurationGroupManager`)
    - `EventTemplate` aggregate via `IEventTemplateManager.GetEventTemplateAggregate`.
    - `MobileDeviceTemplate` aggregate via `IMobileDeviceTemplateManager.GetMobileDeviceTemplateAggregate`.

**2. Configuration Resolution (`MobileUnitManager.GetEffectiveConfig`)**

- **Line 83 (`MobileUnitEventsModule`):** Calls `IMobileUnitManager.GetEffectiveConfig`, passing the loaded `MobileUnit`, `MobileDeviceTemplate`, and `EventTemplate`.
- **Inside `MobileUnitManager.GetEffectiveConfig` (Main Overload - lines 798-803):**
    - Calls `GetResolvedMobileDevice` first.
- **Inside `MobileUnitManager.GetResolvedMobileDevice` (lines 703-779):**
    - Starts with the base `MobileDeviceTemplate`.
    - Applies overrides from the `MobileUnit` aggregate in sequence:
        - `MobileUnitProperties`
        - `OverridenPeripheralDevices` (handles connection status via `LineId`, enablement, power, etc.)
        - `OverridenDevices` (handles logical device enablement)
        - `OverridenDeviceParameters` (calibration)
        - `OverridenDeviceProperties`
    - Returns the `resolvedMobileDevice` object representing the actual hardware state.
- **Inside `MobileUnitManager.GetEffectiveConfig` (Core Helper - lines 813-885):**
    - Takes the `resolvedMobileDevice`.
    - **Lines 819-821:** Filters out devices (logical and peripheral) where `IsEnabled` is false in the `resolvedMobileDevice`.
    - **Lines 824-828:** Collects the `DefinitionDeviceId`s of all _enabled_ devices (main + logical + peripheral).
    - **Lines 830-839:** Determines `config.AllSupportedParameters`:
        - Fetches `LibraryDeviceParameter`s (via `ConfigAdminRepository.GetLibraryDeviceParameters`).
        - Filters these parameters to include only those associated with the collected `DefinitionDeviceId`s of the _enabled_ devices.
    - **Lines 841-884:** Processes events from the `EventTemplate`:
        - **Line 848:** Applies `OverridenEvent` from the `MobileUnit` aggregate to determine the event's `IsEnabled` status.
        - **Lines 854-864:** Checks Event Conditions: For each condition of the event, it looks up the required `DefinitionParameterId`. It checks if this parameter ID exists in the previously determined `config.AllSupportedParameters` list.
        - **Implicit `MonitoredEvents` Logic:** An event is implicitly considered "Monitored" only if it's enabled _and_ all its required condition parameters are found within `config.AllSupportedParameters`.

**3. Status Determination (`MobileUnitEventsModule.GetEventTemplate`)**

- **Line 90:** Iterates through `config.AllEvents` (which contains events processed in the previous step).
- **Line 96:** Checks if the current event `evnt` is enabled (`evnt.IsEnabled`).
- **Line 98:** If enabled, checks if the event is _NOT_ contained within `config.MonitoredEvents`. (This means the event was enabled, but during the resolution step, at least one of its required parameters was found to be _unsupported_ by the active hardware configuration).
- **Line 100:** If the event is enabled but _not_ in `MonitoredEvents`, sets `eventStatus = EventStatus.NoParameters`.
- **Lines 103-114:** If the event _is_ in `MonitoredEvents` (i.e., parameters are supported), it then performs separate checks (e.g., for `EventType == EventType.MiXVision`) to potentially set other statuses like `EventStatus.NoPeripheral`. This does not affect the `NoParameters` determination.
- **Lines 118-128:** Assigns the final `eventStatus` description and actions to the carrier object being returned by the API.

This detailed flow shows how the application starts with base templates, applies unit-specific overrides to determine the actual hardware state, identifies supported parameters based on that state, and finally checks if enabled events rely on any unsupported parameters to set the `NoParameters` status.
