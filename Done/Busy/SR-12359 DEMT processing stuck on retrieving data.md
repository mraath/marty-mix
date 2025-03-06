#LibraryEvents 

# [[SR-12359] DEMT processing stuck on retrieving data - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/SR-12359)

## Issue

Hi [Marthinus Raath](https://jira.mixtelematics.com/secure/ViewProfile.jspa?name=marthinusr) we getting a timeout error on the below client method. This is affecting Demt QueryRetrieval Service on SYDNEY

DeviceConfigClient.LibraryEvents(dc).GetAllLibraryEventsForDC(null)

public const string GetAllLibraryEventsForDC = "event-summaries/all"