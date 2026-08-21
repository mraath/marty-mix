---
created: 2026-08-17
---
# GeoTab Handwritten Meeting Notes (2026-08-17)

Marthinus's own handwritten notes taken while watching the AU Test Steps video — the same call as [[GeoTab Overview Transcript]], but these notes cover content from the **transcript's missing 3:20→56:07 gap**. This is the single best available source for that gap right now.

**Reading confidence:** the source is handwriting, photographed, genuinely hard to parse in places. Everything below is a best-effort transcription. Items marked **[low-confidence]** should be treated as a guess, not a fact — correct freely.

## Confirmed/high-confidence readings

**Login:** "OpsTools access info... nope" — directly contradicts William's original claim ("you can use OpsTools access info" for my.geotab.com). This likely explains the 2026-08-06 login failure already logged in [[GeoTab]] — OpsTools credentials do not grant direct my.geotab.com access; a separate credential path is needed. Matches [[GeoTab Code Audit]]'s finding that real Geotab tenant creds live in `appsettings.*.json`, not anything OpsTools-related.

**MyGeotab SDK relationships:** SDK is consumed by both UI and API (labelled "PA" — Powerfleet Automation); Salesforce is the source of Trip data. Matches [[GeoTab System Map]] exactly — no new info, just corroboration.

**Login flow:** Geotab shares the same login mechanism as MX (checkmark = confirmed working) — matches `LoginView.tsx` findings in [[GeoTab Code Audit]] (same form, Geotab just adds an extra Platform option).

**Basic checks, reiterated:** GPS, Ignition — matches transcript's captured portion exactly.

**Accessories list (matches AU doc §5.1, now hand-confirmed):** NFC, Aux (up to **8** inputs total — Aux 1-4 primary + Aux 5-8 secondary custom, matches the doc), External Buzzer, GoTalk, Iridium, custom/other. Duress button explicitly dash **and/or** remote. Harness type (3-wire, IOX, OBD) explicitly called out as **depending on vehicle type** — not a fixed harness per install.

**Work order status lifecycle (new confirmation — [[GeoTab Manual QA Workflow]]'s "Open question" asked whether the gap covers this):** New → In Progress → Reviewed/Wrapped **[low-confidence on exact word]** → Done / Cancelled. Resolves the workflow doc's previously-unconfirmed terminal states.

**MyAdmin:** confirmed as the status-check system for Geotab device types, consistent with the transcript's captured portion ("checks on my admin for the device status").

**The automation tool itself ("Auto" box):** fills in serial#, auto-verifies params, checks all key points — a plain-English restatement of what `GeotabQCManager` actually does, drawn independently from watching the video rather than reading code. Good cross-check that the tool's real behavior matches what Kameel/Kritiya described.

**Log review gotcha, reiterated:** "2500 / WEB / test export / laps" — matches the AU doc's 2,499-row web UI cap, and that exported reports (not the paginated web view) are the reliable way to check "laps"/trip data.

**RideView App [resolves an earlier open item]:** named explicitly as the companion/phone app for camera alignment. This confirms a claim from [[GeoTab]]'s "Podcast-style AI transcript" section that was previously flagged as unconfirmed ("'RideView app' as the named installer camera-alignment tool — unconfirmed, need Kameel to verify"). Treat as confirmed now.

**Master Portal has a different serial number scheme ["diff serial#", underlined]:** directly corroborates [[GeoTab Code Audit]]'s flagged risk — cameras/asset-related lookups through Master Portal use IMEI/duty-type/portal-feedback, explicitly separate from the Geotab device serial number used for GO units.

**IMEI/Billing System → Data Aggregation → BE lookup [resolves another earlier open item]:** confirms the podcast-transcript's previously-unconfirmed claim about an "IMEI-vs-billing-system fallback for camera verification through Master Portal." There's a real "Data Aggregation" layer sitting between an IMEI/billing system and whatever backend does the lookup.

**LightMetrics — new named system, not previously identified by name:** `master.lightmetrics.co`, maps device ID → asset ID. Earlier docs only had the generic "Vision AI Hub" label; this is likely that same product, now with its actual vendor name and domain.

**Legacy FC data-loss risk [new finding, worth flagging]:** a warning-flagged note reads "Some in: Unity Hub - legacy FC ... impersonate ... lost data" — suggesting the legacy Fleet Complete/Unity Hub integration can "impersonate" and lose data in some flow. Genuinely new risk, not previously documented anywhere in this vault. **Needs Kameel/Kritiya to explain what this actually means** — noted here so it isn't lost, not yet understood.

**Guardian platform:** `guardianlive.co` — the actual Guardian platform URL, not previously captured.

**Asset tracker abbreviations — new:** "ATI, ATS" appear next to "asset trackers" in the QA section — likely specific asset-tracker product/model codes. Not previously named this specifically anywhere in the vault.

## Low-confidence / needs your confirmation

- **"RPT scale"** (in a "1) GPS 2) Ignition 3) RPT scale" list near "Business Impact — visibility") — could be "RPM," could be something else entirely. Not corroborated by the transcript or AU doc, which only ever name GPS + ignition as the "basic" pair. **What did you actually mean here?**
- **"AI face...resell?" / "soft sight"** near Guardian/QA — possibly product feature names (facial recognition? a product called "SoftSight"?). Genuinely unclear from the handwriting.
- **"8 : 4 platform"** near the car icon with red cross-hatching (top-left) — the "8" prefix is unclear; "4 platform" likely continues the transcript's own "four platform"/"FC platform" mishearing question, already an open item.
- **"Test battery"** listed near Ignition/Iridium/Custom — possibly a literal physical-battery check distinct from the code's `Voltage` check, or possibly the same thing described in plain language. Unconfirmed which.

---
See [[GeoTab]] for full context, [[GeoTab Overview Transcript]] for the machine transcript this fills a gap in, [[GeoTab Manual QA Workflow]] and [[GeoTab System Map]] for the docs this updates.
