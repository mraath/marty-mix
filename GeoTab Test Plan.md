---
created: 2026-08-14
updated: 2026-08-14T12:48
---
# GeoTab QC Automation — Test Plan

**Status: PLAN ONLY — not yet executed.** Covers OPEN-3192 (Geotab GO unit QC automation). See [[GeoTab System Map]] for architecture/people/systems/units/checks inventory, [[GeoTab Manual QA Workflow]] for the existing manual process this replaces, [[GeoTab Overview Transcript]] for the source call, and [[GeoTab Code Audit]] for the full Jira-ticket-vs-code cross-check this plan's §5/§6/§7 draw from.

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
- **Hostname gating, confirmed via code (2026-08-14):** the Geotab platform option in the login UI is only rendered on exactly two hostnames — `automation.mixdevelopment.com` (INT) and `automation-au.mixtelematics.com` (AU). On any other hostname the option isn't just disabled, it's absent from the DOM entirely. Confirm you're on the right URL before assuming the feature is broken or missing.

**Approach:** one test case per implemented check (table below), run against a real asset, compare tool verdict to expected outcome reasoned from the asset's known state.

**Install-config prerequisite:** per the AU Installation Test Procedure spec ([[GeoTab]]), which accessory checks apply to a given asset depends on that unit's actual install config (install method OBD vs Wired, harness type, and which accessories were flagged on its work order — NFC, Aux 1-4, duress, buzzer, GoTalk, Iridium, Wi-Fi). Confirm each test asset's fitted accessories before testing — an accessory check can't be meaningfully exercised (Pass or Fail) against a unit that doesn't have that accessory installed.

