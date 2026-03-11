---
created: 2026-03-11T09:07
updated: 2026-03-11T09:11
---
# Automation API — PR Feedback 2026-03-11

> Verwant aan: [[OPEN-1762]] | PR #140516 | Outeur: William King

---

Hey - so paar idees op ons Automation API:

## 1. `ActionType.Decom` word gebruik in QCManager — FOUT

Hierdie LYK soos n fout - ekt dit gister gesien toe ek net gou die maak werk het dat ek my UI kon toets.
In `ActionQCRequestAsync` roep ons `DetermineMobileUnitSummaryAsync` met `ActionType.Decom` in plaas van `ActionType.QC`. Die verskil is GROOT — `Decom` fetch net 3 data sets (Peripherals, Trips, Positions), maar `QC` benodig 10. Dit beteken `MobileDeviceDetails`, `ConfigDetails`, `CameraSettings`, `Events` en `IridiumHistory` is almal **null** wanneer die QC toetse loop. Dit kan silent failures of NullReferenceExceptions veroorsaak. Lyk vir my dit was copy-paste van DecommissioningManager en die `ActionType` is nooit verander nie — moet `ActionType.QC` wees. **Cornel** kan jy asb kyk?

## 2. `_currentCase` field in QCManager — word nooit gebruik nie

Die nuwe `_currentCase` field word in die loop assign (`_currentCase = sfCase`) maar ek kan nêrens sien waar dit gelees word nie — die loop pass `sfCase` al klaar direk na elke Test* method. Dis dead code. Was dit beteken om die parameter passing pattern te verander en is die refactor half klaar? Net vir duidelikheid.

## 3. `AddTestAreaResult` return `Task` maar is sync — klein ding

Die method doen geen async werk nie maar return `Task.CompletedTask`. Werk fine — callers await dit korrek — maar dis n bietjie misleidend. Nie urgent nie, maar iets om later reg te maak.