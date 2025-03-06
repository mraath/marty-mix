---
status: closed
date: 2023-01-26
comment: 
priority: 8
---

Date: 2023-01-26 Time: 07:20
Parent:: [[Events]]
Friend:: [[2023-01-26]]
JIRA:SR-14341 Active vs passive events
[SR-14341 Email Notification received but no event recorded on trip timeline - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14341)

# SR-14341 Active vs passive events
Issue: Notification received but no event recorded on trip timeline

## Testing

## Next Steps

## Story Description

- MiX4K
- Event description:    PTRM - Over speeding >84km/h | Alarm
- Event legacy ID       : -89 -- -88
- EventId: 65447 (event type 5 code) -- 65448
- Event ID              : 3964795786126502728
- templateEventId=7020447867769650076 & assetId=893219742333599744
- eventid=-972647624477123152 & templateId=4638106394649744933

## Findings

### Paul feedback

![[image-20230126-061719.png]]

[14:14] Paul Roux

Ek gaan daai op die JIRA sit. Dit is moontlik vir die active om te record sonder die passive, weens die passive wat nodig het vir die kondisie om vir 10 sekondes waar te bly voor dit enigsins begin om spoed waar te neem. Sal ook by sit dat support welkom is om hierdie op T-shirts te print want dit is die laaste keer wat config aan hulle gaan verduidelik die verskil tussen active en passive ![😉](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/wink/default/20_f.png "Wink")  

[14:17] Marthinus Raath
So - hoe weet ek die boonste een is passivez
En die onderste een active?
Wat onderskei hulle - sorry - eerste keer wat ek die vrae het ![😄](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/grinningfacewithsmilingeyes/default/20_f.png "Grinning face with smiling eyes") 

[14:21] Paul Roux
Baie goeie vraag, dit reël is eenvoudig - aan die begin was daar net passive recording. In die dae voor GPRS modems toe hulle nog trips aan die einde van die dag met plugs gaan aflaai het. Dit begin met : Action Type="RecordNotification"
Later van tyd toe die modems by kom het hulle active events moontlik gemaak en dit is altyd via 'n DDR call na die modem DDCall DDriver="28" DFunc="6" DFuncAct="8"
Daar is ook die SAT modem wat werk via DDR 41 (ook active event).

### Next Step

From the below files I can confirm that the config has this event and it recorded active events in the UDP file.
Next I want to figure out:
- why the event didn't record as passive and 
- if it is setup correctly
I will speak to Paul in our team to figure out why this is not recording as passive.

### The config xml

