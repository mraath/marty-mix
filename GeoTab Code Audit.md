---
created: 2026-08-14
updated: 2026-08-19T09:16
---
# GeoTab Code Audit

Code-level audit of OPEN-3192 (Geotab GO unit QC automation), read directly off `origin/integration` in both `Powerfleet.Automation` and `Powerfleet.Automation.UI` on 2026-08-14 (both local checkouts of these repos were stale, so this reads the remote ref via `git show`, not a local working tree). Companion to [[GeoTab Test Plan]] (the test-plan document itself), [[GeoTab System Map]] (architecture), [[GeoTab Manual QA Workflow]] (the manual process this replaces), and [[GeoTab]] (full intake/context history).

## 🔴 Urgent: hardcoded cleartext Geotab credentials in the repo

`Powerfleet.Automation.Api/appsettings.INT.json` and `appsettings.AU.json` both contain a real `GeotabTenants` username + password in plaintext, identical in both files. This is exactly the class of exposure **OPEN-3256** ("Remove hardcoded secrets from settings/.env files," parent epic OPEN-3255) was opened to fix — and per the last live Jira check that ticket is still open/Proposed, not Done. The credential is currently sitting in the `origin/integration` branch tip.

**This needs a decision from you, not just a note in a test plan:** rotate the credential and move it to a secrets store, escalate OPEN-3256's priority, or explicitly accept the risk for now. I haven't taken any action on it — just confirming it's real and current, not a stale risk carried over from an old memory note.

## 1. Jira ticket ↔ code mapping (all 17 children of OPEN-3192, all Done)

Pulled live via Jira REST (no Jira MCP tool was available in this session, so this used the standing-approved REST fallback — read-only, not a write).

| Ticket | Summary | Code found? | Notes |
|---|---|---|---|
| OPEN-1531 | Spike: Review spec for Advanced Geotab QC (Zoe/Olivier/Neil) | N/A (spike, no code) | Likely the origin of the whole initiative — William King is the assignee |
| OPEN-3193 | Route constant, controller endpoint, DI registration | ✅ `QCController.ActionQCAutomationGeotabAsync`, `QCAutomationRoutes.cs` | Matches |
| OPEN-3194 | GeotabAsset entity + IGeotabApiClient wrapper | ⚠️ Exists but **dead code** | `GeotabAsset.cs` is never referenced by the real QC flow. `Initializer.cs`'s own comment confirms: OPEN-3195 "removes" OPEN-3194's original DI registration because "no consumer resolves IGeotabApiClient directly." The entity shipped, then got orphaned as later tickets took a different approach (`SalesforceCase.UniqueIdentifier`/`GeotabInstallType` instead) |
| OPEN-3195 | IGeotabApiClientFactory per-tenant client cache | ✅ `GeotabApiClientFactory.cs`, registered in `Initializer.cs` | Matches |
| OPEN-3196 | Device/firmware/trip/odometer/driver checks | ✅ `CheckDeviceActive/Firmware/Trips/Odometer/Driver` + `CheckLastCommunication` | Ticket title lists 5 checks, code/comments show 6 (LastCommunication included) — label-only mismatch |
| OPEN-3197 | GPS quality (HDOP) + ignition source checks | ✅ `CheckGpsQuality`, `CheckIgnitionSource` | Matches, including the placeholder-threshold TODO comments |
| OPEN-3198 | Voltage + fault code checks | ✅ `CheckVoltage`, `CheckFaultCodes` | Matches |
| OPEN-3199 | Digital input, exception event, video peripheral stubs | ✅ but **4 stubs exist, ticket names 3** | Code also has `CheckVideoRecordings` (always NotTested) — not named in the ticket title, likely undocumented scope-add within the same ticket rather than a separate gap |
| OPEN-3200 | Unit tests for "9 implemented" checks | ✅ 5 test files present | "9" undercounts even the checks that existed pre-OPEN-3223; not worth chasing, just don't expect the number to reconcile exactly |
| OPEN-3201 | GeotabTenants config section, INT+AU | ✅ present in both appsettings | **See the credentials finding above** |
| OPEN-3202 | UI login selector, Geotab option, hostname gating | ✅ `LoginView.tsx` | Gated to exactly two hostnames: `automation.mixdevelopment.com` (INT), `automation-au.mixtelematics.com` (AU) — the Geotab option is **not rendered at all** on any other hostname, not just disabled |
| OPEN-3203 | performGeotabQC API client method + proxy route | ✅ `ApiService.performGeotabQC`, `route.ts` | Matches |
| OPEN-3204 | GeotabQCFormView + page routing | ✅ `GeotabQCFormView.tsx`, wired into `src/app/page.tsx` | Matches |
| OPEN-3205 | Test matrix update | Not independently verified | Low-risk, JSON-only change |
| OPEN-3223 | NFC/buzzer/GoTalk/Iridium duress/Wi-Fi presence checks | ✅ all 5 `Check*` methods present | Matches |
| OPEN-3254 | Replace placeholder Geotab creds with real ones | ✅ real values present | **These are the hardcoded cleartext values flagged above** |
| OPEN-3353 | Sync missing GEO scenario test cases into test-suite.json | Not independently verified | Low-risk, JSON-only change |

