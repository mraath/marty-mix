---
created: 2026-08-14
---
# GeoTab QC Automation — Test Plan

**Status: PLAN ONLY — not yet executed.** Covers OPEN-3192 (Geotab GO unit QC automation). See [[GeoTab System Map]] for architecture/people/systems/units/checks inventory, [[GeoTab Manual QA Workflow]] for the existing manual process this replaces, [[GeoTab Overview Transcript]] for the source call.

## 1. Objective

Confirm the built Geotab QC automation tool (Powerfleet.Automation + Powerfleet.Automation.UI) produces correct Pass/Fail/Pending verdicts for Geotab GO unit installations in INT and AU, before it's trusted to replace (or run alongside) Kritiya Shrestha's existing manual work-order QC process.

## 2. Scope

**In scope:** Geotab GO units only, INT + AU environments, via the Powerfleet Automation UI/API.

**Out of scope (confirmed nothing built):** Vision AI / Hub cameras, FT1, MGS, asset trackers (81/85/86/87), Guardian, MiX units. Don't write test cases against these — there's nothing to test yet. See [[GeoTab System Map]] "Units in scope" table.

## 3. Test levels

### 3.1 Automated tests — already exist, verify green first

Before any manual testing, confirm these pass on the target branch (`origin/integration`):

- API (NUnit/Moq): `GeotabQCManagerOpen3197Tests.cs` (GPS/HDOP, ignition), `Open3198Tests.cs` (voltage, fault codes), `Open3199Tests.cs` (the 4 NotTested stubs), `Open3200Tests.cs` (device active/firmware/trips/odometer/driver/last-comm), `Open3223Tests.cs` (NFC/buzzer/GoTalk/Iridium/WiFi), plus `GeotabApiClientTests.cs`, `GeotabApiClientFactoryTests.cs`, `GeotabAssetTests.cs`, `QCControllerTests.cs`
- UI: `route.test.ts`, `GeotabQCFormView.test.tsx`, `ApiService.test.ts`

**Known gap:** no Playwright/E2E coverage for this feature exists yet (tracked as OPEN-3363, still open). Manual testing below is the only end-to-end check until that lands.

### 3.2 Manual functional testing (this plan's main body)

**Preconditions:**
- Real INT/AU Geotab credentials confirmed live (OPEN-3254 Done) — verify login actually succeeds before testing (2026-08-06 attempt failed, cause undiagnosed)
- At least one known-good Geotab GO unit asset/serial number identified per environment on my.geotab.com

**Approach:** one test case per implemented check (table below), run against a real asset, compare tool verdict to expected outcome reasoned from the asset's known state.

### 3.3 Cross-validation against the manual process (highest-value test)

Ground truth for "is this verdict correct" isn't a spec — it's Kritiya Shrestha's existing manual QC judgement. Pick a sample of real work orders she's already manually QC'd in AU (mix of pass and fail cases if available), run the same serial numbers through the automated tool, compare verdicts side by side.

- **Match** → confidence signal for that check
- **Automated Fail where manual said Pass (or vice versa)** → investigate before rollout; don't assume the automated tool is right by default, the manual process is the current source of truth

### 3.4 Explicit non-goals for this pass

- The 4 stubbed checks (DigitalInputs, ExceptionEvents/harsh driving, VideoPeripheral, VideoRecordings) always return `NotTested` — don't write test cases expecting a real verdict, track as future work instead
- Placeholder thresholds (HDOP value, ignition KnownId, voltage 11.0V/3.5V, buzzer/GoTalk event source) — a Fail here may mean "wrong threshold," not "real defect." Flag to Kameel rather than logging as a bug until confirmed
- Non-Geotab unit types — no test cases, nothing built

## 4. Phased sequence

