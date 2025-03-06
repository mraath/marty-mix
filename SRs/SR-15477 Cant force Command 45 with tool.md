---
status: closed
date: 2023-06-05
comment: 
priority: 8
---

# SR-15477 Cant force Command 45 with tool

Date: 2023-06-05 Time: 07:45
Parent:: [[Command 45]]
Friend:: [[2023-06-05]]
JIRA:SR-15477 Cant force Command 45 with tool
[SR-15476 Command 45 Update asset timezone deviation not initiated when moving vehicle between sites from assets page - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-15476)

## Branch

- xxxxxxxxxxxxxxxxxxxxxxxxx.INT.ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## PRs

- 

## Description
- **Pepsico-SSF**
- 3844132299104440361
- 

## Notes

I had a look at the 2nd and 3rd of June.
I saw a few Service Unavailable issues...
For both the DeviceConfig API and Comms
If Comms is down commands will definitely not be sent

Paul mentioned that things seem to be back to normal
Could you please confirm this?

I had a look at the tool and can confirm that for the mentioned org the commands went through.
Please also note, sometimes when it says "to check the API logs and that not all commands are being sent" it could be 100% correct, because when the unit doesn't have a Remote Command connected, it will not send. This will result in the above message, but it is doing exactly what it should.

I will attach the video as proof here:
[Command 45 Sent.mp4 (sharepoint.com)](https://mixtelematics-my.sharepoint.com/personal/marthinus_raath_mixtelematics_com/_layouts/15/stream.aspx?id=%2Fpersonal%2Fmarthinus%5Fraath%5Fmixtelematics%5Fcom%2FDocuments%2FVideos%2FCommand%2045%20Sent%2Emp4&ga=1)


## Possible cause


I only had a look at the 2nd of June.

Early in the morning the service wasn't available, this would definitely cause issues.

![image](blob:https://teams.microsoft.com/d801c2ec-86a7-4924-a586-0602144b9a36)

A bit later the day it complained about timeouts. This would be, it tried to access the end-point, but couldn't.

This could be due to the deadlock mentioned.

![image](blob:https://teams.microsoft.com/5787d71d-44f9-435c-9255-23388614c189)

Then later the day, it had a typical issue.

This just shows that the unit you tried to send the command to doesn't have the ability to receive commands.

They just need to attach it to the correct line.

![image](blob:https://teams.microsoft.com/afa76fac-580f-4d4e-9c83-85bc7e6dc7d6)

Based on the above, it would make send for SR-15476 to have occurred.

Please note I couldn't see an exact time, but had a look at the day of the 2nd.

Please try again and close if this has been resolved.

From a message from Paul things seem to have been resolved.

### Possible strings to search for:
DaylightSavingAdjustment
Not all required logical devices connected
/commands\" failed. 404 - The requested resource could not be found
ServiceUnavailable
DST Manager: