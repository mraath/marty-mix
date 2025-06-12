---
created: 2025-06-11T14:58
updated: 2025-06-12T15:55
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


[[Legacy Config Group Move different Device Types]]

## Decision

I will change it to:

The mobile device type in this configuration group differs from the mobile device type installed in 1 of these asset(s). To move the asset(s) to this configuration group, please use the 'Change mobile device' function on the mobile device settings screen in Fleet Admin.