**Bottom line on this section:** no ticket is "Done" with nothing behind it — every ticket has real matching code. The two things worth flagging aren't missing work, they're **quality issues inside "Done" work**: an orphaned entity (OPEN-3194) and a live plaintext secret (OPEN-3201/3254, unresolved by OPEN-3256).

## 2. Master QC-check table (manual process ↔ code ↔ test plan)

This is the single source of truth the [[GeoTab Test Plan]]'s §5 table should match. "Manual process says" is drawn from the AU Installation Test Procedure doc and confirmed by [[GeoTab Overview Transcript]] (the meeting transcript).

| Check | Manual process says (doc + transcript) | Jira ticket | Code status | Fail-capable? | Placeholder/unconfirmed? |
|---|---|---|---|---|---|
| DeviceActive | "Verify status" — for a Geotab device, checks MyGeotab/MyAdmin for device status (confirmed verbally in transcript) | OPEN-3196 | Real | **Yes** | No |
| Firmware | Not explicitly named in doc/transcript as a standalone check | OPEN-3196 | Real | No | No |
| Trips vs Salesforce ActionDate | Not named directly; doc's log-export-cap gotcha applies here | OPEN-3196 | Real | No | No |
| Odometer | Not named in doc/transcript | OPEN-3196 | Real | No | No |
| Driver assignment | Not named in doc/transcript | OPEN-3196 | Real | No | No |
| LastCommunication | Not named directly | OPEN-3196 | Real | No | No |
| GPS/HDOP | "Basic check: GPS + ignition" (transcript, verbatim); doc names satellite count as diagnostic-only, never mentions HDOP | OPEN-3197 | Real | No | **Yes** |
| IgnitionSource | "Whether it's reporting through RPM based or any other source" (transcript, verbatim, matches doc's basic checks) | OPEN-3197 | Real | **Yes** (one branch) | **Yes** — and no UI field sets `GeotabInstallType`, so Pending-only via the built form |
| Voltage | Not named in doc/transcript | OPEN-3198 | Real | No | **Yes** |
| FaultCodes | Not named in doc/transcript | OPEN-3198 | Real | **Yes** | No |
| NFC/driver-ID | Doc §5.1: IOX NFC + driver-ID tap event | OPEN-3223 | Real | No | **Yes** (keyword match) |
| Buzzer output | Doc §5.1: output-triggered event | OPEN-3223 | Real | No | **Yes** |
| GoTalk output | Doc §5.1: output-triggered event | OPEN-3223 | Real | No | **Yes** |
| Iridium duress | Doc §5.1: "Emergency Data Success" via satellite, works ignition on/off | OPEN-3223 | Real | No | **Confirmed correct 2026-08-17** — Kritiya's real QC practice is to look for exactly "Emergency Data Success" in exported reports; the code's keyword match isn't a guess needing verification, it matches actual practice |
| WiFi presence (Santos) | Doc §5.1: IOX Wi-Fi present, allow delayed reporting | OPEN-3223 | Real | No | No |
| DigitalInputs (Aux 1-4) | Doc §5.1: on/off event per Aux 1 (handbrake/PTO), Aux 2 (4WD), Aux 3 (seatbelt), Aux 4 (duress dash/remote) — doc describes these as concrete, testable checks | OPEN-3199 | **Stub — always NotTested** | N/A | Blocked on technical-team wiring confirmation |
| ExceptionEvents/harsh driving | Transcript doesn't use this term at all; doc doesn't either | OPEN-3199 | **Stub — always NotTested** | N/A | Business rule for "harsh driving" undefined |
| VideoPeripheral | Doc §5.2/5.3: entirely different platform (Master Portal/Vision AI Hub) | OPEN-3199 | **Stub — always NotTested** | N/A | Camera add-on KnownId unconfirmed |
| VideoRecordings | Same as above | OPEN-3199 (uncredited in title) | **Stub — always NotTested** | N/A | Media-type/channel filter logic unconfirmed |

**The single clearest gap in this table:** the doc treats Aux 1-4 as ordinary, testable, already-answered checks ("this is the DIN-to-Aux mapping that was an open TODO — now answered," per [[GeoTab]]'s earlier notes) — but the code never implements them as distinct checks at all. That earlier "now answered" read of the doc was wrong; the code disagrees with it.

## 3. What the transcript adds beyond the doc

The transcript ([[GeoTab Overview Transcript]]) only covers the first ~3.5 minutes of a ~56-minute call (large gap, 3:20→56:07 not captured), so it mostly corroborates rather than extends the doc. One detail worth calling out for the serial-number risk already in the test plan: Kritiya says technicians "just give you the device serial numbers... we just search by the device serial numbers" — confirming **"device serial number"** is the term used in the manual process, not IMEI. That's consistent with, but doesn't resolve, the code-level risk that the built UI's field is labeled and validated as "IMEI" while the Geotab SDK call searches by `Device.SerialNumber`.

## 4. Answering "what am I missing"

A few things that don't fit neatly into meeting / code / code-parts / tests, but matter:

- **The credential exposure (§ above)** — this is a decision for you, not something the test plan can absorb as a caveat.
- **Hostname gating is a hard precondition, not just a login step.** The Geotab option in the UI literally doesn't render outside `automation.mixdevelopment.com` (INT) / `automation-au.mixtelematics.com` (AU) — testing from any other URL won't show a missing feature, it'll look like the platform doesn't exist.
- **This audit itself hasn't been shown to Kameel or Kritiya.** Everything here is inferred from doc + transcript + code — the actual sign-off in the test plan's §8 still needs their eyes, especially the Aux 1-4 stub finding, since it contradicts what the epic's own notes claimed was resolved.
- **No live login has been re-attempted since the 2026-08-06 failure.** Every finding in this audit is static (code + docs) — none of it confirms the tool actually works end-to-end against a live Geotab tenant.

## 4a. Real API test results (2026-08-18) — the IMEI/serial risk is confirmed, plus a new defect found

Ran `test-geotab-qc.ps1` (see [[GeoTab]]) directly against the deployed AU API for 3 real serials pulled from the video (`santos` GO7, Terra Cat GO9, BM Alliance GO9). Real output, not code inspection.

**Confirmed: none of 4 real identifiers resolve a Geotab device** — 3 FleetComplete/FOUR serial numbers, plus the Terra Cat unit's MyAdmin **Hardware ID** (`568851839`) tried as a 4th case. All four returned `DeviceActive: "No device found for the given serial number."` The Hardware-ID hypothesis is now ruled out too — this isn't simply "wrong field name," something more fundamental is missing.

**Likely actual root cause, found by re-running the same 4 cases twice, 2026-08-18:** the downstream data (Trips/Odometer/etc.) that shouldn't exist for an unresolved device isn't static or mocked — between the two runs, trip counts changed (1→2) and `FaultCodes` went from "no data" to "2 active faults." **This is live, real, changing data — just not scoped to any of the 4 devices we asked about.** Combined with `appsettings.AU.json`'s `GeotabTenantConfig.Database` being **an empty string** (confirmed when the code was first read) while every FleetComplete install record carries its own per-customer `Database` value (`santos`, `terra_cat`, ...) and even has a separate `Database Override` field — the likely explanation is that the Geotab session authenticates into whatever a blank database resolves to (probably the service account's own default/no-scope context), a scope that contains none of these customer devices. **Confirmed at the schema level, not just by reading source** — hit the AU API's public Swagger spec directly (`https://automation-api-au.mixtelematics.com/swagger/v1/swagger.json`, no auth needed to view it) and checked the `SalesforceCase` request schema: it has no `Database` field, full stop. There is no way to pass one via any documented endpoint — this isn't a missing convenience, the API contract itself doesn't support it. **Worth asking Kameel/dev directly: should `GeotabTenantConfig`/`SalesforceCase` carry a per-case Database value (matching what FleetComplete itself already tracks per install), rather than one static blank value for the whole environment?**

**New defect found, more serious than the mismatch itself: checks downstream of a failed device lookup don't short-circuit.** `Trips`, `Odometer`, `Driver`, and `LastCommunication` returned **identical values across all three different (non-resolving) serials** — same trip count, same `20874 km` odometer reading, same last-communication timestamp, all three calls seconds apart. Since `DeviceActive` correctly reports no device found, `deviceId` is null downstream — but `GetTripsAsync(null, ...)` etc. aren't guarded against a null/failed device resolution, and evidently still return non-empty data from somewhere. The checks built on top of that data then report a false **Pass** rather than Pending.

**Practical impact:** the tool can currently report "trips/odometer/driver/last-communication all look fine" for a serial number that never resolved to a real device at all. This is a correctness bug, not a placeholder-threshold question — worth raising as a real Jira defect against OPEN-3192, separate from the threshold-confirmation questions already queued for Kameel.

## 4a-i. Is the deployed AU build even current? (2026-08-18) — resolved: yes, exactly

Initial check (against `origin/integration` only) couldn't find the AU swagger's build hash (`922e12353a970a166575c538a2701893129efb30`) anywhere. Fetching `origin/production` resolved it immediately: **that hash is `production`'s exact current tip commit** (`git rev-parse origin/production` → `922e12353a970a166575c538a2701893129efb30`, confirming AU deploys from `production`, not `integration`, which makes sense given `productionEnv: true` in the test-hub's `environments.json`).

