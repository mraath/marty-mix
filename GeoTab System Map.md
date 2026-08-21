---
created: 2026-08-06T10:51
updated: 2026-08-06T11:21
---
# Geotab QC Automation — System Map

C4 draft (Context + Container) of what's already built, drawn from live code on `origin/integration` — not the boss's description, the actual repos. See [[GeoTab]] for the full write-up, raw messages, and the Kameel question list.

**Repos:** Powerfleet.Automation (API) · Powerfleet.Automation.UI · MyGeotab SDK · Salesforce
**Epic:** OPEN-3192 — Geotab Installation QC Automation, Phase 3
**Checked:** 2026-08-06

> [!note] Rendering note
> Mermaid marks C4 diagrams (`C4Context`/`C4Container`) as experimental — if either diagram below doesn't render in your Obsidian Mermaid plugin version, tell me and I'll convert them to plain flowcharts instead.

## C1 — Context

*Who touches this system, and what it talks to. Readable by anyone — technical or not.*

```mermaid
C4Context
    title Context — Geotab QC Automation

    Person(tester, "QC Tester", "Marthinus / Kritiya Shrestha")
    Person(po, "Kameel Leeda", "PO-equivalent — sets pass/fail rules")

    System(autoplatform, "Powerfleet Automation Platform", "Ops Tools QC automation — MX, FC Plus, Cellocator, and now Geotab")

    System_Ext(geotab, "MyGeotab Platform", "my.geotab.com — device, trip, diagnostic data for GO units")
    System_Ext(salesforce, "Salesforce", "[CORRECTION 2026-08-18: not actually called — see below] Case data — ActionDate used to cross-validate trips")

    Rel(tester, autoplatform, "Logs in, submits case + registration + IMEI, reviews verdicts")
    Rel(po, autoplatform, "Defines QC rules and thresholds for")
    Rel(autoplatform, geotab, "Authenticates, queries device/trip/status/fault data", "Geotab Checkmate SDK")
    Rel(autoplatform, salesforce, "[WRONG, see correction below] Cross-checks case ActionDate against")
```

**What this shows:** the platform sits between a human tester and two external systems it doesn't control — Geotab (the data source being QC'd) and Salesforce (the case record used to validate trip data). Kameel shapes the rules; he doesn't operate the platform directly.

> [!danger] Correction (2026-08-18) — Salesforce is NOT actually called
> Checked `GeotabQCManager`'s constructor directly: its only dependency is `IGeotabApiClientFactory`. There is no Salesforce client, repository, or service anywhere in this code path. `SalesforceCase` is just the .NET type name of the request DTO (shared naming convention across all QC platforms in this codebase) — `ActionDate` is a plain field already present on that object when the request arrives, supplied by whatever caller constructed it. The Rel arrows above and the "Cross-checks... against Salesforce" framing throughout this file are **wrong** — there's no live integration, just a field name that made it sound like one. Left the diagram text struck through/annotated rather than silently rewritten, so the correction itself stays visible.

## C2 — Container

*The runtime pieces inside the platform boundary, and the protocol each hop uses. Readable by the dev/ops team.*

```mermaid
C4Container
    title Container — Geotab QC Automation

    Person(tester, "QC Tester", "")

    System_Boundary(autoplatform, "Powerfleet Automation Platform") {
        Container(ui, "Powerfleet.Automation.UI", "Next.js / React / TS", "LoginView Geotab option (INT/AU gated) + GeotabQCFormView")
        Container(api, "Powerfleet.Automation API", ".NET / ASP.NET Core", "QCController endpoint; GeotabQCManager orchestrates checks")
        Container(client, "GeotabApiClient + Factory", "C# wrapper", "Per-tenant client, cached, over Geotab.Checkmate.ObjectModel SDK")
        ContainerDb(config, "appsettings.INT/AU.json", "JSON config", "GeotabTenantConfig — Server/Database/Username/Password per tenant")
    }

    System_Ext(geotab, "MyGeotab Platform", "my.geotab.com")
    System_Ext(salesforce, "Salesforce", "")

    Rel(tester, ui, "Uses", "Browser/HTTPS")
    Rel(ui, api, "Calls performGeotabQC via geotab-qc proxy route", "HTTPS/JSON")
    Rel(api, client, "Runs QC checks via")
    Rel(client, config, "Reads tenant credentials from")
    Rel(client, geotab, "Queries device/trip/status/fault data", "Geotab Checkmate SDK")
    Rel(api, salesforce, "[WRONG, see correction below] Cross-checks trip ActionDate against")
```

**What this shows:** the UI never talks to Geotab directly — every call is proxied through the API, which is the only container holding tenant credentials. That's the one hop the whole QC run depends on.

## Verdict states a run can end in

| Verdict | Meaning |
|---|---|
| 🟢 **Pass** | Check succeeded |
| 🔴 **Fail** | Check failed |
| 🟡 **Pending** | Inconclusive / awaiting data |
| ⚪ **NotTested** | Stubbed — not implemented yet |

