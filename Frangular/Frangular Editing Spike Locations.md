---
wiki_ingested: 2026-05-28
created: 2025-06-04T10:58
updated: 2025-06-04T11:01
---

```mermaid
graph TD
    %% Core Shared Content (Level 0)
    J[LocationEditContentTemplate.html] -->|included by| K[LocationEditTemplate.html]
    J -->|included by| L[LocationInTemplateEditTemplate.html]
    J -->|included by| M[AssetTemplateLocationEditTemplate.html]

    %% Shared Navigation/Layout Templates (Level 2)
    U[TemplateListTabsTemplate.html] -->|included by| W[LocationTemplateTemplate.html]
    AH[TemplateListGridTemplate.html] -->|included by| AJ[LocationTemplateListTemplate.html]
    Z[LibraryTabsTemplate.html] -->|included by| AB[LocationsLibraryTemplate.html]

    %% Main Edit/Container Screens (Level 3) - Locations Area
    K -->|main edit screen| AB
    L -->|edit in template context| W
    M -->|edit on asset| AB
    AJ -->|list view| W
    AB -->|main library screen| Z
    AB -->|likely includes| AH
    W -->|main template screen| U
```

Scope: The chart includes all templates directly related to the Locations area (LocationEditTemplate.html, LocationInTemplateEditTemplate.html, AssetTemplateLocationEditTemplate.html, LocationTemplateListTemplate.html, LocationsLibraryTemplate.html, LocationTemplateTemplate.html) and their dependencies (LocationEditContentTemplate.html, TemplateListTabsTemplate.html, TemplateListGridTemplate.html, LibraryTabsTemplate.html), as specified in the original input.
