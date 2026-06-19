---
created: 2026-06-18T00:00
updated: 2026-06-19T12:44
wiki_ingested: 2026-06-19
---
# OPEN-2881 — CT - Spike: CAN compliance data sources + formula

> **Status:** Committed | **Sprint:** 26.14 | **Points:** 3 | **Assignee:** Marthinus Raath  
> **Sequence:** after OPEN-2362, before OPEN-2882

---

## Goal

Sit with Mike Sydenham, get his exact CAN compliance formula and SQL/query, identify data sources (trip events, CAN dropout events), confirm device type classification logic, and document the data contract before building the API and UI.

---

## Background

Mike built a static HTML dashboard (`C:\Users\MarthinusR\Downloads\Nippon_Gases_Compliance_Dashboard\Nippon_Gases_CAN_Compliance_Dashboard.html`) for Nippon Gases showing per-vehicle CAN compliance. Marthinus is building this as a proper tab inside ConfigTools.

**Mike's Teams quote (2026-05-14):** "I started working on one that looks at the CAN compliance data based on CAN dropout event durations vs trip durations and am now trying to mash the two together"

---

## CAN Compliance Formula

```
compliance% = (trip_secs - dropout_secs) / trip_secs × 100
```

**Categories:**
- Reliable: ≥ ~90%
- Acceptable: ~70–90%
- Legacy: no CAN support
- Bad: < ~70%
- GPS-only

---

## What to Confirm with Mike

- [ ] Book 30 min with Mike Sydenham
- [ ] Get his exact SQL query for trip events + CAN dropout events
- [ ] Confirm device type classification logic (what makes a device "Legacy" vs "GPS-only")
- [ ] Confirm the exact compliance % thresholds per category
- [ ] Identify which DB tables / API endpoints have the data
- [ ] Document the data contract (inputs → API response shape)

---

## Related

- [[OPEN-2882 CT-API Add CAN compliance endpoint]]
- [[OPEN-2883 CT-UI Add CAN compliance tab]]
- [[Operations Tools]] — sprint context
