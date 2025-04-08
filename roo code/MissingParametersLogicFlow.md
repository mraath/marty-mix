# C# Logic Flow for Determining "Missing Parameters" Status

This diagram illustrates the process followed by the C# code to determine if an event should have the status `EventStatus.NoParameters`.

```mermaid
graph TD
    A[MobileUnitEventsModule.GetEventTemplate] --> B(Load Aggregates);
    B --> C{MobileUnitManager.GetMobileUnitAggregate};
    B --> D(Load MobileDeviceTemplate);
    B --> E(Load EventTemplate);

    C --> F{ConfigAdminRepository.GetMobileUnitAggregate};
    F --> G[DB: MobileUnit + Overrides];

    A --> H{MobileUnitManager.GetEffectiveConfig};
    H --> I{GetResolvedMobileDevice};
    I --> J[Start with MobileDeviceTemplate];
    J --> K[Apply Overrides<br/>(OverridenDevices,<br/>OverridenPeripheralDevices,<br/>...)];
    K --> L(ResolvedMobileDevice);

    H --> M[Use ResolvedMobileDevice];
    M --> N(Filter Enabled Devices);
    N --> O(Get LibraryDeviceParameters);
    O --> P(Filter by Enabled Devices);
    P --> Q(AllSupportedParameters);

    H --> R[Use EventTemplate];
    R --> S(Process AllEvents);
    S --> T[Apply OverridenEvents];
    T --> U{Check Required Params vs AllSupportedParameters};
    U -- Required Param Missing --> V(Event NOT Monitored);
    U -- All Required Params Supported --> W(Event IS Monitored);

    A --> X{Iterate config.AllEvents};
    X --> Y{Is Event Enabled?};
    Y -- Yes --> Z{Is Event in config.MonitoredEvents?};
    Z -- No --> AA[Status = NoParameters];
    Z -- Yes --> AB[Status = Monitored / Check NoPeripheral];
    Y -- No --> AC[Status = NotMonitored];

    subgraph Data Loading
        C; D; E; F; G;
    end

    subgraph Configuration Resolution
        H; I; J; K; L; M; N; O; P; Q; R; S; T; U; V; W;
    end

    subgraph Status Determination
        X; Y; Z; AA; AB; AC;
    end
```

**Explanation:**

1.  **Data Loading:** The entry point (`GetEventTemplate`) loads the necessary data aggregates (MobileUnit with overrides, MobileDeviceTemplate, EventTemplate) from the database via the Repository.
2.  **Configuration Resolution:**
    *   `GetEffectiveConfig` is called.
    *   `GetResolvedMobileDevice` takes the base template and applies all mobile-unit-specific overrides to determine the actual hardware state.
    *   Using the resolved device, it filters out disabled components and identifies all parameters supported by the *enabled* hardware (`AllSupportedParameters`).
    *   It processes events from the template, applies event-specific overrides (`OverridenEvents`), and checks if all *required* parameters for each enabled event are present in `AllSupportedParameters`. This implicitly defines the `MonitoredEvents` collection.
3.  **Status Determination:** Back in `GetEventTemplate`, the code iterates through all events. If an event is enabled but was *not* deemed "Monitored" during configuration resolution (because a required parameter was missing), its status is set to `NoParameters`.
