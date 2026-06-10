---
type: concept
name: Frangular Local Dev Setup
aliases:
  - FRangular local
  - Frangular local chain
sources:
  - appsettings.Development.json (MiX.Config.Frangular.API)
  - environment.ts (MiX.Config.Frangular.UI)
  - proxy.conf.json (MiX.Config.Frangular.UI)
last_updated: 2026-06-03
---

How to run FRangular UI (local) → Frangular API (local) → DEV API.

## The Chain

| Layer | Runs at | Points to |
|---|---|---|
| FRangular UI | `localhost:4200` | `https://localhost:5001` (Frangular API) |
| Frangular API | `localhost:5000` / `https://localhost:5001` | `http://api.deviceconfig.configdev.mix.local/` (DEV Config API) |
| DEV Config API | `api.deviceconfig.configdev.mix.local` | `DSDEVCFGSQL01` (DEV DB) |

## Step 1 — FRangular UI → Frangular API (local)

`MiX.Config.Frangular.UI/src/environments/environment.ts` already points at the local API:

```ts
UiApiUrl: "https://localhost:5001"
```

Run the Angular app with `ng serve` → hits `localhost:4200`, calls Frangular API at `https://localhost:5001`.

`proxy.conf.json` also routes the legacy DeviceConfig path:
```json
"/DynaMiX.DeviceConfig.Services.API/*" → http://localhost
```

## Step 2 — Frangular API → DEV API (the one change needed)

The Frangular API runs with `ASPNETCORE_ENVIRONMENT=Development` (see `launchSettings.json`), which loads `appsettings.Development.json`.

**File:** `C:\Projects\MiX.Config.Frangular.API\MiX.Config.Frangular.API\appsettings.Development.json`, line 21

Change `ConfigApiUrl` from local IIS to the DEV Config API:

```json
// Default (local IIS):
"ConfigApiUrl": "http://localhost/DynaMiX.DeviceConfig.Services.Api",

// Change to (DEV):
"ConfigApiUrl": "http://api.deviceconfig.configdev.mix.local/",
```

Everything else in `appsettings.Development.json` already targets DEV services:
- `FleetInternalApiUrl` → `http://api.fleet.mixdevelopment.com`
- `AuthenticationApiUri` → `http://authentication.mixdevelopment.com`
- `AllowedOrigins` already includes `http://localhost:4200` — no CORS change needed.

## Environment Config Map

| appsettings file | ConfigApiUrl |
|---|---|
| `appsettings.json` (base) | `https://localhost:7116` |
| `appsettings.Development.json` | `http://localhost/DynaMiX.DeviceConfig.Services.Api` |
| `appsettings.DEV.json` | `http://api.deviceconfig.configdev.mix.local/` |
| `appsettings.INT.json` | `http://api.deviceconfig.int.development.domain.local` |

## Connections

- [[Config-Groups-Page]] — the Frangular UI feature this dev setup is used to work on
- [[Config-Api]] — the downstream DEV Config API being targeted
- [[DynaMiX-Backend]] — do NOT call directly from Ops Tools; goes via Config API
