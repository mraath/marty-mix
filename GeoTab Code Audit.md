---
created: 2026-08-14
updated: 2026-08-14T13:33
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
| Iridium duress | Doc §5.1: "Emergency Data Success" via satellite, works ignition on/off | OPEN-3223 | Real | No | **Yes** (keyword match) |
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

---
See [[GeoTab]] for full context, [[GeoTab Test Plan]] for the test plan this audit feeds, [[GeoTab System Map]] for the architecture, [[GeoTab Manual QA Workflow]] for the manual process being replaced.
