---
created: 2023-09-22T09:12
updated: 2024-10-17T08:45
---

## Intro

Sometimes we need to use or test a new [[feature]].
In the case where it causes issues, we need to **switch back** to the old way of doing things.
The best way to do this is with the use of a config setting.

## Lightning Settings - new Config API

- [CONFIG-4347 Check feasibility and process of using Lightning's configuration Api for retrieving settings - 1 day - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4347?focusedCommentId=49292)
- 

## Code example of such a setting

### Config

```xml
<?xml version="1.0" encoding="utf-8"?>
...
<configuration>
  ...
  <dynamix>
    <dynamix.config_admin ... RunDaylightSavingsCommand="true" ... />
```
eg. C:\Projects\DynaMiX.Backend\API\DynaMiX.API\web.config

### Transform

```xml
...
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
	<dynamix>
		...
		<dynamix.config_admin ...
			RunDaylightSavingsCommand="true" ...
			/>
```
eg. C:\Projects\DynaMiX.Backend\.config\web.Debug.config

### Configuration Settings Manager

```c#
using System;
using System.Configuration;

namespace DynaMiX.Common.ConfigAdmin
{
	public class ConfigAdminSettings : ConfigurationSection
	{
		[ConfigurationProperty("RunDaylightSavingsCommand", IsRequired = false, DefaultValue = true)]
		public bool RunDaylightSavingsCommand
		{
			get { return (bool)base["RunDaylightSavingsCommand"]; }
		}
```
eg. C:\Projects\DynaMiX.Backend\Common\DynaMiX.Common\ConfigAdmin\ConfigAdminSettings.cs
### Code

```c#
public static void RunAdjustments()
{
	...
	var runDaylightSavingsCommand = ConfigAdminSettings.Current.RunDaylightSavingsCommand;
	if (runDaylightSavingsCommand)
```
eg. C:\Projects\DynaMiX.Backend\Services\Daylight Saving Adjustment\DynaMiX.Services.DaylightSavingAdjustment\DaylightSavingAdjustmentService.cs


