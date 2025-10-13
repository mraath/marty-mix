---
created: 2025-10-13T14:48
updated: 2025-10-13T14:48
---
Zeshan asked if I can take you through fixing parameter issue at deployment. I might not make this meeting tomorrow since I am technically on leave. But anyways. 

It is a pretty manual process of looking up the offending parameter in the library, finding it's name/key and then checking what the value is for it in the -1 library (DC library). Then you update the offending parameter to be like the DC parameter. Sometimes this is not possible because some parameters are NULL at DC level because they can, like CAN scripts, use any available legacy parameter ID in the org they are made available.

Today I went back and looked at the parameters the OLTP wanted to insert. (On DUB, server SQLZEROVS\SQLZERO, database DeviceConfiguration)

SQL

```
SELECT * FROM [DeviceConfiguration].[library].[Parameters]  where DateUpdated < '2025-10-08 23:15:00 +02:00' and DateUpdated > '2025-10-08 21:15:00 +02:00'  and UserName = 'System Load Verification'
```

It would be great if someone can spend some time looking into why the OLTP did this. If we can determine why it does these we can take actions before deployments to fix any such issues before they happen at crunch time.

|                     |                      |            |              |                   |                                              |              |               |                            |                          |
| ------------------- | -------------------- | ---------- | ------------ | ----------------- | -------------------------------------------- | ------------ | ------------- | -------------------------- | ------------------------ |
| LibraryParameterKey | LibraryParameterId   | LibraryKey | ParameterKey | LegacyParameterId | Description                                  | DisplayUnits | IsFuelCounter | DateUpdated                | UserName                 |
| 1338213             | 6894684624290610000  | 478        | 1315         | 32709             | FM CAN: Brake Pedal State                    |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338214             | 5431485324317880000  | 478        | 1317         | 10209             | FM CAN: Park Brake State                     |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338215             | -6362512917459560000 | 478        | 1320         | 10212             | FM CAN: Gear Box Drive Mode                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338216             | -4342761785987950000 | 478        | 5409         | 20182             | FM CAN: Throttle Pedal Angle                 | %            | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338217             | 5666562854534550000  | 478        | 5508         | 21701             | FM CAN: Driver Door 1                        | NULL         | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338218             | -2637628017279620000 | 478        | 5666         | 20371             | FM CAN: Trunk Door 1                         |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338219             | 657022955734385000   | 478        | 5668         | 20373             | FM CAN: Left Turn Indicator                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338220             | 5088980414346080000  | 478        | 5669         | 21702             | FM CAN: Passenger Door 1                     | NULL         | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338221             | 6606513309915980000  | 478        | 5671         | 20376             | FM CAN: Right Turn Indicator                 |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338222             | 5821443813467170000  | 478        | 5696         | 20399             | FM CAN: Clutch Drive Status"                 |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338223             | 9005927102381170000  | 478        | 5720         | 20408             | FM CAN: Gear Box Mode Reverse                |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338224             | 4141598087081830000  | 478        | 5838         | 20477             | FM CAN: Gear Box Mode Drive                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338225             | -6066945532382950000 | 478        | 6676         | 21076             | FM CAN: Rear Left Door                       |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338226             | -6780652170860080000 | 478        | 6677         | 21077             | FM CAN: Rear Right Door                      |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338227             | 8689012964914400000  | 478        | 6693         | 21079             | FM CAN: Gear Box Mode Neutral                |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338228             | 2327600928929230000  | 478        | 6706         | 21089             | FM CAN: Driver Back Seat Belt                |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338229             | 4307400119667710000  | 478        | 6707         | 21090             | FM CAN: Passenger Back Seat Belt             |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338230             | -8960354265525220000 | 478        | 6721         | 21152             | Odo Unit - UP                                |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338231             | 6676456611590820000  | 478        | 6833         | 21260             | FM CAN: Cruise Control State                 |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338232             | -3435849997336470000 | 478        | 6837         | 21264             | FM CAN: Hazard light status                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338233             | 6639361930706740000  | 478        | 6845         | 21272             | FM CAN: Dimmed light status                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338234             | -4844939540722270000 | 478        | 6846         | 21273             | FM CAN: Gear Box Mode Park                   |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338235             | -13574463353298000   | 478        | 6992         | 21390             | FM CAN: Gear Box Mode Sport                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338236             | 6157029911101180000  | 478        | 6993         | 21391             | FM CAN: High beam light status               |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338237             | 2378129450442280000  | 1323       | 1319         | 10211             | FM CAN: Gear Box Drive Gear                  |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338238             | 4564523624149090000  | 1323       | 3590         | 20161             | FM CAN Engine Torque                         | %            | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338239             | 4544673945790170000  | 1323       | 5694         | 20397             | FM CAN: Service Brake Air Pressure Circuit 1 | kPa          | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338240             | 5665691739557510000  | 1323       | 5695         | 20398             | FM CAN: Service Brake Air Pressure Circuit 2 | kPa          | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338241             | 5224525508291200000  | 1323       | 5696         | 20399             | FM CAN: Clutch Drive Status"                 |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338242             | -3539185081075860000 | 1323       | 5697         | 20400             | FM CAN: Clutch pedal position"               | %            | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338243             | 75333941361289400    | 1323       | 5699         | 20402             | FM CAN: AdBlue 1 tank level                  | %            | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338244             | 3430581286853870000  | 1323       | 5700         | 20403             | FM CAN: Parking brake switch                 |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
| 1338245             | -1599505495120780000 | 1323       | 5701         | 20404             | FM CAN: Top Brake"                           |              | 0             | 2025-10-08 23:04:06 +02:00 | System Load Verification |
