---
created: 2025-07-22T07:47
updated: 2025-07-22T07:47
---
Jako you may have missed it - last week in some or other meeting I said that whenever we add a new device we need to search the entire DB solution for an existing device, like the M4K, and make sure we add references to the new device in all places where needed. This will avoid a situation where other teams pic a device ID or legacy type and we end up with clashes. They should not be using these old 16bit values - but many things should be different and are not....