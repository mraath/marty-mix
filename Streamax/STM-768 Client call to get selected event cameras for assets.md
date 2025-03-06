
## Merging

- MiX.DeviceConfig
	- 1 Branch
- DynamiX.DeviceConfig
	- 5 Branches
		- Figure out which to use
- DB
	- One Branch
	- 

- [x] Message to Justus

Hey. Hope you had a good paternity time. 
At least it is Friday, so only today and then back to rest for you :-)

I just wanted to hand over STM-768 to you.
The 4 repos I had to update were...
- MiX.DeviceIntegration.Core
- MiX.DeviceIntegration
- DynaMiX.Deviceconfig
- Database

As far as I can tell I finally got it all to work.
With all of them (except core), I first created a temp branch:
Config/JA/STM-768_INT_PreMerge
I merged INT into it.
I then also ensured DEV was already merged in.
The biggest issue was the core nugets in DynaMiX.DeviceConfig.
It used the Beta versions.
I then build actual ones, pulled that in and then the merge worked well.

I then deployed all this on INT.
I build a new client for MiX.DeviceIntegration to hand to Lightning for testing.
DP got a problem with some of their code on INT.
It was then rolled back. By now I think it was merged back into INT.

The person in Lightning waiting for this is:
Jan-Wynand
I told him that we are getting things ready for him.
He is very excited to start testing...
But then we had a lot of Production release issues and some INT issues.
So to this point I haven't been able to hand it to him, but I did tell him it would be this:

New Client: MiX.DeviceConfig.Api.Client.2023.3.20230111.1.nupkg

I have pulled the above one into our testing app.
MiX.DeviceConfig.Api.TestApp
Problem then is some other client methods dissappear for older tests...
Two of them... 
DeviceState.SetAssetCurrentDriver
DeviceState.GetAssetCurrentDriver
So for me to continue I just commented those tests out,
but something merged this out OR it was done with intent.

So I added the new client, and it found all stuff needed.
I will now just test it again.
So far I don't get any results.
Herewith my code.

```c#
private static async Task GetSelectedEventCameras(string authToken)
		{
			try
			{
				var assetId1 = 1179100901469630464;
				//var assetId2 = 1186796787570077696;
				var groupId = 6195278869291132898; //-8386191436408769566;
				long correlationId = 0;

				//id=1179100901469630464&orgId=-8386191436408769566

				//groupId = 1098;
				List<long> assetIds = new List<long>() { assetId1 }; //, assetId2 };

				List<MobileUnitEventCameras> result = await DeviceConfigClient.MobileUnits.GetSelectedEventCameras(authToken, groupId, assetIds, correlationId).ConfigureAwait(false);
			}
			catch (Exception ex)
			{
				throw new Exception($"SetDefaultConfigurationGroup Exception: {ex}");
			}
		}
	
```

I didn't check it in because of the other issues and because I get no results.
Once you get your test against INT to work, please notify Jan-Wynand.
I will tell him that you will let him know.

Cheers man,
Please shout if you have any questions






BRANCH: ==Config/JA/STM-768_INT_PreMerge==
- [x] MiX.DeviceIntegration
	- Kept Branch for INT
	- Busy merging to int
	- [x] Deploy and get nuget
	- [x] Use in MiX.DynaMiX
- [x] MiX: MiX.DeviceIntegration.Common version changed
	- [x] Ready to merge to INT
	- [x] THEN build
	- [x] MiX.DeviceConfig.Api.Client.2023.3.20230109.1
	- [x] Then pull into the below
- [x] DynaMix: INT merged to PreMerge... DEV outstanding
	- [x] Merge DEV, the to INT
		- [x] MiX.DeviceIntegration.DataProcessing.Core (20221215.1-beta)
		- [x] MiX.DeviceIntegration.DataProcessing.DataAccess
		- [x] MiX.DeviceIntegration.DataProcessing.DTOs
		- [x] MiX.DeviceIntegration.Common
		- [x] MiX.DeviceIntegration.Core.Logging
		- [x] MiX.DeviceIntegration.Core.Metrics
		- [x] MiX.DeviceIntegration.Core.Alerts
		- [x] MiX.DeviceIntegration.Core.Queueing
		- [x] MiX.DeviceIntegration.Queueing.Kafka
		- [x] MiX.DeviceIntegration.Queueing.MSMQ
		- [x] MiX.DeviceIntegration.QueueingManager
		- [x] MiX.DeviceIntegration.Core.DeviceState
		- [x] MiX.DeviceIntegration.Core.LoadBalancing
		- [x] 
- [x] DB: 
	- [x] Ready to merge to INT
- [x] TEST on INT
- [x] MESSAGE Jan-Wynand: 

Hey Jan-Wynand. Ek neem aan jy is Afrikaans... indien nie - sorry - dan verander ek met ons volgende chat ⁠![Smile](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/20_f.png?v=v81)

Ek hoop jy het n wonderlikke Christmas gehad en lekker gerus!

Ek is besig om Justus se werk in te merge op INT sodat julle kan begin toets op dit.

Dis n end-point dat julle die channels kan kry vir jul werk op STM.

Ons story - wat ek merge - is STM-768

Sodra dit klaar is op INT (behoort nog vanoggend te wees) dan sal ek jou die client version nommer stuur...

Lekker een verder!


## TEST ONLY

Repo: MiX.DeviceConfig
On: DEV

Method: MobileUnitRepository.GetSelectedEventCameras

/groupIds/{groupId}/assetIds/event-cameras?authToken={authToken}
!! MobileUnitRepository.GetSelectedEventCameras
- [x] swagger
AssetId: 1330316129901838336
EventId: 769714021091545261

OTHER: GetSelectedEventCameras - "assets/{assetId}/events/{eventId}/event-cameras"
!! LibraryEventsRepository.GetLibraryEventCameras
- [x] swagger
GroupId: 6683530587170817171
EventId: -15027453309101142

Caching?
Invalidation

- [x] Comment

I have done two basic swagger tests to confirm the two end-points are working, which were mentioned above.

1) MobileUnitRepository.GetSelectedEventCameras
2) LibraryEventsRepository.GetLibraryEventCameras

Both worked.
Herewith the images from the swagger results.

xxxxxxxxxxxxx

I will ask Peter about the caching, invalidation of the caching and the best way forward as this was tested on DEV.




- [x] Comments

Hi Peter, 

I had a quick look at this work. It feels like I might be missing something. 

From what I can see Justus mentioned two different end-points in his comments:
1) One which accepts multiple asset ids to get the camera events
2) Another which accepts events in order to get camera events
So I will try to swagger test these.

However, he then also mentions Caching and with this he mentioned Invalidating it under certain circumstances.
From this it feels like I might need to test this somehow.

Just another point. It is currently only on DEV. So I will test it there.
With the above uncertainty I think we should make sure that we have tested everything before moving this to INT.
So if you give me the go ahead, I could try to move it to INT or ask someone else to do so.
Otherwise we could wait when Justus is back on the 13th?

Please let me know what you think, I decided to rather inform you of this.
If my concerns are invalid we could just go ahead and deploy to INT :-)

Cheers
