---
created: 2026-06-18T00:00
updated: 2026-06-19T12:44
wiki_ingested: 2026-06-19
---
# OPEN-2882 — CT-API - Add CAN compliance endpoint

> **Status:** Committed | **Sprint:** 26.14 | **Points:** 5 | **Assignee:** Marthinus Raath  
> **Depends on:** [[OPEN-2881 CT Spike CAN compliance data sources]] (data contract)

---

## Planned Endpoint

```
GET /api/can-compliance?orgId={orgId}&from={date}&to={date}
```

Returns org-level KPIs + per-vehicle rows. Design based on Mike's formula and spike findings.

---

## Related

- [[OPEN-2881 CT Spike CAN compliance data sources]] — spike must complete first
- [[OPEN-2883 CT-UI Add CAN compliance tab]] — UI consumes this endpoint
- [[Operations Tools]] — sprint context
