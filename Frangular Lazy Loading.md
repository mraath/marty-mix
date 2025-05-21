---
created: 2025-05-21T16:39
updated: 2025-05-21T16:46
---
> [!Info]
We have a Grid for the Config Groups BETA page that took a LONG time to load.
We then broke things up to first load the basic info that would take like a second.
After this we make more async calls to the BE to get the other, longer taking, columns' values.
We also need to visually indicate that this is happening to the user.
Once done we should display a value.

In order to do this we need a few things

## BE

A client method of sorts to get the data async, from the BE, for the UI to be displayed.
Usually this will call some sort of DB Stored Proc, which will hopefully be optimised.

## FR UI HTML file



## FR UI TS file


