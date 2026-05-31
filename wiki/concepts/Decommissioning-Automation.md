---
type: concept
name: Decommissioning Automation
aliases:
  - Decomm Automation
  - Decommissioning Phase 1
sources:
  - Operations Tools.md
  - Walkthrough - Decommissioning UI & Auth Updates.md
  - OPEN/OPEN-1576 Add UI for Decom Automation manually.md
  - OPEN/OPEN-1730 Change the UI for Decomm.md
last_updated: 2026-05-28
---

Decommissioning Automation is the workflow in [[Ops-Tools]] that automates the decommissioning of mobile units. Support staff can trigger a decommission via Salesforce case info or manually via the UI.

## Core Ideas

- Support staff enters IMEI(s) + Salesforce case info to trigger a decommission run
- The API performs the decommission steps and returns a result
- Auth proxied through Automation API (`AuthController.cs`) → `MiX.ConfigInternal.Api.Client`
- Shares UI structure with [[QC-Automation]] — same "Device type" dropdown, same form pattern
- Phase 1 shipped ✅

## Key Tickets (Phase 1 — Done)

| Ticket | Description |
|---|---|
| OPEN-1545 | Decommissioning Automation Phase 1 |
| OPEN-1567 | Add Decommissioning Endpoint |
| OPEN-1576 | Add UI for support to supply Salesforce case info + start Decom manually |
| OPEN-1730 | Change UI for Decomm to accommodate required info |

## Auth Flow

```
UI → POST /api/auth → AuthController.cs (Automation API)
       → MiX.ConfigInternal.Api.Client → Config API auth
       → Returns token for subsequent calls
```

> Publishing a new `MiX.ConfigInternal.Api.Client` NuGet package required when `ConfigInternalClient.cs` is modified.

## Connections

- [[Ops-Tools]] — parent project
- [[QC-Automation]] — sister feature, shares UI components
- [[Config-Api]] — downstream for decommission operations
