# AC-163

		public const TransactionScopeOption DEFAULT_TRANSACTION_SCOPE = TransactionScopeOption.Suppress;

## Diagram


## Other

Common | Local | INT | DEV | Nuget
BE | Local | xxx
Config/JA/AC-163_POC_INT


-4385105327507150678

public const TransactionScopeOption DEFAULT_TRANSACTION_SCOPE = TransactionScopeOption.Suppress;



if (libraryMobileDevice.DefinitionMobileDeviceId == ConfigConstants.MobileDevices.MiX4000) //Think it was something like this
{
	//TODO: MR: Replace with API: Auto select those events.... ugly - but should work
	using (IContext context = Bindings.Global.CreateContext())
	{
		ILibraryEventManager libraryEventManager = DependencyResolver.GetInstance<ILibraryEventManager>(context);
		IEventTemplateManager templateEventManager = DependencyResolver.GetInstance<IEventTemplateManager>(context);

		var libraryEvents = libraryEventManager.GetAllLibraryEventsForEventTemplates(authToken, orgId);
		//var selectedEventIds = libraryEvents.Select(x => x.EventId).ToList();

		foreach (LibraryEvent libraryEvent in libraryEvents)
		{
			evtTemplate.TemplateEvents.Add(templateEventManager.CreateTemplateEventFromLibraryEvent(libraryEvent));
		}

		//templateEventManager.UpdateEventTemplate(authToken, orgId, evtTemplate.Id, evtTemplate.Name, selectedEventIds);
	}
}

using (IContext context = Bindings.Global.CreateContext())
{
	ILibraryEventManager libraryEventManager = DependencyResolver.GetInstance<ILibraryEventManager>(context);
	IEventTemplateManager templateEventManager = DependencyResolver.GetInstance<IEventTemplateManager>(context);

	var libraryEvents = libraryEventManager.GetAllLibraryEventsForEventTemplates(authToken, orgId);
	var selectedEventIds = libraryEvents.Select(x => x.EventId).ToList();






	using (var scope = DmxTransactionScope.Create())
	{
		EventTemplate eventTemplate = ConfigAdminRepository.GetEventTemplateWithChildrenById(evtTemplate.Id);
		IList<LibraryEvent> libraryEventsToAdd = ConfigAdminRepository.GetLibraryEvents(selectedEventIds);
		foreach (LibraryEvent libraryEvent in libraryEventsToAdd)
		{
			eventTemplate.TemplateEvents.Add(templateEventManager.CreateTemplateEventFromLibraryEvent(libraryEvent));
		}
		ConfigAdminRepository.UpdateEventTemplate(eventTemplate, new List<TemplateEvent>());
		scope.Complete();
	}
	//templateEventManager.UpdateEventTemplate(authToken, orgId, evtTemplate.Id, evtTemplate.Name, selectedEventIds);
}







//create default event template
List<long> eventIds = ConfigAdminRepository.GetAllEventDependenciesForDeviceByOrg(libraryMobileDevice.DefinitionMobileDeviceId, orgId);
var evtTemplate = evtManager.AddEventTemplate(authToken, orgId, evtTemplateName, eventIds);


if (libraryMobileDevice.DefinitionMobileDeviceId == ConfigConstants.MobileDevices.MiX4000)
{
	using (IContext context = Bindings.Global.CreateContext())
	{
		ILibraryEventManager libraryEventManager = DependencyResolver.GetInstance<ILibraryEventManager>(context);
		IEventTemplateManager templateEventManager = DependencyResolver.GetInstance<IEventTemplateManager>(context);

		var libraryEvents = libraryEventManager.GetAllLibraryEventsForEventTemplates(authToken, orgId);
		var selectedEventIds = libraryEvents.Select(x => x.EventId).ToList();
		templateEventManager.UpdateEventTemplate(authToken, orgId, evtTemplate.Id, evtTemplate.Name, selectedEventIds);
	}
}








http://localhost/DynaMiX.API/config-admin/-8386191436408769566/event_templates/-2495613010326351177
Data.Events
1) libraryEvents = libraryEventManager.GetAllLibraryEventsForEventTemplates(authToken, orgId);
ConfigAdminRepository.GetAllLibraryEvents(orgId, includeHiddenEvents: false, includeDefaultEvents: false, includeServerSide: false, includeHosViolationEvents: false);
EventType.Hidden [0]
EventType.Default [4]
EventType.ServerSide [7]
EventType.HosViolation [8]

2) UpdateEventTemplate(string authToken, long orgId, long eventTemplateId, string templateName, List<long> eventIds)
libraryEventId in carrier.SelectedEventIds
templateEventManager.UpdateEventTemplate(authToken, orgId, eventTemplateId, carrier.TemplateName, libraryEventIds);

  EventTemplate eventTemplate = ConfigAdminRepository.GetEventTemplateWithChildrenById(eventTemplateId);
  ** enttemplate with events, actions, conditions by id
    libraryEventIdsFromDb
    libraryEventIdsToAdd
    libraryEventIdsToRemove
      libraryEventsToAdd = ConfigAdminRepository.GetLibraryEvents(libraryEventIdsToAdd)
      ** libraryevents + actions + conditions + returnparams where libraryeventid in LIST **
      foreach (LibraryEvent libraryEvent in libraryEventsToAdd)
        eventTemplate.TemplateEvents.Add(CreateTemplateEventFromLibraryEvent(libraryEvent));
        if (libraryEvent.EventType != MiX.DeviceIntegration.Common.Enums.EventType.MiXVision)
          setConfigDirty = true;

    MarkAssetsConfigChangedByEventTemplate(eventTemplateId)

