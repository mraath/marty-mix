---
created: 2025-06-12T15:17
updated: 2025-06-12T15:17
---
Herewith the legacy system's behaviour.

We selected a 3000 and a 4000

![[OPEN-258 String change needed for incompatible Devices Selected devices.png]]

We then dragged it to the new config group.

![[OPEN-258 String change needed for incompatible Devices Drag to config group-1.png]]

It then gives the following message:

![[OPEN-258 String change needed for incompatible Devices First message.png]]

```txt
"The selected asset(s) are moving to a new configuration group. Please note, the new configuration group may require asset specific information to be entered - this can be done on the mobile device settings tab in Fleet Admin.

Also note, devices that are associated with the selected asset(s) will be decommissioned if they are unavailable in the new configuration group."
```


If you then go ahead and hit MOVE, you get this message.

![[OPEN-258 String change needed for incompatible Devices Second message nice.png]]

The above is actually not too bad...

```txt
The mobile device type in this configuration group differs from the mobile device type installed in **1** of these assets. To move this asset to this configuration group, please perform the 'Change mobile device' function on the mobile device settings screen in Fleet Admin.
```

If you then have a look at the 3000, NOTHING happens with it... as with the new BETA page.
So the behaviour is the same.