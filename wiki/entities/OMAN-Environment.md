---
type: entity
entity_type: System
name: OMAN Environment
aliases:
  - OMN
  - OMAN
sources:
  - DST Daylight Saving Times/DST Debug Guide.md
  - OMAN DST Command 45 Setup.md
  - OMAN-DST-Server-Quick-Reference.md
  - ETS/ETS-8669 OMAN Command 45 DST issue.md
last_updated: 2026-05-28
---

The OMAN production environment runs MiX Telematics version **18.17**, which is an unsupported legacy version. No code deployments are expected to this environment — any fixes are workarounds only. The real fix is an upgrade.

## Key Facts

- **Version:** 18.17 (unsupported)
- **Gateway:** `omntsg.mixtelematics.com`
- **DynaMiX API:** `https://om.mixtelematics.com/DynaMiX.Services.Api`
- **FMTimeAdjuster.Api:** `https://om.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api`
- **DeviceConfig API (internal):** `http://api.deviceconfig.omn.production.local`
- **Redis:** `10.25.2.23`, database index `2`
- Key org: **Schlumberger-OPG-Oman** — OrgID `700083822000352569`, DB `Schlumberger-OPG-Oman`

## Servers

| Server | Role |
|---|---|
| HSOMNIIS18 | DynaMiX API + FMTimeAdjuster.Api (IIS) |
| HSOMNIIS19 | DynaMiX API + FMTimeAdjuster.Api (IIS) |
| HSOMNAPP03 | App server |
| HSOMNAPP09 | App server |
| HSOMNMSMQ03 | MSMQ server |
| HSOMNATS01 | Support utility server |

## DST Gotchas (OMAN-specific)

- **CRITICAL:** FMTimeAdjuster tool must be run **directly on HSOMNIIS19** — not from jumpbox
- On HSOMNIIS19 under `C:\Projects\` there are **two versions** of the tool — use the **older one**
- Load balancer may write logs on either IIS18 or IIS19 — this is normal
- All four `web.config` files (IIS18+IIS19, both APIs) must have identical `RedisServerUrl` + `RedisDatabaseIndex`

## Connections

- [[Command-45]] — DST command affected by OMAN limitations
- [[FMTimeAdjuster]] — manual tool used in OMAN
- [[ETS-8669]] — OMAN Command 45 DST incident (March 2026)
- [[DST]] — parent concept
- [[TECHDEBT-190]] — proposal to modernise DST service (would fix OMAN path)
