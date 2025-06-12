---
created: 2025-06-11T14:58
updated: 2025-06-12T15:09
---
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-258)


- [ ] Ask Peter!!

Hi there. We are looking into a wording issue.
Basically in the new BETA page... if you were to select a few assets, but they are of different Device Types...
IF you go.... Move to Config Group.... you get shown a dialogue... where you should select the config group to move to...
If you were to select a MiX4000 (for instance) Config Group.... and there were also MiX3000s in there... it would show you a very serious message about the device being decommissioned, etc....
HOWEVER...
Actually we would just deselect any incompatible assets from the selection made, automatically, and then only move the (in this case) MiX4000 assets to the new Config Group...
 
What should the message be?
 
Something like:
"The incompatible devices will not be moved."
Something like that?
 
I am quickly looking to send you the current screenshot....

![[String change needed for incompatible Devices Message Eg.png|500]]


## Legacy system

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