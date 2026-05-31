---
wiki_ingested: 2026-05-28
created: 2026-02-24T16:50
updated: 2026-02-24T16:50
---
All changes are complete. Here's a summary:

**API (4 files):**

- **`EnvironmentSettingsProvider.cs`** — new static class that loads/caches settings per-environment and supports `SwitchEnvironment()`
- **`EnvironmentsController.cs`** — new `GET /api/environments` endpoint
- **`AuthController.cs`** — added `Environment` to `LoginRequest`, calls `SwitchEnvironment` before authenticating
- **`Startup.cs`** — 4 lines added to initialize the provider

**UI (4 files):**

- **`LoginView.tsx`** — environment dropdown added (fetches available envs from API on mount, with hardcoded fallback)
- **`ApiService.ts`** — `login()` now passes `environment`
- **`route.ts` (auth proxy)** — forwards `Environment` to API
- **`route.ts` (environments proxy)** — new proxy for the environments endpoint

Build compiled successfully (only file-lock warnings from the running API process, not code errors). You'll need to restart the API in Visual Studio to pick up the changes.

> **Note:** This is a global environment switch — when someone logs in with "AU", the entire API switches to AU settings. Since this is a single-user operations tool, that should be fine.