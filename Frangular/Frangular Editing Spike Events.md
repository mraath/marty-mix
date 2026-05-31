---
wiki_ingested: 2026-05-28
created: 2025-06-04T11:02
updated: 2025-06-04T11:03
---

```mermaid
graph TD
    %% Core Shared Content (Level 0)
    E[EventContentTemplate.html] -->|included by| F[EventCreateTemplate.html]
    E -->|included by| G[EventEditTemplate.html]
    E -->|included by| H[EventInTemplateEditTemplate.html]
    E -->|included by| I[AssetEventEditTemplate.html]

    %% Shared Navigation/Layout Templates (Level 2)
    U[TemplateListTabsTemplate.html] -->|included by| X[EventTemplateTemplate.html]
    U -->|included by| Y[EventDuplicateTemplateTemplate.html]
    AH[TemplateListGridTemplate.html] -->|included by| AK[EventTemplateListTemplate.html]
    Z[LibraryTabsTemplate.html] -->|included by| AC[EventLibraryTemplate.html]

    %% Main Edit/Container Screens (Level 3) - Events Area
    F -->|create screen| AC
    G -->|edit screen| AC
    H -->|edit in template context| X
    I -->|edit on asset| AC
    AK -->|list view| X
    AC -->|main library screen| Z
    AC -->|likely includes| AH
    X -->|main template screen| U
    Y -->|duplicate template screen| U
```

Scope: The chart includes all templates directly related to the Events area (EventCreateTemplate.html, EventEditTemplate.html, EventInTemplateEditTemplate.html, AssetEventEditTemplate.html, EventTemplateListTemplate.html, EventLibraryTemplate.html, EventTemplateTemplate.html, EventDuplicateTemplateTemplate.html) and their dependencies (EventEditContentTemplate.html, TemplateListTabsTemplate.html, TemplateListGridTemplate.html, LibraryTabsTemplate.html), as specified in the original input.