**Better still:** `git diff --stat origin/production origin/integration` returns completely empty right now — the two branches are functionally identical in file content (only differ by which PR-merge commits carried a handful of equivalent config/URL tweaks). `GeotabQCManager.cs` is byte-identical between them. **Everything read from `integration` in this audit applies directly to what's actually running on AU — no redeploy needed, no drift to worry about.**

## 4a-ii. Endpoints vs. checks — clearing up an apparent mismatch (2026-08-18)

Swagger lists exactly 9 HTTP endpoints total for this API (auth, environments, decom-automation, health, counters, version, and one `qc-automation-*` route per platform). This isn't inconsistent with the ~19-row check table elsewhere in this doc/[[GeoTab Test Plan]] — those are two different levels of granularity. The 9 endpoints are HTTP routes; the ~19 checks (DeviceActive, Firmware, GpsQuality, ...) are internal C# methods inside `GeotabQCManager`, all exposed through the single `/api/qc-automation-geotab` route, never separate endpoints each. Separately: the UI's own Next.js proxy routes (`/api/proxy/geotab-qc` etc.) are a different application entirely and never appear in this C# API's swagger at all — that's expected, not a gap.

## 4b. Architectural comparison against sibling QC managers (2026-08-18) — the likely real fix

Directly compared `GeotabQCManager`'s constructor and flow against `QCManager` (MX) and `CellocatorQCManager` in the same repo, on the same fresh `origin/integration` checkout.

