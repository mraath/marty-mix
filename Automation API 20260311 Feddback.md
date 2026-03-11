---
created: 2026-03-11T09:03
updated: 2026-03-11T09:03
---
  Hey - so paar goed om te bespreek van die PR review op OPEN-1762:                                                                                                                                               
  1. ActionType.Decom word gebruik in QCManager — dit lyk FOUT                                          

  In ActionQCRequestAsync roep ons DetermineMobileUnitSummaryAsync met ActionType.Decom in plaas van
  ActionType.QC. Die verskil is GROOT — Decom fetch net 3 data sets (Peripherals, Trips, Positions),    
  maar QC benodig 10. Dit beteken MobileDeviceDetails, ConfigDetails, CameraSettings, Events en
  IridiumHistory is almal null wanneer die QC toetse loop. Dit kan silent failures of
  NullReferenceExceptions veroorsaak. Lyk vir my dit was copy-paste van DecommissioningManager en die   
  ActionType is nooit verander nie — moet ActionType.QC wees. William, kan jy kyk?

  2. _currentCase field in QCManager — word nooit gebruik nie

  Die nuwe _currentCase field word in die loop assign (_currentCase = sfCase) maar ek kan nêrens sien   
  waar dit gelees word nie — die loop pass sfCase al klaar direk na elke Test* method. Dis dood code.   
  Was dit bedoel om die parameter passing pattern te verander en is die refactor half klaar? Net vir    
  duidelikheid.

  3. AddTestAreaResult return Task maar is sync — klein ding

  Die method doen geen async werk nie maar return Task.CompletedTask. Werk fine — callers await dit     
  korrek — maar dis n bietjie misleidend. Nie urgent nie, maar iets om later reg te maak.