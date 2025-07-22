---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-07-22T10:02
---

# ETS-2241 Event Video Intermittent

Date: 2025-07-22 Time: 09:40
Parent:: ==xxxx==
Friend:: [[2025-07-22]]
JIRA:ETS-2241 Event Video Intermittent
[JIRA](https://powerfleet.atlassian.net/browse/ETS-2241)


## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Shorter Description

The dealer uses the Driver Logged On event to determine if the camera solution is working, however this event seems to trigger intermittently. The event was previously set to look at the Current Driver ID > 0, however I noticed that a few trips are done without Drivers being Identified therefore I suggested they change the event to look at Current Driver ID >= 0  
The event also has a record delay of 2min to allow the video device to properly boot up and then record the event. The below example had it’s config change on 12/5, but the issue remains.  
  
AU  
Borg Manufacturing  
XQ64TG - P410 Prime Mover - PM4177 - 0458 817 349  
Vehicle ID: 493  
Mix4000  
IMEI: 354724643738666  
Firmware 4.16.3  
AssetId=1129801036349165568  
Event Name: Driver Logged On  
Event ID: -64  
EventId=8744388737109092687  
MVR2214 017226 Installed

## More

majority of the issues seen are with vehicles installed with MVR (**Cathexis**) units

### Paul

The event itself looks good to me. Looking at the size of the respective files in the extended config there does not seem to be any sizing constraints on the number of drivers present. That only leaves us with the action being request and that it is not always responding when triggers. I suspect the issue is that the Cathexis unit is not recording the video clips as expected.

Please check what values are recorded from the following events when the Driver Logged On event is not recording.

<!-- ΩMix Vision Error: Camera Fault -->  
<!-- ΩMix Vision Error: Not Awake -->  
<!-- ΩMix Vision Error: SD Card Error -->  
<!-- ΩMix Vision Error: Other -->

Ons of the above should record with an error number which we can then use to establish the MVR issue.

### Riaan

Doing some testing by changing the event logic. No MVR errors on the system, which was confirmed with the Cathexis team.
Hi @William King the video request are returned with not being available. I am doing test on a device in AU and will update the ticket tomorrow
The test done on the below mentioned shows the event triggering as per the setup (First screenshot), however we still don’t get the video events recording. None of the previously DI events mentioned by Paul triggers. I have also checked the Cathexis platform and that shows no errors. When checking the MVR backend the footage is available (See second screenshot)

Borg manufacturing  
Mix4000  
ID: 493  
AssetId=1129801036349165568  
Event Name: Driver Logged On  
Event ID: -64  
EventId=8744388737109092687  
Example Date: 04/07/2025 12:32PM (UTC +10)  
Attached the resource data for the day and no Event VideoKey is seen. Please investigate

![image-20250707-120018.png](blob:https://powerfleet.atlassian.net/aea65ce1-68c8-47a5-8a0d-67389a929193#media-blob-url=true&id=95ee6c5d-d365-49e5-8d04-0c3a773c94bb&collection=&contextId=460891&mimeType=image%2Fpng&name=image-20250707-120018.png&size=116937&width=1211&height=919&alt=image-20250707-120018.png)

![image-20250707-121246.png](blob:https://powerfleet.atlassian.net/fb525a17-4e15-4226-8fe1-9c50e6b39897#media-blob-url=true&id=7decb2b3-0553-4732-99df-3ab7e791ff1b&collection=&contextId=460891&mimeType=image%2Fpng&name=image-20250707-121246.png&size=84574&width=1745&height=464&alt=image-20250707-121246.png)

PS. The Cathexis team has also looked at the logs of this vehicle and there is nothing wrong.

### Jako

Hi @Riaan Serfontein  
I am not sure this should be with the VisionAI Team.  
I have checked the logs and our Video database, there is no event with that Id or TimeStamp for this unit.  
I could also not find the EventId in the json file you attached.  
I can see that the request event, Driver Logged On, was created in ResourceData.Events with EventId `3457068752545768890` however, the HasMedia flag is set to false.  
We never received a video request for this event. Lightning will have to investigate as to why they are not sending requests for these EventTypes.  
The EventTypeId for this is `-7507675202538861248` I can see that this unit has never received a video request for this EventType.

### Martin Lotter

