---
created: 2025-02-21T07:44
updated: 2025-02-21T08:48
---
## The Issue

While working on OE-543, we saw that not all assets were moving to the config group.
Long story short, in the Config.API an error was being swallowed up.
This is the typical error we get:

> System.InvalidOperationException: 'A second operation was started on this context instance before a previous operation completed. This is usually caused by different threads concurrently using the same instance of DbContext. For more information on how to avoid threading issues with DbContext, see https://go.microsoft.com/fwlink/?linkid=2097913.'

![[OE-543 Move Assets Error Multiple Threads error.png]]

## Findings

The code where this happens, we use a lot of Entity Frameworks and DbContext.
We found that EF doesn't play too nicely with threads and fixing this up is not the best way forward.
We will move away from EF, as we recently started making all calls async.

## The Interim fix

We will not allow more than **one asset** at a time to be moved.
In future we will allow this again once the below has been implemented.

## The Future Plan

In the **UpdateAssetConfigGroupAsync** method, we will no longer call the EF **GetMobileUnitAggregate** and **GetMobileDeviceTemplate**.
We will write new stored procs to return only the values we need further down in this method.
	We will need the basic mu values, properties (to do the device enabled compare logic) and template.
	We will then also roll it out to other areas where we call GetMobileUnitAggregate

![[DbContext Multithread Issue Code area to change.png]]


## Techdebt

[[CONFIG-4604] DbContext Multithread Issue - Jira](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4604)