Precedence when a case has several checks: **Fail beats Pending beats Pass beats NotTested.** Four of the fourteen planned checks (digital inputs, exception events, video peripheral, video recordings) still ship as `NotTested` stubs.

> [!danger] Scope gap — confirmed against the real spec doc
> The AU Installation Test Procedure doc covers 8 unit types across 4 platforms. What's actually built (OPEN-3192) is **Geotab GO units only** — everything below is unbuilt, not just undocumented:
> - **Vision AI camera** (Geotab-integrated + Hub/Unity) — linkage, live view, mounting sign-off, all unbuilt
> - **Asset trackers (81/85/86/87, spoken "AT1/AT5/AT6/AT7" in the video — likely the same models)** — Geotab platform, but a *different device serial than the physical unit*. **Confirmed 2026-08-17 with a real example** (AT7: FOUR's serial ≠ Geotab's serial for the same unit, see [[GeoTab]]) — no serial-matching step exists in the built code.
> - **FT1 / MGS** — legacy Unity Hub platform, entirely separate integration
> - **Guardian, MiX units** — explicitly out of scope per the doc itself

> [!question] Still genuinely open
> - Whether `GeotabAsset.SerialNumber` assumes a 1:1 match with the Geotab-platform serial — confirmed unsafe for asset trackers, unconfirmed for base GO units
> - Whether "exception events"/"harsh driving" (OPEN-3199's wording) maps to the doc's duress/buzzer/GoTalk output-triggered events, or is a distinct, still-undocumented check
> - Whether a separate HDOP pass/fail threshold is real — the doc only describes satellite count as a non-gating diagnostic aid
> - Exact mechanism of the Salesforce cross-check — inferred from epic notes, not independently verified this session

**Resolved since first draft:** real INT/AU Geotab credentials (OPEN-3254) confirmed Done as of the 2026-08-06 Jira check — no longer a placeholder/open item.

## Full people roster

| Person | Role | Relationship to this system |
|---|---|---|
| **William King** | Boss/sponsor | Requested this work get tested; not a direct system user. Assigned to OPEN-1531 (Done spike) — "Review spec for Advanced Geotab QC with Zoe, Olivier and Neil" — likely the origin of this whole initiative |
| **Marthinus Raath** | QC tester (this write-up's author) | Operations Tools — runs the manual functional test pass against the built tool |
| **Kameel Leeda** | PO-equivalent, our side | Defines pass/fail business rules; primary point of contact for every open question below |
| **Kritiya Shrestha** | AU-side QC | Operates the *existing manual* work-order system today (see [[GeoTab Manual QA Workflow]]); the person whose manual verdicts this tool's automated verdicts must be cross-validated against |
| **Zoe / Olivier / Neil** | Named in OPEN-1531 spec review | Subject-matter reviewers of the original Advanced Geotab QC spec — involvement since then unconfirmed |
| **Grant** | Developer | Owns the currently-open follow-up tickets touching this same feature: OPEN-3363 (E2E preflight gap), OPEN-3362 (route hardening), OPEN-3351 (bookkeeping) |

## Full systems roster

**In scope — built, OPEN-3192:**

| System | Role |
|---|---|
| Powerfleet.Automation.UI | Tester-facing form + verdict display |
| Powerfleet.Automation API | Orchestrates all QC checks (`GeotabQCManager`) |
| MyGeotab Platform (external) | Source of device/trip/diagnostic/fault data, via Geotab Checkmate SDK |
| Salesforce (external) | Source of case `ActionDate`, used to cross-validate trip data |

**Out of scope — named in the AU spec doc, nothing built against them:**

| System | Would cover |
|---|---|
| Master Portal | Camera provisioning/linkage (Geotab-integrated cameras) — per [[GeoTab Handwritten Meeting Notes]] (2026-08-17), keyed by IMEI + duty type via a "Data Aggregation" layer, **a different serial-number scheme than Geotab GO units** — corroborates the IMEI-vs-serial risk in [[GeoTab Code Audit]] |
| Vision AI Hub | Camera live-view streaming — likely the same product as **LightMetrics** (`master.lightmetrics.co`), the camera itself is a **Mitac Vision** unit. **Role confirmed 2026-08-17:** this is the back-office/reviewer-facing side — Kritiya and other QC/office users check camera status here, distinct from RideView's field role below |
| RideView App | Companion/phone app for installer camera alignment — named in [[GeoTab Handwritten Meeting Notes]], resolves an item [[GeoTab]] previously flagged as an unconfirmed claim from the podcast transcript. **Confirmed 2026-08-17:** needed specifically on the installer's own phone for the Geotab-camera branch — a mobile app, not a desktop/web tool. **Role split confirmed:** RideView is what the technician uses in the field during install; other users (reviewers, office staff) check `master.lightmetrics.co` afterward instead — different people, different systems, same camera |
| **FleetComplete Operations (Dynamics 365)** — `fleetcomplete.operations.dynamics.com` | **New system, 2026-08-17.** A Microsoft Dynamics 365 Finance & Operations instance — almost certainly the "Finance and Operations" browser tab visible in [[GeoTab]] screenshot 1, previously unexplained. Role: resolves a device's Serial Number to its IMEI for the camera lookup chain below. Kritiya may have called this "the billing system" — Marthinus wasn't fully certain of her exact wording, but the Dynamics F&O branding fits a genuinely finance/billing-oriented system that also happens to hold serial↔IMEI mapping data |
| Unity Hub / FC Legacy Platform | Legacy Hub cameras, FT1, MGS — **also the platform behind the existing manual work-order system**, see [[GeoTab Manual QA Workflow]]. **New risk flagged 2026-08-17** (unconfirmed, needs Kameel/Kritiya): notes mention this integration can "impersonate" and lose data in some flow — not yet understood, see [[GeoTab Handwritten Meeting Notes]] |
| Guardian platform (Seeing Machine) | Guardian Gen 3 units — doc itself scopes this to online/offline check only. Platform URL: `guardianlive.co` |
| MiX platform | MiX units — explicitly out of scope per the doc |

**Correction (2026-08-17) — the LightMetrics lookup key is IMEI, not serial number.** An earlier version of this table said "device serial number" — wrong, corrected here. `master.lightmetrics.co` needs the camera's **IMEI**, not its serial number. The real chain: installer has the device's **Serial Number** in FleetComplete/FOUR → looks it up in **FleetComplete Operations (Dynamics 365)** to resolve the **IMEI** → uses that IMEI in `master.lightmetrics.co`. Ideally the installer enters the IMEI directly into the "Camera IMEI" field on the FOUR install record at install time (seen in [[GeoTab]] screenshot 6) and this whole lookup chain is skipped entirely — the chain above is the fallback for when they didn't. This is concrete, first-hand evidence of exactly the identifier-mismatch pattern [[GeoTab Code Audit]] flagged as a risk — even Kritiya's own manual process needs a cross-system lookup because serial number and IMEI genuinely aren't the same value.

## Units in scope (device types)

| Unit type | Platform | Built in OPEN-3192? |
|---|---|---|
| Geotab GO unit | Geotab (MyGeotab) | **Yes** — the epic's entire scope |
| Vision AI camera (Geotab-integrated) | Geotab + Master Portal + Vision AI Hub | No |
| Vision camera (Hub/Unity) | Unity Hub (legacy FC) | No |
| FT1 | Unity Hub (legacy FC) | No |
| MGS | Unity Hub (legacy FC) | No |
| Asset trackers (81/85/86/87 / AT1/AT5/AT6/AT7) | Geotab, different device serial than the physical unit — **confirmed with a real AT7 example 2026-08-17** | Unclear — likely no, no serial-matching step exists |
| Guardian (Gen. 3) | Guardian platform | No — online/offline check only, out of scope per doc |
| MiX units | MiX platform | No — explicitly out of scope |

## Parameters / checks — implemented vs stub vs placeholder

All in `GeotabQCManager.cs` (`Powerfleet.Automation.Logic/Managers/QC/`, `origin/integration`):

| Check | Line | Status |
|---|---|---|
| Voltage (external ≥11.0V / battery ≥3.5V) | ~250 | Implemented — **placeholder thresholds**, confirm with Kameel |
| FaultCodes (active, non-dismissed) | ~303 | Implemented |
| GpsQuality / HDOP | ~337 | Implemented — **placeholder threshold**; AU doc only describes satellite count as a non-gating diagnostic, not a pass/fail HDOP gate |
| IgnitionSource vs InstallType | ~391 | Implemented — **placeholder KnownId constant** |
| NfcDriverId / BuzzerOutput / GoTalkOutput / IridiumDuress / WifiPresence | 463–595 | Implemented |
| DeviceActive | ~600 | Implemented |
| Firmware | ~635 | Implemented |
| Trips vs Salesforce ActionDate (7-day fallback) | ~663 | Implemented |
| Odometer | ~687 | Implemented |
| Driver assignment | ~715 | Implemented |
| LastCommunication (24h recency) | ~741 | Implemented |
| DigitalInputs (Aux 1–8 mapping) | 204–236 | **Stub — always `NotTested`** |
| ExceptionEvents ("harsh driving") | 204–236 | **Stub — always `NotTested`** |
| VideoPeripheral | 204–236 | **Stub — always `NotTested`** |
| VideoRecordings | 204–236 | **Stub — always `NotTested`** |

TODO markers at lines 37, 49, 54, 241, 398, 489 — all unconfirmed KnownId constants/thresholds feeding the "placeholder" rows above.

## Test scope

Full test plan: [[GeoTab Test Plan]]. Automated coverage that already exists (NUnit + UI unit tests) is listed there — this file stays architecture-only.

---
Full write-up, raw messages, and the Kameel question list: [[GeoTab]]
