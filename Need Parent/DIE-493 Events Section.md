Date: 2022-04-04 Time: 08:48
Status: #done
Friend: [[DIE-485 DI Config Asset config file]]
JIRA:DIE-493
[DIE-493 Recording Options - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/DIE-493)

# DIE-493 Recording Options

AssetConfigFileEventsSection
MobileUnit_GetMobileUnitConfigFileEvents.sql

## Test

I used this unit
[MiX Telematics - Configuration groups](http://localhost/MiXFleet/#/config-admin/configuration-groups/asset/events?assetId=1086046864838615040)
assetId=1086046864838615040

## Return values

IsEnabled,
[Description],
EventType,
[Delay],
Video,
StartOdometer,
EndOdometer,
StartPosition,
EndPosition,
Summary

## Learned

## Description
The following section, Asset Config File - Recording options, looks like this.

![[Pasted image 20220302103936.png]]

1) We will need to build up a stored proc which will get all the events on the template
2) It should also have all the recording settings included
3) The summary column is something Nicole has a good idea where we can get it from, we will then add it to this stored proc.
## Code sections

## Files

## Resources

## Notes