**Code-verified gaps (2026-08-14, read `GeotabQCManager.cs`/`GeotabQCFormView.tsx` directly off `origin/integration` in both repos — local checkouts of both repos are stale/behind, don't trust a local clone for this):**

- **Serial-number lookup risk is real and testable, not just theoretical.** `GeotabAsset` (the entity the earlier open question was about) is **dead code** — never referenced anywhere in the actual QC flow. `GeotabQCManager` instead passes `SalesforceCase.UniqueIdentifier` straight to `IGeotabApiClient.GetDeviceAsync`, which searches the Geotab SDK's `Device` catalogue by its `serialNumber` field. But `UniqueIdentifier` is exactly the form's **"IMEI"** input (`GeotabQCFormView.tsx` labels it IMEI, requires it, and `SmokeTestConfig`'s own comment calls it "IMEI / UniqueIdentifier"). If a GO unit's IMEI doesn't equal its Geotab `Device.SerialNumber`, `GetDeviceAsync` returns null and **every check silently degrades to Pending** (or worse — device-active/firmware read Pending, not an error) rather than a helpful "not found." **Add to Phase 0:** confirm a known asset's IMEI actually resolves a device via this lookup before trusting any other verdict from it.
- **IgnitionSource can only ever return `Pending` through the built UI.** The check's Pass/Fail logic depends on `SalesforceCase.GeotabInstallType` (OBD/ThreeWire/TwoWire) matching the detected ignition-detection-method name — but `GeotabQCFormView.tsx`'s submitted payload never sets `GeotabInstallType` (there's no form field for it at all), so on every real UI submission it's null, and the code's own `installType is null or GeotabInstallType.Unknown` branch forces Pending. This check cannot be exercised as Pass or Fail through manual UI testing at all right now — only via a direct API call with `GeotabInstallType` set explicitly. **Flag to Kameel/PO:** is this a missing UI field to raise as a defect, or an accepted gap for this pass?
- **Voltage logic is AND, not OR, and never Fails.** Pass requires *both* external ≥11.0V *and* battery ≥3.5V present simultaneously; if either is missing or below threshold, the verdict is Pending — there is no Fail branch at all. The earlier "External ≥11.0V or battery ≥3.5V" phrasing (now corrected in §5) doesn't match the code.
- **NFC-tap and Iridium-duress detection are also placeholder keyword matches**, same caveat as buzzer/GoTalk (§3.4) — all four (`"driver id"`, `"buzzer"`, `"gotalk"`, `"emergency data success"`) are unconfirmed `ExceptionEvent.Rule.Name` substring matches per the code's own TODO comment, not typed/confirmed event sources.
- **The form's "Odometer" input is never read by the QC logic.** `CheckOdometer` only reads Geotab trip data — the value a tester types into the UI's optional Odometer field has no effect on the verdict. Not a defect, just don't expect it to matter when designing test inputs.
- **Only 3 of the 15 real checks can ever return `Fail`:** DeviceActive (device inactive), IgnitionSource (TwoWireBaseIgn on a non-2-wire install), FaultCodes (active undismissed fault). Every other implemented check is structurally Pass/Pending-only — don't design a test case expecting a Fail from GPS/HDOP, Voltage, or any of the 5 accessory-presence checks; the cross-validation pass (§3.3) gets its highest value from Kritiya's real Fail cases on these 3 specifically.

### 3.3 Cross-validation against the manual process (highest-value test)

Ground truth for "is this verdict correct" isn't a spec — it's Kritiya Shrestha's existing manual QC judgement. Pick a sample of real work orders she's already manually QC'd in AU (mix of pass and fail cases if available), run the same serial numbers through the automated tool, compare verdicts side by side.

- **Match** → confidence signal for that check
- **Automated Fail where manual said Pass (or vice versa)** → investigate before rollout; don't assume the automated tool is right by default, the manual process is the current source of truth

### 3.4 Explicit non-goals for this pass

- The 4 stubbed checks (DigitalInputs, ExceptionEvents/harsh driving, VideoPeripheral, VideoRecordings) always return `NotTested` — don't write test cases expecting a real verdict, track as future work instead
- Placeholder thresholds/unconfirmed matches (HDOP value, ignition KnownId, voltage 11.0V/3.5V, and the NFC/buzzer/GoTalk/Iridium keyword-substring event matches — full list in §3.2's "Code-verified gaps") — a Fail here may mean "wrong threshold," not "real defect." Flag to Kameel rather than logging as a bug until confirmed
- Non-Geotab unit types — no test cases, nothing built
- **CAN/OBD-derived checks (fuel level, RPM)** — per the AU spec doc, these are only surfaced when a customer specifically requests them, not part of standard pass/fail, and nothing in OPEN-3192 builds them. No test cases.
- **Aux 5-8 (secondary, customer-labelled)** — non-standard, customer-agreed labels per the doc; not part of the built check set. No test cases.
- **Other/legacy IOX (relay kit)** — doc marks this manual-verification-only, no log field exists to automate against. No test cases.
- **Camera checks (Geotab-integrated or Hub/Unity)** — entirely unbuilt per the AU spec doc (linkage, comms, live view, mounting sign-off all require Master Portal/Vision AI Hub integration that doesn't exist in this epic). No test cases.

## 4. Phased sequence

| Phase | What | Gate to proceed |
|---|---|---|
| 0 | Env/credential sanity — login works, ≥1 known asset resolves in both INT and AU | Login succeeds |
| 1 | Confirm automated suite (3.1) is green on current `integration` | All green |
| 2 | Manual functional pass, one case per implemented check (3.2), INT then AU | Each check exercised at least once per env |
| 3 | Cross-validation against N real AU work orders with Kritiya (3.3) | Verdicts reconciled, mismatches logged |
| 4 | Sign-off / go decision — log real defects to Jira, threshold/spec ambiguities to Kameel as questions | Decision made, not left open-ended |

## 5. Test case table (implemented checks — one row per check, verified against `GeotabQCManager.cs` @ `origin/integration` 2026-08-14)

| Check | Pass condition (per code) | Fail-capable? | Placeholder/unconfirmed? |
|---|---|---|---|
| DeviceActive | `GoDevice.ActiveTo == DateTime.MaxValue` (or still in the future) | **Yes** — ActiveTo in the past | No |
| Firmware | `GoDevice.Major`/`Minor` both present and non-zero | No | No |
| Trips vs Salesforce ActionDate | ≥1 trip with `Start` ≥ window start (ActionDate, 7-day fallback) | No | No |
| Odometer | Non-zero `Trip.Odometer` in window (the form's own Odometer input is **not** read by this check) | No | No |
| Driver assignment | ≥1 trip with a non-null, non-`NoDriver` Driver | No | No |
| LastCommunication | Most recent LogRecord/StatusData timestamp within 24h | No | No |
| GPS/HDOP | `PositionValid` diagnostic true **and** HDOP ≤ 5.0, both present | No | **Yes** — HDOP threshold (5.0) and the HDOP gate itself are unconfirmed against the AU doc, which only names satellite count as diagnostic |
| IgnitionSource | Ignition on/off diagnostic present + detected method matches `sfCase.GeotabInstallType` (OBD→Rpm/EngineBaseIgn, ThreeWire→ThreeWireBaseIgn) | **Yes** — TwoWireBaseIgn detected on a non-2-wire install | **Yes** — detection-method KnownId unconfirmed; **and no UI field sets `GeotabInstallType`, so this returns Pending on every real UI submission** (see gap above) |
| Voltage | **Both** external ≥11.0V **and** battery ≥3.5V present (AND, not OR) | No — low/missing reading → Pending | **Yes** — both thresholds unconfirmed |
| FaultCodes | No active (non-dismissed) fault codes | **Yes** — ≥1 active fault | No |
| NFC/driver-ID | IOX NFC present + a `"driver id"`-keyword exception event | No | **Yes** — keyword-substring match unconfirmed |
| Buzzer output | `"buzzer"`-keyword exception event present | No | **Yes** — keyword unconfirmed |
| GoTalk output | `"gotalk"`-keyword exception event present | No | **Yes** — keyword unconfirmed |
| Iridium duress | Iridium IOX present + `"emergency data success"`-keyword event, works ignition on/off | No | **Yes** — keyword unconfirmed |
| WiFi presence (Santos) | Wi-Fi IOX add-on present — presence-only, no recency requirement | No | No |

**Not testable this pass (stubs, always `NotTested`):**
- `DigitalInputs` — covers **all** of Aux 1 (handbrake/PTO), Aux 2 (4WD), Aux 3 (seatbelt), and Aux 4 (duress dash/remote). Despite the AU doc appearing to resolve the DIN-to-Aux wiring mapping, **no code implements these as distinct checks** — they're all folded into this one stub, which always returns `NotTested` pending technical-team confirmation of per-install wiring. Don't write test cases against Aux 1-4 expecting a real verdict; the only duress-related check that's actually implemented is Iridium duress (satellite-triggered, listed above), which is a distinct mechanism from a physical dash/remote button's on/off log event.
- `ExceptionEvents`/harsh driving, `VideoPeripheral`, `VideoRecordings` — same always-`NotTested` stub pattern.

## 6. Risks during the testing window

- **OPEN-3362** (route.ts hardening) — code-check 2026-08-14: the current `origin/integration` `route.ts` already handles an unparsable request body, a missing auth token, missing host config, and forwards non-OK upstream responses with sanitised (not raw) error logging — looks more hardened than this risk originally assumed. Re-verify OPEN-3362's live Jira status before testing rather than assuming it's still broken; if it's Done, this risk can be dropped
- **🔴 OPEN-3256 is not a future risk — it's a confirmed current exposure.** Code-check 2026-08-14 ([[GeoTab Code Audit]]) found `appsettings.INT.json`/`appsettings.AU.json` on `origin/integration` already contain the real Geotab username/password in cleartext right now (OPEN-3254's output). OPEN-3256 (parent epic OPEN-3255) is meant to fix exactly this and is still open. This needs a decision from William/Kameel before or during this testing pass, not just a watch-item — also worth confirming whether a mid-testing fix for OPEN-3256 could rotate/relocate the credential and break login unexpectedly
- **OPEN-3363** (no E2E preflight) — no automated safety net if the backend becomes unreachable mid-manual-test; if login/API calls suddenly fail, check this first before assuming a data problem
- **Geotab web UI 2,499 row/filter cap** (called out explicitly in the AU spec doc) — any check spanning a full day+ of log activity (Trips vs Salesforce ActionDate, LastCommunication) can silently miss events if verified via the paginated my.geotab.com view instead of an exported report. If a manual cross-check of a Fail verdict looks wrong, confirm via exported report before assuming the tool is wrong.

## 7. Open questions blocking full confidence

Same list as [[GeoTab]]'s "Questions for Kameel" (revised 2026-08-06 against the AU Installation Test Procedure spec doc) — carried here because they gate whether a Fail is trusted:

- **Scope confirmation:** is OPEN-3192 intentionally GO-unit-only (cameras/legacy Hub/asset-trackers as later phases), or did the epic miss scope it was supposed to cover?
- **Serial-number resolution — reframed by the 2026-08-14 code check:** `GeotabAsset.SerialNumber` was the earlier concern, but that entity is unused dead code. The real question is whether the IMEI a tester enters in the UI (submitted as `SalesforceCase.UniqueIdentifier`) actually matches the Geotab SDK's own `Device.SerialNumber` field, since that's the literal field `GetDeviceAsync` searches by. The doc separately confirms IMEI-vs-platform-serial mismatch is a **known problem for asset trackers** (81/85/86/87 — out of scope anyway); unconfirmed either way for base GO units — this is now Phase 0's first real test, not just a documentation question
- Does "exception events"/"harsh driving" (OPEN-3199's wording) map to the duress/buzzer/GoTalk events already implemented, or is it a distinct, unimplemented check?
- Is the HDOP threshold real, or should GPS quality only gate on satellite-count-as-diagnostic per the doc? (The doc explicitly frames satellite count as a diagnostic aid, not pass/fail — it doesn't mention an HDOP gate at all, which partially answers this but doesn't settle whether the built HDOP check is spec-derived or a code-only assumption.)
- Exact mechanism of the Salesforce cross-check — inferred from epic notes, not independently verified
- **Credentials:** OPEN-3254 (real INT/AU creds) shows Done as of the 2026-08-06 Jira check, but the 2026-08-06 login attempt against my.geotab.com still failed for an undiagnosed reason — confirm login actually works before trusting any verdict (see Phase 0 gate above)
- Does Kameel know this build (OPEN-3192) already exists, or is he expecting this from scratch?

## 8. Sign-off

Decision-makers: **Kameel Leeda** (PO, confirms pass/fail rules are right) + **Kritiya Shrestha** (AU QC, confirms cross-validation sample matches her manual judgement). Neither has been consulted yet — Phase 4 above is where that happens.

**Separate from test sign-off:** the hardcoded-credential exposure (§6) needs a decision from **William King** and/or Kameel on its own timeline — it isn't gated on the testing phases above and shouldn't wait for Phase 4.

---
See [[GeoTab]] for full context, [[GeoTab System Map]] for the architecture this plan tests, [[GeoTab Manual QA Workflow]] for the manual process being cross-validated against, [[GeoTab Code Audit]] for the full code-vs-Jira-vs-doc cross-check.
