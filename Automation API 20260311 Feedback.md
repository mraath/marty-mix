---
created: 2026-03-11T09:07
updated: 2026-03-11T09:19
---
# Automation API — PR Feedback 2026-03-11

> Verwant aan: [[OPEN-1762]] | PR #140516 | Outeur: William King

---

Hey - so paar idees op ons Automation API:

## 1. `ActionType.Decom` word gebruik in QCManager — **FOUT**

Hierdie LYK soos n fout - ekt dit gister gesien toe ek net gou die maak werk het dat ek my UI kon toets.
In `ActionQCRequestAsync` roep ons `DetermineMobileUnitSummaryAsync` met `ActionType.Decom` in plaas van `ActionType.QC`. Die verskil is GROOT — `Decom` fetch net 3 data sets (Peripherals, Trips, Positions), maar `QC` benodig 10. Dit beteken `MobileDeviceDetails`, `ConfigDetails`, `CameraSettings`, `Events` en `IridiumHistory` is almal **null** wanneer die QC toetse loop. Dit kan silent failures of NullReferenceExceptions veroorsaak. Lyk vir my dit was copy-paste van DecommissioningManager en die `ActionType` is nooit verander nie — moet `ActionType.QC` wees. **Cornel** kan jy asb kyk?

## 1b. `Decom` issue in code — **FOUT**

Ekt my UI deel klaar gemaak en ingecheck. MEt my toets het ek gesien die IMEI word nie gevind vir die unit nie en dan gebeur niks nie. So verder is ek nog nie 100% seker van of die UI die regte result sal wys nie, maar in die API, as mens dit toets, het dit def. omgeval. Ek wou dit nou gou fix maar op die oomblik bou my nuutste kode van DEV nie - ek sal dit gou probeer fix. @Cornel

## 2. `_currentCase` field in QCManager — word nooit gebruik nie

Die nuwe `_currentCase` field word in die loop assign (`_currentCase = sfCase`) maar ek kan nêrens sien waar dit gelees word nie — die loop pass `sfCase` al klaar direk na elke Test* method. Dis dead code. Was dit bedoel om die parameter passing pattern te verander en is die refactor half klaar? Net vir vraag.

## 3. `AddTestAreaResult` return `Task` maar is sync — klein

Die method doen geen async werk nie maar return `Task.CompletedTask`. Werk fine — callers await dit korrek — maar dis n bietjie misleidend. Nie urgent nie, maar iets om later reg te maak.