**MX and Cellocator both resolve identity through MiX's own central registry before touching their platform API:**
```csharp
// QCManager (MX) / CellocatorQCManager — both do this first:
var mappingsForAsset = await _mixService.GetAssetMobileUnitMappingByUniqueIdentifierV3Async(imei);
mobileUnitAsset.MobileUnit = await _mixService.GetMobileUnitSummaryAsync(authToken, mappingsForAsset.MobileUnitId);
```
This resolves a submitted IMEI to a `MobileUnitId`/`OrganisationId` via a MiX-side lookup (`IMiXServiceWrapper` → `DeviceConfigClient.MobileUnitMappings`), *then* uses that resolved mapping to fetch the platform-specific asset.

**`GeotabQCManager` has no equivalent step.** Its only dependency is `IGeotabApiClientFactory` — the submitted identifier goes straight to Geotab's own SDK `GetDeviceAsync(serialNumber)` call with no resolution step at all. (FCPlus is a middle case: it doesn't use the MiX mapping either, but its own comment says it "extracts UniqueIdentifier as vehicleId" directly — implying FC Plus's own API genuinely accepts that raw identifier as a valid key, unlike Geotab's apparently not accepting FleetComplete's serial number as a valid `Device.SerialNumber` search value.)

**Confirmed the full reference pattern, including the failure guard Geotab is also missing.** `QCManager`'s exact call site:
```csharp
_mobileUnitAsset = await _helperManager.DetermineMobileUnitSummaryAsync(ActionType.QC, sfCase.UniqueIdentifier, authToken, sfCase.ActionDate, _result);
if (_mobileUnitAsset == null)
{
    _result.Status = CaseStatuses.Fail;
    AddMessage("Mobile Unit Asset could not be retrieved.");
    ...
    continue;   // <-- skips ALL further per-check processing for this case
}
```
MX explicitly guards and **skips every other check** when the mapping fails to resolve. `GeotabQCManager` has neither the resolution call nor this guard — confirming both halves of the §4a defect precisely: it's missing the identity-resolution step *and* the "stop here if it fails" pattern that would have prevented Trips/Odometer/etc. from running against a null device in the first place.

**This is very likely the actual fix, not a threshold or config question:** if Geotab GO units are registered in MiX's central asset/mobile-unit registry the same way MX and Cellocator units are, `GeotabQCManager` should probably call the same `GetAssetMobileUnitMappingByUniqueIdentifierV3Async` resolution step MX/Cellocator already use, instead of guessing at Geotab's own serial number directly. **Next concrete step (2026-08-18, in progress):** search Powerfleet's MFM system for the real customer orgs from the video (`Santos`, `Terra Cat - Mike Sankey`, `BM Alliance Coal Operations Pty Limited`) to confirm whether these units/orgs exist in that central registry at all, and if so what identifier fields are present.

## 4c. DB access path investigated as an alternative to the API probe (2026-08-18)

Followed a lead: does direct SQL access to Powerfleet's asset registry give a faster/more direct way to check whether the 13 known serials/registrations (Santos, BM Alliance, Terra Cat, etc.) exist in MiX's central registry, bypassing the uniform 500s `test-mix-mapping.ps1` was getting from the MX QC endpoint?

