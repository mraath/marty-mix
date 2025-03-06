---
alias: Digital Matter
created: 2023-10-03T14:33
updated: 2023-11-02T09:19
---


This is a grouping [[Device]] holding the following devices

- [[Yabby]]
- [[Remora]]
- [[Oyster]]

## Important note

Since 22.15 all DME devices should no longer be configured as Remora\Oyster\Yabby\etc, but instead should be [[DME|Digital Matter]]  Mobile Devices in the UI

## Setting Odometer

- [[3rd party devices]] which don't have to send Odo, Odo is estimated
- Also see [[DIS Teltonika Odometer]]
## XML

DME device has a template of **560** - indicating it is a V1 devices with **AVLs disabled**. 
A V1 devices with AVLs **enabled** would be **561**.

## EG. Snippet config.xml

![[DME AVL Disabled eg 560.png|600]]
