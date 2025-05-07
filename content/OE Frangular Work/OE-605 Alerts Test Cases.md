---
created: 2025-05-07T08:45
updated: 2025-05-07T16:36
---
## Introduction

While testing [[OE-605 Alerts Column logic Config Group]],  Unathi wanted some test data to look into this issues.
I told him I have some SQL scripts which could help.
The idea with this is to give him some SQL scripts which he could then use to test the functionality.

## Alerts

There are four different alert. All of these needs to be tested:

1) Assets in config Upload requested state for more than 5 days
2) Assets in FW upload requested state for more than 3 days
3) Preferred FW version that is older than 2 releases back. Jacques van Wyk will have more info?
4) Assets that have events with a status of “Events not monitored - missing parameters”

(For the look, feel and functionality around this, check the original story. This is purely to find test data)
## Steps

I think I would take the following steps to use this as test data:

1) Get the Alert's test data
2) Look in the UI if you can confirm the data
3) Test the Asset Alert for this
4) Test this Asset's Config Group for this

## Scripts to get Test Data

Please adjust these scripts for your situation. These are the scripts I used.

- **Alert 1 and 2** script: [[OE-614 Alerts 1_2 Get DATA.sql]]

Eg. of results
![[OE-605 Alerts 1 and 2.png]]


- **Alert 3** script: [[OE-614 Alerts 3 Get DATA.sql]]

Eg. of results
![[OE-605 Alerts 3 Data eg.png]]


- **Alert 4** script: [[OE-614 Alert 4 Get DATA.sql]]

Eg. of results
![[OE-605 Alerts Test Cases Alert 4 Get Data.png]]

You could then test the above for the **individual MobileUnit** with this script: [[OE-614 Alert 4 Individual Info Test.sql]]



