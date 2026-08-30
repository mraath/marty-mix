---
type: source
title: Iridium System Integration
date_ingested: 2026-08-26
original_file: pasted diagram content (not saved to raw/ — no binary PDF available, only extracted text/labels)
---

## Summary

Architecture diagram ("Iridium Solution Integration") showing the full path from Iridium satellite hardware into MiX Fleet Manager. Two logically separate links converge on the DynaMiX side: a raw hardware/serial path direct to the Iridium Sat, and an API/Gateway path used for provisioning, queries, and commands against `FLEET (DynaMiX)`. Between the Iridium Gateway and the downstream processing pipeline sits a tier owned by the **Comms team** (`MiX.Connect.Iridium.Services.Comms` / `.Publisher`), fronted by `MiX.Connect REST API`.

## Key Takeaways

- Comms team owns the middle integration tier (`MiX.Connect.Iridium.Services.Comms` + `.Publisher`), not the hardware link or the FLEET/DynaMiX API side.
- IMEI validate & cache happens in the `Iridium Incoming service`, downstream of the Comms tier, before events/positions are processed into a `.dmp` file and handed to the DataProcessor.
- The DataProcessor for Iridium sat messages is shared with Satamatics — it's a "dedicated DataProcessor for Sat messages" generally, not Iridium-exclusive.
- Four independently logged components across the pipeline: Comms, Publisher, Iridium Incoming service, DataProcessor.

## New Entities/Concepts

- [[Iridium-Integration]] (entity, System)

## Wiki Pages Updated

- [[DynaMiX-Backend]] — added `IridiumManager` module path + connection to Iridium-Integration
- index.md
