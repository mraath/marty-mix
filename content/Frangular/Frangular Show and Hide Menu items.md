---
created: 2024-08-07T09:27
updated: 2024-08-07T13:02
---
## Show and Hide Menu items


### BACKEND

**web.config** setting. 
If the setting is there, we show it
If not, we hide it.
This way we can control it per environment.

![[OE-482 Replace OLD with NEW Key.png]]

It maps to this

![[OE-482 Replace OLD with NEW Deature.png]]

We use it like this:

```c#
if (FeatureHelper.FeatureEnabled(UIFeatures.InsightAgility))
{
	var insightAgility = new UIModuleMenuLink { Name = "MiX Insight Agility", Href = "/insight/agility-templates", AccessPermissionId = Permissions.CAN_ACCESS_MIX_AGILITY };
	Menus[0].Items.Insert(2, insightAgility);
}
```

This shows the Insight Agility menu if the UI feature was set in the web.config file
