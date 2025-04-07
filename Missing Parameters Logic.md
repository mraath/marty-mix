---
created: 2025-04-07T16:22
updated: 2025-04-07T16:47
---
Herewith the code I am trying to consider when writing the alert for missing parameters

``` C#
IEffectiveConfig config = mobileUnitManager.GetEffectiveConfig(mobileUnit, mobileDeviceTemplate, eventTemplate); //CLINE: I will give a code snippet in the next block of code to get the GetEffectiveConfig

				bool canEditMobileUnitEvents = AuthorisationManager.Authorise(authToken, ConfigConstants.Permissions.CAN_UPDATE_TEMPLATE_EVENTS, orgId);

				var carrier = new MobileUnitEventsPageCarrier();
				carrier.AssetName = asset.Description;
				carrier.EventTemplateName = eventTemplate.Name;
				foreach (IEvent evnt in config.AllEvents)
				{
					MobileUnitEventItemCarrier item = ConvertToCarrier(evnt);

					EventStatus eventStatus = evnt.IsEnabled ? EventStatus.Monitored : EventStatus.NotMonitored;

					if (evnt.IsEnabled)
					{
						if (!config.MonitoredEvents.Contains(evnt))
						{
							eventStatus = EventStatus.NoParameters; //CLINE: This is the main Setting we check
							item.Description.Disabled = true;
						}
						else
						{
							if (evnt.EventType == EventType.MiXVision) //CLINE: I think this has no effect on the stored proc
							{
								if (!config.MobileDevice.AllPeripheralDevices.Any(x => x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.STREAMAX_C6DAI
								|| x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.STREAMAX_ADPLUS
								|| x.DefinitionDeviceId == ConfigConstants.PeripheralDevices.STREAMAX_M1N))
								{
									eventStatus = EventStatus.NoPeripheral;
									item.Description.Disabled = true;
								}
							}
						}
					}
```

```c#
//CLINE: GetEffectiveConfig logic (It is mostly entity frameworks)
public IEffectiveConfig GetEffectiveConfig(MobileUnit mobileUnit, MobileDeviceTemplate tempalteAggregate, EventTemplate eventTemplateAggregate)
{
		IMobileDevice resolvedMobileDevie = GetResolvedMobileDevice(mobileUnit, tempalteAggregate);
		return GetEffectiveConfig(mobileUnit, eventTemplateAggregate, resolvedMobileDevie);
}


```