| Phase | What | Gate to proceed |
|---|---|---|
| 0 | Env/credential sanity — login works, ≥1 known asset resolves in both INT and AU | Login succeeds |
| 1 | Confirm automated suite (3.1) is green on current `integration` | All green |
| 2 | Manual functional pass, one case per implemented check (3.2), INT then AU | Each check exercised at least once per env |
| 3 | Cross-validation against N real AU work orders with Kritiya (3.3) | Verdicts reconciled, mismatches logged |
| 4 | Sign-off / go decision — log real defects to Jira, threshold/spec ambiguities to Kameel as questions | Decision made, not left open-ended |

## 5. Test case table (implemented checks — one row per check)

| Check | Pass condition (per code/doc) | Placeholder? |
|---|---|---|
| DeviceActive | Device reports as active in MyGeotab | No |
| Firmware | Firmware version present/valid | No |
| Trips vs Salesforce ActionDate | Trip data present within case ActionDate window, 7-day fallback | No |
| Odometer | Odometer reading present | No |
| Driver assignment | Driver assigned to device | No |
| LastCommunication | Comms within 24h | No |
| GPS/HDOP | Valid non-null current/last-known coordinate | **Yes — HDOP gate itself may not be real spec, doc only names satellite count as diagnostic** |
| IgnitionSource | On/off event pair present, RPM-based or other source | **Yes — KnownId constant unconfirmed** |
| Voltage | External ≥11.0V or battery ≥3.5V | **Yes — thresholds unconfirmed** |
| FaultCodes | No active non-dismissed fault codes | No |
| NFC/driver-ID | IOX NFC present + driver-ID tap logged | No |
| Aux 1 (handbrake/PTO) | On/off event present | No — resolved by AU doc |
| Aux 2 (4WD) | On/off event present | No |
| Aux 3 (seatbelt) | On/off event present | No |
| Aux 4 (duress dash/remote) | On/off event per duress input fitted | No |
| Buzzer output | Output-triggered event logged | No |
| GoTalk output | Output-triggered event logged | No |
| Iridium duress | "Emergency Data Success" event via satellite, works ignition on/off | No |
| WiFi presence (Santos) | IOX WiFi status present — allow delayed reporting, don't fail immediately out-of-zone | No |

**Not testable this pass (stubs, always `NotTested`):** DigitalInputs (broader Aux mapping beyond 1–4), ExceptionEvents/harsh driving, VideoPeripheral, VideoRecordings.

## 6. Risks during the testing window

- **OPEN-3362** (route.ts not yet hardened) — errors may not surface cleanly; a real backend error could look like a false test failure
- **OPEN-3256** (remove hardcoded secrets, parent epic OPEN-3255) — touches the same appsettings that just got real Geotab creds (OPEN-3254); if merged mid-testing could break login unexpectedly — watch it
- **OPEN-3363** (no E2E preflight) — no automated safety net if the backend becomes unreachable mid-manual-test; if login/API calls suddenly fail, check this first before assuming a data problem

## 7. Open questions blocking full confidence

Same list as [[GeoTab]]'s "Questions for Kameel" — carried here because they gate whether a Fail is trusted:

- Does `GeotabAsset.SerialNumber` assume 1:1 match with the Geotab-platform serial? Confirmed unsafe for asset trackers (out of scope anyway); unconfirmed for base GO units
- Does "exception events"/"harsh driving" (OPEN-3199's wording) map to the duress/buzzer/GoTalk events already implemented, or is it a distinct, unimplemented check?
- Is the HDOP threshold real, or should GPS quality only gate on satellite-count-as-diagnostic per the doc?
- Exact mechanism of the Salesforce cross-check — inferred from epic notes, not independently verified

## 8. Sign-off

Decision-makers: **Kameel Leeda** (PO, confirms pass/fail rules are right) + **Kritiya Shrestha** (AU QC, confirms cross-validation sample matches her manual judgement). Neither has been consulted yet — Phase 4 above is where that happens.

---
See [[GeoTab]] for full context, [[GeoTab System Map]] for the architecture this plan tests, [[GeoTab Manual QA Workflow]] for the manual process being cross-validated against.