**Powerfleet.Automation itself has no DB at all.** Confirmed via its own `CLAUDE.md`: it had a Postgres migration runner until 2026-05-28, deleted as unrelated collateral in an "OPEN-2615: Remove Salesforce integration" cleanup; the one domain it served (`configdiff`) had already moved to `ConfigTools.API`. As of 2026-08-04, zero DB code/packages/settings remain — confirmed via full git history search. So Powerfleet.Automation's own repo was never going to have this answer.

**The real DB lives in a different repo — `Config.Api`** (`C:\Projects\Config.Api`, backs `ConfigApiUrl`). Its `appsettings.AU.json` has three live SQL Server connection strings to `HSSYDCLN03.sydney.production.local\INDIA` (`DeviceConfigDb`, `DynaMiXDb`, `ControllerDb` = `FMOnlineDB`), plaintext credentials included (pre-existing in the repo, not something I introduced — flagging for awareness, not urgency).

**Blocked on network, not credentials.** `Resolve-DnsName` failed for the AU host — but also failed for `DSINTSQL01`, the INT host I've used successfully before. General internet and `dev.azure.com` both resolved fine. Conclusion: this machine currently has no corporate VPN adapter up (only Wi-Fi/Tailscale/Hyper-V were present), which gates *all* on-prem SQL hosts, not just AU. Not an AU-specific gap.

**Even with the VPN up, this DB path would not give a direct serial/IMEI search.** Traced `Config.Api`'s own data-access code (`AssetDbConnectionFactory.cs`, `AssetsProxy.cs`, `OrganisationsProxy.cs`):
- `ControllerDb` (`FMOnlineDB`) holds `dbo.Organisation` joined to `dynamix.Organisations` — this is the org registry: org name, GMT offset, and critically `sConnectDatabase` (which per-org DB to connect to). **This is the only place a name-based search is possible** (`WHERE sOrganisationName LIKE '%Santos%'` etc.) — nothing else in this codebase supports searching by org name.
- Each org's actual asset/vehicle data lives in its *own* separate DB (the one `sConnectDatabase` points to) — but you can only reach it once you already know the `orgGroupId`. There is no cross-org search across all these per-org DBs.
- Neither `ControllerDb` nor any per-org DB query in this repo supports a **serial number, IMEI, or hardware-ID search**. `AssetsProxy.GetAsset`/`GetAllAsync` (identifier-capable methods) don't touch SQL directly at all — they call `_assetsRepo` → `FleetServicesDataClient`, which talks to `MiXFleetServicesApiUrl`. **That's the same Fleet Services backend the MX QC identity-resolution call in §4b (`GetAssetMobileUnitMappingByUniqueIdentifierV3Async`) already goes through** — i.e. the same backend `test-mix-mapping.ps1` is already probing (and getting uniform 500s from).

**Net conclusion:** direct DB access, once reachable, would only add one new capability we don't have today — searching for an **org by name** in `ControllerDb`. It would *not* provide a shortcut to search by serial/IMEI/hardware-ID; that capability doesn't exist in SQL anywhere in this stack, only behind the Fleet Services API already being tested. Codified as Rule 8 in `w-automation-test-hub/SKILL.md` so this reasoning ("check reachability, then trace the actual query surface, before treating a found DB connection as a shortcut") is reusable next time a connection string turns up mid-investigation.

**Still the live open question:** why `test-mix-mapping.ps1` gets a uniform 500 (`ServerSideException`, generic message, no stack trace) for all 13 identifiers rather than a graceful "could not be retrieved" — auth/token mismatch on the MX endpoint vs. a genuine internal error, not yet distinguished.

## 4d. Correction to §4c, plus a direct DB-level answer to §4b's open question (2026-08-19)

**Two things changed since §4c was written**, both from a follow-up investigation in the SDLC repo session (documented there as Rule 8/Rule 9 in `w-automation-test-hub/SKILL.md`):

**Correction — §4c's "no serial/IMEI search exists in this stack's SQL" was wrong.** §4c only traced `AssetsProxy.cs`/`AssetDbConnectionFactory.cs`/`OrganisationsProxy.cs` — not the whole repo. `Config.Api.DataAccess/Repository/MobileUnitLevel/MobileUnit.cs` has exactly this capability: `GetMobileUnitMappingsByUniqueIdentifierFromDBAsync` runs `SELECT ... FROM mobileunit.MobileUnits mu WHERE mu.UniqueIdentifier = @uniqueIdentifier` — no org scoping at all — against `DeviceConfigDb` (the `DeviceConfiguration` database), not `ControllerDb`. This is exactly the same table/column MiX's own central mobile-unit registry uses, and it's a genuine cross-org identifier search §4c said didn't exist anywhere.

