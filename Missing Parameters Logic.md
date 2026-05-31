---
wiki_ingested: 2026-05-28
created: 2025-04-07T16:22
updated: 2025-04-07T16:49
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

```c#
public IMobileDevice GetResolvedMobileDevice(MobileUnit mobileUnit, MobileDeviceTemplate template)
{
		IMobileDevice rmd = ObjMobileDevice.CreateFromTemplate(template);
		IDefinitionLevelManager definitionLevelManager = DependencyResolver.GetInstance<IDefinitionLevelManager>(_context);
		rmd.MobileUnitId = mobileUnit.Id;

		rmd.UnitIdentifier = mobileUnit.UniqueIdentifier;

		foreach (MobileUnitProperty mobileUnitProperty in mobileUnit.MobileUnitProperties)
		{
			if (!rmd.MobileUnitProperties.ContainsKey(mobileUnitProperty.DefinitionDeviceId))
			{
				rmd.MobileUnitProperties.Add(mobileUnitProperty.DefinitionDeviceId, new List<IProperty>());
			}

			IProperty mup = new ObjDeviceProperty();

			mobileUnitProperty.CopyTo(mup);

			rmd.MobileUnitProperties[mobileUnitProperty.DefinitionDeviceId].Add(mup);
		}


		foreach (OverridenPeripheralDevice opd in mobileUnit.OverridenPeripheralDevices)
		{
			if (opd.LineId.HasValue)
			{
				IPeripheralDevice tmp = rmd.AllPeripheralDevices.SingleOrDefault(x => x.DefinitionLineId == opd.LineId);

				if (tmp != null)
				{
					tmp.DefinitionLineId = null;
					tmp.IsEnabled = false;
				}
			}

			IPeripheralDevice rpd = rmd.AllPeripheralDevices.Single(x => x.Id == opd.TemplateDeviceId);
			rpd.DefinitionLineId = opd.LineId;
			rpd.IsEnabled = opd.LineId.HasValue;
			rpd.RecordInterval = opd.RecordInterval;
			rpd.DefinitionPowerDeviceId = opd.PowerDeviceId;
		}

		foreach (OverridenDevice old in mobileUnit.OverridenDevices.Where(x => definitionLevelManager.GetDeviceCategory(x.DeviceType) == ConfigEnums.DeviceCategory.Logical))
		{
			var rld = rmd.AllLogicalDevices.SingleOrDefault(x => x.TemplateDeviceId == old.TemplateDeviceId);
			if (rld == null)
			{
				DmXLogger.Log("Overriden logical device has no corrisponding record in template\r\n" +
									 "OverridenDeffinitionDeviceId:" + old.DefinitionDeviceId, LogLevel.Exception);
				continue; // this happens because of bad data, there is an overridden record for something that does not exist on template level
			}

			rld.IsEnabled = old.IsEnabled;


		}

		foreach (OverridenDeviceParameter odp in mobileUnit.OverridenDeviceParameters)
		{
			IParameter rdp = FindCalibratableParameter(rmd, odp);
			rdp.Value1 = odp.Value1;
			rdp.Value2 = odp.Value2;

			rdp.Calibration1 = odp.Calibration1;
			rdp.Calibration2 = odp.Calibration2;
		}

		foreach (OverridenDeviceProperty odp in mobileUnit.OverridenDeviceProperties)
		{
			IProperty rdp = FindProperty(rmd, odp);
			if (rdp != null)
				rdp.Value = odp.Value;
		}

		return rmd;
}
```

```c#
private IEffectiveConfig GetEffectiveConfig(MobileUnit mobileUnit, EventTemplate eventTemplateAggregate, IMobileDevice resolvedMobileDevice)
{
		IEffectiveConfig config = new ObjEffectiveConfig();
		config.MobileDevice = resolvedMobileDevice;

		//Remove disabled devices

		config.MobileDevice.AllLogicalDevices = config.MobileDevice.AllLogicalDevices.Where(x => x.IsEnabled).ToList();
		config.MobileDevice.AllPeripheralDevices = config.MobileDevice.AllPeripheralDevices.Where(x => x.IsEnabled).ToList();

		//Collect all device id's ( for all enabled devices )
		List<long> allDefinitionDeviceIds = new List<long>();
		allDefinitionDeviceIds.Add(config.MobileDevice.DefinitionDeviceId);
		allDefinitionDeviceIds.AddRange(config.MobileDevice.AllLogicalDevices.Select(x => x.DefinitionDeviceId));
		allDefinitionDeviceIds.AddRange(config.MobileDevice.AllPeripheralDevices.Select(x => x.DefinitionDeviceId));

		IList<LibraryDeviceParameter> deviceParameters = ConfigAdminRepository.GetLibraryDeviceParameters(GlobalData.GetGroupIdForLibraryid(config.MobileDevice.LibraryId));

		deviceParameters = deviceParameters.Where(x => allDefinitionDeviceIds.Contains(x.DefinitionDeviceId)).ToList();

		foreach (LibraryDeviceParameter libraryDeviceParameter in deviceParameters)
		{
			ObjDeviceParameter objDeviceParameter = new ObjDeviceParameter();
			libraryDeviceParameter.CopyTo(objDeviceParameter);
			config.AllSupportedParameters.Add(objDeviceParameter);
		}

		foreach (TemplateEvent templateEvent in eventTemplateAggregate.TemplateEvents)
		{
			if (templateEvent.EventType == ConfigEnums.EventType.Hidden)
				continue;

			IEvent objEvent = ObjEvent.AddFromTemplate(templateEvent, config);

			OverridenEvent overridenEvent = mobileUnit.OverridenEvents.SingleOrDefault(x => x.TemplateEventId == templateEvent.Id);

			if (overridenEvent != null)
				objEvent.IsEnabled = overridenEvent.IsEnabled;


			foreach (IEventCondition eventCondition in objEvent.Conditions)
			{
				IParameter supportedParameter = config.AllSupportedParameters.FirstOrDefault(x => x.DefinitionParameterId == eventCondition.DefinitionParameterId);
				if (supportedParameter == null // the device does not report this parameter
						&& eventCondition.DefinitionParameterId != ConfigConstants.Parameters.OPEN_BRACKET
						&& eventCondition.DefinitionParameterId != ConfigConstants.Parameters.CLOSE_BRACKET)
				{
					continue;
				}


				OverridenEventConditionThreshold oecdt = mobileUnit.OverridenEventConditionThresholds.SingleOrDefault(x => x.TemplateEventConditionId == eventCondition.Id);

				if (oecdt != null)
					eventCondition.Value = oecdt.Value;
			}

			foreach (IEventAction eventAction in objEvent.Actions)
			{
				OverridenEventAction oea = mobileUnit.OverridenEventActions.SingleOrDefault(x => x.TemplateEventActionId == eventAction.Id);

				if (oea != null)
				{
					eventAction.ActionSettings = oea.ActionSettings;
					eventAction.IsEnabled = oea.IsEnabled;
					eventAction.Delay = oea.Delay;
					//eventAction.ReloadActionSettings();
				}
			}
		}

		return config;
}
```
