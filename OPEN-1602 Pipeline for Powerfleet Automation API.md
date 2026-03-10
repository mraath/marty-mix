---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2026-03-10T09:52
---

# OPEN-1602 Pipeline for Powerfleet Automation API

Date: 2026-02-16 Time: 15:30
Parent:: ==xxxx==
Friend:: [[2026-02-16]]
JIRA:OPEN-1602 Pipeline for Powerfleet Automation API
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-1602)

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

## Description


## CODE

## SP 2

## Branch

> Branch: Config/MR/Feature/OPEN-1602 Pipeline for Powerfleet Automation API.INT

## PR

- [ ] OPEN-1602 Pipeline for Powerfleet Automation API > DEV

## AWS

https://automation-api.dev.mixtelematics.com/swagger/index.html


## Payload DEV

```
{
    "InstallationDateCompleted": "2024-02-27",
    "DriveMateConnected": false,
    "IridiumConnected": false,
    "RoviConnected": false,
    "DtcoConnected": false,
    "VideoConnected": false,
    "CanConnected": false,
    "CaseNumber": "12345",
    "GroupId": "4036779219063094058",
    "AssetId": "1662203632230096896",
    "DeviceType": "MIX4000",
    "Odometer": 324234,
    "FirmwareVersion": "11111",
    "UniqueIdentifier": "846516546515646"
}
```

## PAYLOAD INT

```
{
    "InstallationDateCompleted": "2024-02-26",
    "DriveMateConnected": false,
    "IridiumConnected": false,
    "RoviConnected": false,
    "DtcoConnected": false,
    "VideoConnected": false,
    "CanConnected": false,
    "CaseNumber": "12345",
    "GroupId": "6288350534931411179",
    "AssetId": "1738024213057519616",
    "DeviceType": "MIX4000",
    "FirmwareVersion": "11111",
    "Odometer": 12345,
    "UniqueIdentifier": "359316077041140"
}
```

^9265af


```
In the Automation UI... FOr both the Asset and MAtrix view. So basically - say the diff is in a Grandparent > Parent > Child > Field Value, then please show the Grandparent Description > Parent Description > Child Description > Field Description Does this make sense? But display of This Description should make sense and that we could easily change the look and feel. I think for now display it like this: Grandparent Description: Parent Description: Child Description: Field Description (Also if it is nested deeper - just keep doing the same logic)
```