**§4c's VPN blocker has a working bypass: AWS SSM.** The corporate VPN still doesn't resolve `HSSYDCLN03.sydney.production.local` (confirmed VPN-session-wide, not AU-specific — Dublin/Virginia equivalents also NXDOMAIN while `DSINTSQL01`/INT resolves fine). But `HSSYDCLN03` is itself registered as an AWS SSM Managed Instance in the AU AWS account (`365528985733`, `ap-southeast-2`, profile `au` via `aws sso login --profile au`). `aws ssm send-command` (`AWS-RunPowerShellScript`) running `Invoke-Sqlcmd` **on the host itself** works — no network path from this machine to the host is needed at all, only the AWS API. Verified live: `Invoke-Sqlcmd -ServerInstance "localhost\INDIA" -Database DeviceConfiguration` returned real results.

**Direct answer to §4b's "next concrete step" — done, via DB not MFM:** Ran the corrected query against all 13 known real identifiers from `test-mix-mapping.ps1` (Santos serial/registration, BM Alliance, Terra Cat serial + Hardware ID, Jeff Rowe serial/registration, Watco WA Rail serial/registration, Endeavour Energy, Cummins South Pacific, Northpoint Fleet, St Michael's Assoc):

```sql
SELECT COUNT(*) FROM mobileunit.MobileUnits WITH (NOLOCK)
WHERE UniqueIdentifier IN ('G7842118AB16','638PC8','G9W4Z4F027UF','G9FVH0K0YFNT','568851839',
  'G95Z3H8RC67','XS86KD','G9W0AV96750Z','1IHP987','G9U76EV2EXUK','G91A0E3XD1CV','G9B5P733ACBJ','G9HURMENV527')
```

