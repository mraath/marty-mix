---
type: concept
name: Alerts Feature
aliases:
  - Config Group Alerts
  - Asset Alerts
  - OE-614 Alerts
  - MobileUnit Alerts
sources:
  - Alerts Summary.md
  - Alerts with AI.md
  - AI Alerts Feedback 1.md
  - AI FW Versions.md
last_updated: 2026-05-28
---

The Alerts Feature is part of the Config Groups page and surfaces health/compliance warnings per mobile unit. Four alert types are encoded as a 4-character bit string (e.g. `0010` = only Alert 3 is active).

## The Four Alerts

| # | Alert | Trigger | Threshold |
|---|---|---|---|
| 1 | Config upload requested too long | Latest message type 254/255 is older than threshold AND status NOT IN (10, 12, 13, 25, 28) | 5 days |
| 2 | FW upload requested too long | Latest message type 103 is older than threshold AND bad status | 3 days |
| 3 | Preferred FW more than 2 versions old | Installed FW vs preferred FW vs latest available — complex comparison | 2 versions |
| 4 | Missing parameters | Required parameters for enabled events not supported by the device definition | Any |

## Alert String Format

`Alerts` column is a 4-char string: positions 1-4 map to Alert 1-4. `0` = no alert, `1` = alert active.
- `'0000'` = all healthy
- `'1010'` = Alert 1 (config stale) + Alert 3 (FW outdated)

## Key Stored Procedures

| SP | Purpose |
|---|---|
| `[state].[MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups]` | Master alert calculator — joins 30+ tables |
| `[state].[MobileUnit_GetMobileUnitMessageAlerts]` | Alert 1 & 2 — message-based alerts |
| `[state].[MobileUnit_GetMobileUnitFirmwareInfo]` | Alert 3 — firmware version comparison |

## Key Message Status Codes (for Alert 1 & 2)

| Status | Meaning |
|---|---|
| 10 | Accepted |
| 12 | Completed |
| 13 | Acknowledged |
| 25 | Complete |
| 28 | Confirmed |
> These statuses mean the command was handled — unit does NOT trigger an alert.

## AI Integration (AI Alerts)

AI (Gemini/GPT) was used to help refactor the complex `MobileUnit_GetAllMobileUnitAlertsForConfigurationGroups` SP into smaller testable units. Also used for AI-driven alert explanation/surfacing in the UI.

## Connections

- [[Config-Groups-Page]] — alerts are displayed in the Config Groups UI
- [[Config-Api]] — exposes alert data via API
- [[DynaMiX-Backend]] — alert calculation logic originates here
- [[Ops-Tools]] — team that maintains alerts feature