```xml
<!--Conditional[IsDeviceProperty] Object[System.Logical.HoursOfService:HOSStatusChange=1] GivenValue[1] FoundValue[] Result[False]-->
  <!--Conditional[IsBitAllocated] Object[TERMINAL_MESSAGE_PRESENT] Result[False]-->
  <!-- PTRM - Over speeding >84km/h | Alarm -->
  <Conditions>
    <EventId>65447</EventId>
    <!-- Road speed -->
    <Input>Speed</Input>
    <Op>&gt;</Op>
    <Const>84</Const>
  </Conditions>
  <Actions>
    <Action Type="RecordNotification" Delay="10" React="True" StartTime="true" EndTime="true" StartOdo="true" EndOdo="true" ValueType="Value" ValueFunc="Max" MSBByte="3" WordLength="0">
      <Input>Speed</Input>
    </Action>
    <Action Type="SetBit" Delay="10" React="Pos">STORE_POSITION</Action>
    <Action Type="SetBit" Delay="10" React="Pos">RECORD_VIDEO</Action>
    <Action Type="ClearBit" Delay="0" Invert="true" React="True">CONDITION_RECORDING</Action>
    <Action Type="ClearBit" Delay="0" React="True">CONDITION_RECORDING</Action>
    <Action Type="SetBit" Delay="10" React="True">CONDITION_RECORDING</Action>
    <Action Type="SetBit" Delay="1" React="True">ALARM_ON</Action>
    <Action Type="SetBit" Delay="1" React="Pos">CRITICAL_MESSAGE</Action>
    <Action Type="DDCallMethodInput" Delay="1" React="Pos">
      <DDCall DDriver="28" DFunc="6" DFuncAct="8">
        <Input>Speed</Input>
        <B>65447</B>
        <C>0xFFF4</C>
      </DDCall>
    </Action>
    <Action Type="ClearBit" Delay="0" Invert="true" React="True">EVENT_ACTIVE_TICK</Action>
    <Action Type="ClearBit" Delay="0" React="True">EVENT_ACTIVE_TICK</Action>
    <Action Type="SetBit" Delay="1" React="True">EVENT_ACTIVE_TICK</Action>
    <Action Type="SetBit" Delay="1" React="True">ACTIVE_TRACKING_IN_PROGRESS</Action>
  </Actions>
  <Conditions>
    <Input>BitValueInLong</Input>
    <InputExt>CONDITION_RECORDING</InputExt>
  </Conditions>
  <Actions>
    <Action Type="SetBit" Delay="0" React="Neg">STORE_POSITION</Action>
  </Actions>
  <Conditions>
    <Input>BitValueInLong</Input>
    <InputExt>EVENT_ACTIVE_TICK</InputExt>
    <Op>&amp;&amp;</Op>
    <Op>(</Op>
    <Input>StorageLongs</Input>
    <InputExt>ACTIVE_TRACK_TICK_COUNT</InputExt>
    <Op>&lt;</Op>
    <Const>2</Const>
    <Op>||</Op>
    <Input>StorageLongs</Input>
    <InputExt>ACTIVE_TRACK_TICK_COUNT</InputExt>
    <Op>&gt;</Op>
    <Const>15</Const>
    <Op>)</Op>
  </Conditions>
  <Actions>
    <Action Type="DDCallMethodDefault" Delay="0" React="True">
      <DDCall DDriver="12" DFunc="4" DFuncAct="1">
        <A>15</A>
        <B>ACTIVE_TRACK_TICK_COUNT</B>
      </DDCall>
    </Action>
  </Actions>
```

### The ConfigTextSummary

```txt
Event description     : PTRM - Over speeding >84km/h | Alarm
Event ID              : 3964795786126502728
Event legacy ID       : -89
Condition
  Road speed > 84km/h 
Action
Return parameter      : Road speed
Return value          : Maximum
Record event          : Delay=10
                        Type=Detailed
                        Start odometer
                        End odometer
                        Start position
                        End position
                        Record video
Sound buzzer          : Delay=1
                        Type=WhileTrue
                        Allow Override=False
Send active message   : Delay=1
                        Priority=Critical
                        Send when condition becomes true
                        Send position
Start active tracking : Delay=1
                        Interval=15
```

### In the UDP

```txt
***FmActiveEventMessage2***
Delayed: 16 seconds
Type5Code: 65447
Legacy Event Id: -89
Event name: Unknown
DriverId: 0
SystemOdometer: 965637012
SystemSpeed: 87500
GenericValue: 87
EngineMode: Disarmed
PositionDateTime: 2022/12/28 09:16:36
TimestampDelayed: 2453
Longitude: 27,060972629115
Latitude: -14,9909682758152
Velocity: 0
Altitude: 0
Heading: 98,55835
NoOfSatellites: 12
Hdop: 2550
DistanceMovedSinceReading: 0

***FmActiveEventMessage2***
Delayed: 16 seconds
Type5Code: 65448
Legacy Event Id: -88
Event name: Unknown
DriverId: 0
SystemOdometer: 965637012
SystemSpeed: 87500
GenericValue: 87
EngineMode: Disarmed
PositionDateTime: 2022/12/28 09:16:36
TimestampDelayed: 2453
Longitude: 27,060972629115
Latitude: -14,9909682758152
Velocity: 0
Altitude: 0
Heading: 98,55835
NoOfSatellites: 12
Hdop: 2550
DistanceMovedSinceReading: 0

```

The UDP shows the event is **recorded as active**, but ==not as passive==. 
Passive events are displayed on the ==timeline==. 
Then assign to the Config team to investigate why the passive event did not record.

## Image

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 22.17 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14341 Active vs passive events.xx.xx.ORI