**Result: 0 matches out of 13, against a real, non-empty table (61,738 total rows in AU's `mobileunit.MobileUnits`).** A fuzzy `LIKE '%7842118%'` substring check on the Santos serial also returned 0 — ruling out a formatting/truncation mismatch, not just an exact-match miss.

**What this settles vs. what it doesn't:** This is now a direct, DB-level, non-API-dependent confirmation that none of these 13 real customer Geotab units are registered in MiX's central mobile-unit table under any of the identifiers we have (serial, registration number, or Terra Cat's Hardware ID) — independent of whatever `test-mix-mapping.ps1`'s uniform 500 turns out to mean. It does **not**, by itself, prove §4b's fix (adding the `GetAssetMobileUnitMappingByUniqueIdentifierV3Async` resolution call to `GeotabQCManager`) would fix these specific 13 real-world cases — if Geotab GO units are provisioned entirely inside Geotab's own platform and were never meant to get a `mobileunit.MobileUnits` row at all (unlike MX/Cellocator hardware, which MiX itself provisions), then adding that call would likely just produce the same "could not be retrieved" MX already returns for everything else. **This reframes the open question:** is the gap "GeotabQCManager doesn't call the resolution step" (§4b, fixable in code), or "these Geotab units were never meant to be in this table at all" (a provisioning-model question, needs Kameel/dev — not fixable by mirroring MX's code pattern)? Both are still open; this section only rules out "maybe they're in there under a different identifier we haven't tried" as a live possibility for these 13.

**Still open, unchanged:** the uniform-500 diagnosis from §4c (needs live credentials via `test-mix-mapping.ps1`'s `Get-Credential` prompt — not something to run non-interactively).

## 4e. Follow-up (2026-08-19, same session): the "never provisioned at all" branch is disproven — Geotab devices ARE a real, working device type in AU's registry

§4d left two open branches for why the 13 real identifiers found zero matches: (a) `GeotabQCManager` is missing the resolution call, or (b) Geotab GO units were never meant to get a `mobileunit.MobileUnits` row at all. Branch (b) is now **disproven** by direct query.

**`mobileunit.MobileUnits.UniqueIdentifier` is `nvarchar(50)`, case-insensitive collation, and 5,895 of 58,801 non-null rows are alphanumeric** — ruled out a data-type/casing artifact behind the 0/13 result.

**2,635 rows in AU's table match the Geotab serial shape exactly** (`G` + 11 alphanumeric chars). All share `MobileDeviceKey = 5328`, whose `definition.Devices.SystemName` is **`MobileDevice.GeotabVehicleGateway`** — Geotab GO *is* a first-class, actively-provisioned device type in MiX's central registry, spanning **12 distinct legacy orgs** with **2,979 distinct Geotab serials total**. Resolved those 12 orgs by name (`dbo.Organisation.sOrganisationName` via `FMOnlineDB`, `liOrgID` join):

| LegacyOrgId | Organisation |
|---|---|
| 1788 | Airco Auto Instruments (DNC) |
| 2561 | Future Fleet (DNC) |
| 4227 | ** Powerfleet - Australia - Sydney Server (internal) |
| 4299 | Intellifleet |
| 4606 | Fleet Integrations |
| 4795 | Water Corporation WA PROD |
| 4879 | ** Powerfleet - Brodie (internal) |
| 4918 | ** Powerfleet - Australian Demo (internal) |
| 5321 | Coho Group |
| 5352 | ** Powerfleet - Australia - GeoTab (internal bench org) |
| 5359 | Service Stream |
| 5432 | FORACO Australia |

**None of these 12 orgs are Santos, BM Alliance Coal Operations, Terra Cat, Jeff Rowe, Watco WA Rail, Endeavour Energy, Cummins South Pacific, Northpoint Fleet, or St Michael's Assoc** — the customers from the video, whose 13 identifiers all scored 0/13 in §4d.

**Corrected conclusion:** this is not a provisioning-model impossibility. Geotab GO units *do* get real `mobileunit.MobileUnits` rows for other customers (Water Corporation WA, Service Stream, FORACO Australia, Coho Group, Intellifleet, Fleet Integrations are genuine production orgs here, alongside a few internal/demo ones). **The 13 specific units from the video simply haven't been onboarded into MiX's AU asset registry at all** — under any org, at least not under any identifier tried. §4b's architectural hypothesis (missing `GetAssetMobileUnitMappingByUniqueIdentifierV3Async` call) is now the single live theory again, but it can't be validated against these 13 units specifically, since they aren't registered anywhere to resolve *to*.

**Best next validation step:** re-run the identity-resolution question against a serial from one of the 12 *confirmed-registered* orgs above (ideally a real production one, not the internal/demo orgs) instead of the video's 13 units. If a real, registered Geotab serial from one of those orgs *also* fails to resolve via the MX endpoint / would also fail through `GeotabQCManager`, that confirms §4b's code-gap theory cleanly, independent of any onboarding-status confound.

**Sample confirmed-registered serials pulled (2026-08-19), one per real production org — ready to test, no further DB round trip needed:**

| LegacyOrgId | Organisation | Sample UniqueIdentifier | MobileUnitId |
|---|---|---|---|
| 4299 | Intellifleet | `G91U2JCDJX96` | 1791314377989447680 |
| 4606 | Fleet Integrations | `G9APJVZDBW9Y` | 1714700538298081280 |
| 4795 | Water Corporation WA PROD | `G9X6YFEN5Y67` | 1811392578899283968 |
| 5321 | Coho Group | `G97WA53S9P5T` | 1781529495829528576 |
| 5359 | Service Stream | `G9JXJ1R0H1CT` | 1762684754141712384 |
| 5432 | FORACO Australia | `G9Z6U9VE4HP0` | 1811608270642745344 |

**Caveat before using these:** these are real customer identifiers pulled from a live production database — treat as sensitive, don't paste into any external system, and this only proves the serial exists in MiX's registry, not that it's currently active/safe to run a live QC case against without checking with the org first. For a code-level identity-resolution test (does `GetAssetMobileUnitMappingByUniqueIdentifierV3Async` resolve it at all), a read-only call should be low-risk, but confirm that assumption before running one live against production.

## 4f. Live run confirms §4a's defect is worse than first shown, and the OBD install-type test partially succeeds (2026-08-19)

Ran both outstanding scripts for real against AU, back to back.

**`test-mix-mapping.ps1` (MX endpoint) — unchanged, still uniform 500s.** All 13 identifiers, same `ServerSideException`/"An unexpected error occurred."/empty stack trace as §4c described. Confirms the open question is still open, no regression, nothing new to add.

**`test-geotab-qc.ps1` (the real `/api/qc-automation-geotab` endpoint) — confirms and worsens §4a's defect.** Ran the santos serial (`G7842118AB16`, `GeotabInstallType=OBD`), Terra Cat serial, BM Alliance serial, and Terra Cat's Hardware ID — 4 calls, 1 second apart, in the same run. `DeviceActive` correctly returns "No device found" for all 4 (as expected — none are registered per §4d/§4e). **But every downstream check returns identical values across all 4 different, non-resolving identifiers:**

| Field | Value (identical across all 4 calls) |
|---|---|
| Odometer | `20061.725 km` |
| LastCommunication | `2026-08-19 00:37:26` (static, despite calls at `:35`/`:36`/`:37`/`:38`) |
| FaultCodes | `4 active (non-dismissed) faults` |
| Trips | `3 trip(s)` |
| IOX add-on presence | NFC fitted, Buzzer present, GoTalk fitted, Iridium fitted, WiFi **not** fitted — same pattern all 4 |

This extends §4a's finding (which only caught Trips/Odometer/Driver/LastCommunication drifting *across different days*) — now confirmed FaultCodes and every IOX-presence check are affected too, and the values are static **within a single run, seconds apart**, not just drifting slowly. This is strong, direct evidence for §4a's hypothesis: `GeotabTenantConfig.Database` being an empty string routes every case into one fixed default/no-scope Geotab session, and none of the downstream `Get*Async(deviceId, ...)` calls are actually guarded to require a real resolved `deviceId` — they're returning whatever that one fixed context contains, regardless of what was searched for.

**Practical risk, restated more sharply than §4a:** a QC report for **any** submitted Geotab serial that doesn't resolve currently shows a full, plausible-looking Pass on Trips/Odometer/Driver/LastCommunication (and Fail on FaultCodes) — for a device that was never found. Someone reading only the summary (not noticing `DeviceActive` says "No device found") would reasonably conclude the install passed QC.

**OBD install-type test — partial success, not a false lead.** Comparing Santos (`GeotabInstallType=OBD` set) against the other 3 (`InstallType=Unknown`): the `IgnitionSource` message changed from *"InstallType is unknown/null on the case -- cannot validate detection method without guessing"* to *"Ignition on/off data found but no detection-method diagnostic was found in the query window"* — **the `GeotabInstallType` gate itself works correctly** and materially changes behavior once set. It still can't reach Pass/Fail, but for a different, expected reason: the phantom fixed-context data (same root cause as above) doesn't happen to include an ignition detection-method diagnostic. This isn't a new defect — it's the same one, showing up in one more check.

**This is now a concrete, reproducible Jira-defect candidate** — not a threshold/config question like the placeholder items elsewhere in this doc. Two real bugs, cleanly separable: (1) missing null-guard after failed device resolution lets stale/wrong data produce false Pass/Fail verdicts, (2) `GeotabTenantConfig.Database` being empty routes every case into one fixed session instead of the customer-specific one FleetComplete's own install records already carry.

---

## 5. Debugging: inspecting real Geotab data shapes (William's ask, 2026-08-17)

William asked for breakpoints in the built code to see the actual JSON/data shapes MyGeotab returns for a real unit — this is exactly what's needed to resolve the "keyword match unconfirmed" and "threshold unconfirmed" items in §2 above. All locations are in `Powerfleet.Automation.Logic/Managers/QC/GeotabQCManager.cs` (line numbers per the 2026-08-14 read of `origin/integration` — pull latest before debugging, they may have drifted).

**Setup:** run `Powerfleet.Automation.Api` locally (or attach to a deployed INT/AU instance) pointed at real Geotab credentials, attach a debugger (Visual Studio/Rider/VS Code), submit one real case through `GeotabQCFormView` in the UI, and let it hit these breakpoints:

| Breakpoint location | What to inspect | Resolves which open question |
|---|---|---|
| After `client.GetDeviceAsync(...)` call (~line 125) | `device` object — is it a `GoDevice`? What's actually populated (`SerialNumber`, `ActiveTo`, `Major`/`Minor`) | Whether the IMEI passed in as `serialNumber` actually resolves a device at all |
| After `await Task.WhenAll(...)` (~line 143), before the `Check*` calls start (~line 152) | `trips`, `logRecords`, `statusData`, `ioxAddOns`, `exceptionEvents`, `faultData` — the raw collections before any filtering | Ground-truth data shape for every check below |
| Inside `CheckGpsQuality` (~line 337) | Every `StatusData` item's `Diagnostic.Id`/`Diagnostic.Name`/`Data` — specifically anything matching `KnownId.DiagnosticPositionValidId`/`DiagnosticHorizontalDopId` | Whether HDOP 5.0 threshold is realistic, and whether HDOP is even the right field per the AU doc's satellite-count framing |
| Inside `CheckIgnitionSource` (~line 391) | `StatusData` items whose `Diagnostic.Name` contains "Ign" — the actual diagnostic names Geotab returns for this unit | Whether the `"Ign"` substring match is finding the right diagnostic, and what real detection-method names look like (`RpmBasedIgn`/`TwoWireBaseIgn`/etc.) |
| Inside `CheckNfcDriverId`/`CheckBuzzerOutput`/`CheckGoTalkOutput`/`CheckIridiumDuress` (~lines 463-572) | `ioxAddOns` (`.Type` values) and `exceptionEvents` (`.Rule.Name` values) — the actual add-on types and event rule names Geotab returns | Whether the keyword guesses (`"driver id"`, `"buzzer"`, `"gotalk"`, `"emergency data success"`) actually match real `Rule.Name` strings, or need to be rewritten |
| Inside `CheckVoltage` (~line 250) | `StatusData` matching `DiagnosticGoDeviceVoltageId`/`DiagnosticBatteryVoltageId`/`DiagnosticDeviceBatteryVoltageId` — real voltage readings from a known-good unit | Whether 11.0V/3.5V thresholds are realistic for actual GO unit readings |

Capture the actual values seen (screenshot or copy from the debugger's locals/watch window) — that's the concrete evidence to bring back to Kameel for the placeholder-threshold questions in §2/[[GeoTab Test Plan]] §7, instead of asking him to confirm numbers in the abstract.

---
See [[GeoTab]] for full context, [[GeoTab Test Plan]] for the test plan this audit feeds, [[GeoTab System Map]] for the architecture, [[GeoTab Manual QA Workflow]] for the manual process being replaced.
