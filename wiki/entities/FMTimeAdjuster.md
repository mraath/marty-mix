---
type: entity
entity_type: System
name: FMTimeAdjuster
aliases:
  - DaylightSavingsTimeAdjusterNew
  - FMTimeAdjuster.Api
  - FM Time Adjuster
sources:
  - DST Daylight Saving Times/DST Debug Guide.md
  - DST Daylight Saving Times/DST Code Paths.md
  - OMAN DST Command 45 Setup.md
  - OMAN-DST-Server-Quick-Reference.md
  - ETS/ETS-8669 OMAN Command 45 DST issue.md
last_updated: 2026-05-28
---

FMTimeAdjuster is the manual Windows tool used by support staff to trigger [[Command-45]] for specific orgs/assets. It consists of a WinForms application (client) and a Nancy API (`FMTimeAdjuster.Api`) hosted in IIS. The modern redesigned version is `DaylightSavingsTimeAdjusterNew` (CONFIG-3387, 2023).

## Key Facts

- **Tool location (AU):** `C:\Projects\DaylightSavingsTimeAdjusterNew` on HSSYDATS02
- **Tool location (OMAN):** `C:\Projects\` on HSOMNIIS19 — use the **older** version, not the newer one
- **CRITICAL:** Must be run **directly on the IIS server** — NOT from a jumpbox. Network/firewall blocks jumpbox auth routing
- **API log:** `L:\WebServices\DynaMiX.DeviceConfig.FMTimeAdjuster.Api\DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log`
- Calls Config.Api directly — no DynaMiX.Backend involvement
- Two-step process: (1) POST `/outdated-daylight-savings` → get outdated assets; (2) POST `/send-command-to-outdated-daylight-savings` → send commands

## Authentication Architecture

```
Tool → POST /authentication/token → DynaMiX.Api → writes session to Redis (index N)
Tool → POST /sendcommand/... → FMTimeAdjuster.Api → reads session from Redis (index M)
⚠️  N must equal M — both web.configs must have identical RedisServerUrl + RedisDatabaseIndex
```

## Per-Environment Servers

| Environment | IIS Server | Tool Path |
|---|---|---|
| OMAN | HSOMNIIS18/19 | `C:\Projects\` on HSOMNIIS19 (use older version) |
| AU/SYD | HSSYDIIS46-47 | `C:\Projects\DaylightSavingsTimeAdjusterNew` on HSSYDATS02 |
| ALG | HSATSDMXIIS01 | Copied from OMAN (same setup) |

## Connections

- [[Command-45]] — the command this tool sends
- [[DST]] — parent concept
- [[Config-Api]] — called by the tool to dispatch commands
- [[DynaMiX-Backend]] — hosts `DeviceIntegrationManager` (called internally by Config.Api)
- [[OMAN-Environment]] — ETS-8669 root cause: jumpbox vs IIS server issue
- [[ETS-8669]] — full incident RCA

## Open Questions

- [ ] OPEN-2438: Can the CommandLine tool be ported to OMAN 18.17?
