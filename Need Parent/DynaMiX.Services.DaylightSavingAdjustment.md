---
created: 2023-09-22T09:15
updated: 2023-10-24T09:22
---

## Overview

This service runs every evening.
- It first updates all the Organisation [[DST]]
- It then updates all [[FM]] and [[MESA]] units' DST

## Code

This currently lives in the [[BE]] under [[Services]]
We should move it to our  [[DynaMiX.DeviceConfig]]

## Switch to use the new client method

[[TECHDEBT-427 Add config settings to switch between old and new code for the Daylight Savings Time service]]

## Links

- [[TECHDEBT-190 Move DST to API]]
- [[Command 45]]

Merge into above drawings and get rid of this:
- [ ] [[DST Moving Parts]]