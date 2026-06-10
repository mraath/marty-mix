# OPEN-2802 — DataExports Pipeline Investigation

**Date:** 2026-06-10  
**Ticket:** [OPEN-2802](https://powerfleet.atlassian.net/browse/OPEN-2802)  
**Related:** [[OPEN-2388 - UAE DataExports Environment]]  
**Status:** Investigation complete — pipeline build next

---

## Context

OPEN-2802 is about setting up an Azure/AWS YAML pipeline for the `MiX.DataExports` project. During investigation we VPN'd into the production server to understand the current state before building the pipeline.

**Repo:** `C:\Projects\MiX.DataExports`  
**ADO:** https://dev.azure.com/MiXTelematics/Utilities/_git/MiX.DataExports

---

## Server Investigation Findings

### Server Details

| Property | Value |
|---|---|
| Server | EC2 instance, `eu-west-1a` (AWS Dublin) |
| VPN path | Remote into production Windows Server |
| IIS root | `D:\inetpub\` |
| Log path | `L:\LogFiles\DynaMiX.DeviceConfig.DataExports.API\DataExports.API.log` |

### Deployed Environments on Server

| Environment | IIS Folder | DLL Last Modified | OPEN-2388 Deployed? |
|---|---|---|---|
| **PROD** | `D:\inetpub\DynaMiX.DeviceConfig.DataExports.API` | Oct 28, 2021 | ❌ No |
| **UAT** | `D:\inetpub\DynaMiX.DeviceConfig.DataExports.API.UAT` | Jan 16, 2024 | ❌ No |

> ⚠️ Both environments are **years out of date**. Current code (OPEN-2388) exists only in the repo — it has never been deployed to this server.

### Settings Files (PROD — `DynaMiX.DeviceConfig.DataExports.API/`)

| File | Last Modified | Notes |
|---|---|---|
| `Settings.AU.xml` | Jul 16, 2019 | Original |
| `Settings.ENT.xml` | Aug 27, 2025 | Recently updated (hotfix?) |
| `Settings.UK.xml` | Aug 27, 2025 | Recently updated |
| `Settings.US.xml` | Aug 27, 2025 | Recently updated |
| `Settings.ZA.xml` | Aug 27, 2025 | Recently updated |
| `Settings.UAT.xml` | Jul 16, 2019 | Original |
| `Settings.UAE.xml` | **DOES NOT EXIST** | Required for OPEN-2388 |

### Web.config Key Findings

- `FileOutputPath` → `D:\inetpub\DynaMiX.DeviceConfig.DataExports.API`
- `DataExportsApiUrl` → `http://localhost/DynaMiX.DeviceConfig.DataExports.API`
- **No `IdentityUrl` key found** → confirms the old auth proxy (`AuthorisationProxy`) is still in use in PROD, not the new Identity client pattern

---

## What This Validates

1. **OPEN-2388 (UAE environment)** — Code is done and PR-ready. The reviewer confirmed it only needs a PR. Never been deployed. UAE config (`Settings.UAE.xml`) needs to be added to the server as part of deployment.

2. **OPEN-2802 (Pipeline)** — Now clearly essential. Current deployment is entirely manual — someone manually copied files, DLLs are years old. A proper pipeline is the only way to get OPEN-2388 and future changes reliably deployed.

---

## Recommended Next Steps

| Priority | Task | Notes |
|---|---|---|
| 1 | Fix `AuthorisationProxy` interface reference in code | Still referenced somewhere — reviewer flagged it as a real gap |
| 2 | Raise PR for OPEN-2388 | Code is done, just needs PR |
| 3 | Make server backup before any deployment | 4.5-year-old PROD — always backup first |
| 4 | Build YAML pipeline (OPEN-2802) | Target: AWS EC2 eu-west-1a |
| 5 | Add `Settings.UAE.xml` to server as part of first pipeline deploy | UAE values: `AuthenticationUrl=https://uae.mixtelematics.com`, `DataExportsUrl=https://data-exports.uae.mixtelematics.com` |

---

## Continue With This

> For next session — full handoff context

### What's done
- ✅ Investigated PROD and UAT server state via VPN
- ✅ Confirmed neither environment has OPEN-2388 deployed
- ✅ Confirmed server is EC2 eu-west-1a (AWS Dublin)
- ✅ Confirmed UAE settings file is missing from server
- ✅ Confirmed old auth proxy still in use (no `IdentityUrl` in Web.config)
- ✅ OPEN-2388 code confirmed complete — only needs PR + deployment

### What's NOT done yet
- ❌ `AuthorisationProxy` interface cleanup in code
- ❌ PR raised for OPEN-2388
- ❌ Server backup taken
- ❌ YAML pipeline built for OPEN-2802
- ❌ `Settings.UAE.xml` created on server

### Key paths
- Repo: `C:\Projects\MiX.DataExports`
- SDLC context: `C:\Projects\SDLC\CLAUDE.md`
- Work persona: `C:\Personal\AIOS\personas\work\CLAUDE.md`
- UAE expected settings: `AuthenticationUrl=https://uae.mixtelematics.com`, `DataExportsUrl=https://data-exports.uae.mixtelematics.com`, `IdentityClientId=dataexportapp`, `IdentityClientSecret=4TEPbX6msDwAhRMw`

### Starting point for next session
Load SDLC context → look at `AuthorisationProxy` fix → raise OPEN-2388 PR → then start OPEN-2802 pipeline YAML.
