
JIRA:SR-16329  
[SR-16329 Error when activating Iridiums - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-16329)


The issue was reported to SOC that they are receiving this error on [LOGS.IO](http://LOGS.IO) when ==activating== Iridium Contract

```log
Error: 1438100446118297606

EXCEPTION! Iridium client exception:   

Exception Type: System.Exception EXCEPTION! Error adding contract to a pool group. Max number of members reached.   

Exception Type: System.Web.Services.Protocols.SoapException   Stack trace    at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)    at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)    at DynaMiX.Data.DataClients.IridiumDataClient.IwsApi.iws.activateSubscriber(activateSubscriberRequestImpl request) in D:\b\1\_work\1623\s\Data\DataClients\IridiumDataClient\Web References\IwsApi\Reference.cs:line 2133    at DynaMiX.Data.DataClients.IridiumDataClient.IridiumClient.<ActivateSubscriber>z__OriginalMethod(String demoAndTrialId, String promoId, String finalBundleId, String imei, Boolean isPoolingGroup, Int64 organisationId, Int64 correlationId) in D:\b\1\_work\1623\s\Data\DataClients\IridiumDataClient\IridiumClient.cs:line 520
```

## STEPS
**activating Iridium Contract**
Log on to AU DynaMIX
Navigate to Airtime Management Page
Look for 300534065212970
Activate

Halliburton - Australia
ID: 86
IMEI: 300534065212970

## Code

- Error adding contract to a pool group
	- Not found
- Max number of members reached
	- Not Found
- Logs... only once in last three days
	- https://app.logz.io/#/goto/6b23d1ad34bc0ec3635ef9f819603df4?switchToAccountId=157986
- HSSYDIIS50, HSSYDIIS54, HSSYDIIS55, HSSYDIIS56
	- DynaMiX.Data.DataClients.IridiumDataClient
		- Could the setting be wrong in config? BE / API
- CODE: BE:
	- IridiumClient.cs
	- client.activateSubscriber
		- iws client = new iws
	- Could not activate airtime contract

## Flowchart

