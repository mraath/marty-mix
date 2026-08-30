---
type: entity
entity_type: System
name: Iridium Integration
aliases:
  - Iridium Solution Integration
  - Iridium Satellite Integration
sources:
  - iridium-system-integration
last_updated: 2026-08-26
---

End-to-end architecture connecting Iridium satellite hardware to MiX Fleet Manager. Two paths converge into DynaMiX: a raw hardware/serial link (FM Unit – S3 → Iridium modem → open-air link → Iridium Sat) and an API/provisioning link (Iridium API/Gateway ↔ FLEET (DynaMiX)), both feeding a shared downstream pipeline into the Asset database.

## Key Facts

- **Hardware path**: `FM Unit – S3` → serial comms → `Iridium modem` → open-air link → `Iridium Sat` (direct satellite link, bypasses the API side entirely).
- **API path**: `Iridium API` ↔ `Iridium Gateway` (both "Iridium side", i.e. Iridium's own infrastructure) ↔ `FLEET (DynaMiX)` — this is the provisioning/query/command channel, and where `IridiumManager` (see [[DynaMiX-Backend]]) lives.
- **Comms team tier**: `MiX.Connect.Iridium.Services.Comms` and `MiX.Connect.Iridium.Services.Publisher` sit between the Iridium Gateway and the downstream queue — both owned by the **Comms team**, both fronted by `MiX.Connect REST API` for queries/commands, and both feeding real-time data subscriptions.
- **Downstream pipeline**: `Iridium Queue` → `Iridium Incoming service` (does **IMEI validate & cache**, processes events/positions, creates a `.dmp` file) → a dedicated `DataProcessor` (shared with Satamatics for other sat messages) → `Asset database` → `MiX Fleet Manager` (Info Hub, Tracking Live/Historical, Timeline) and `MiX Insight reports`.
- **Logging**: four separate log files exist across this pipeline — `MiX.Connect.Iridium.Services.Comms`, `.Publisher`, `Iridium Incoming service`, and `DataProcessor` — each marked as a distinct log source on the diagram. Useful checklist when triaging an Iridium issue end to end.
- IMEI validation/caching happens in the **Iridium Incoming service**, which is downstream of the Comms tier and upstream of the DataProcessor/Asset database — i.e. an "IMEI not recognized" condition could originate in either the Comms tier's lookup or this later validate/cache step, not necessarily the same place.

## Connections

- [[DynaMiX-Backend]] — hosts `FLEET (DynaMiX)`, which talks to the Iridium API for provisioning/queries/commands (`IridiumManager.GetIridiumAccountInfo`, `AddIridiumContractToAsset` in `AssetCommissioningManager`)

## Open Questions

- 2026-08-26: investigating a `NullReferenceException` in `DynaMiX.Logic.Operations.IridiumManager.GetIridiumAccountInfo` (AU, production). Working theory: an Iridium account lookup by IMEI returns null (e.g. IMEI not found/provisioned) and the calling code doesn't null-check before use. Not yet confirmed against the actual source at `IridiumManager.cs:568`. This diagram doesn't show where account-lookup-by-IMEI happens on the Iridium side specifically (it shows IMEI validate/cache in the Iridium Incoming service, not the FLEET↔Iridium API provisioning path) — worth clarifying with the Comms team whether `GetIridiumAccountInfo` calls out to their tier or purely queries DynaMiX's own local IridiumManager storage.
