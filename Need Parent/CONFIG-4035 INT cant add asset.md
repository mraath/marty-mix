---
status: closed
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2023-11-13T07:55
---

# CONFIG-4035 INT cant add asset

Date: 2023-11-09 Time: 11:28
Parent:: ==xxxx==
Friend:: [[2023-11-09]]
JIRA:CONFIG-4035 INT cant add asset
[CONFIG-4035 REG: Error gets generated when saving new asset on INT. - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4035)

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

## Image learned from this issue

ADD IMAGE

## Move what you learned into the bigger picture

ADD IMAGE

## Shorter Summary



## Description

Issue-

Upon saving newly created asset an error gets generated. When you exit the page you will find that the asset has indeed been created. Tested on second too.

Error : 1458955208296587264

- LOG: https://app.logz.io/#/goto/87a0b899163094d520a41955b206c85f?switchToAccountId=157279

An unexpected error has occurred

==Unable to send update timezone message for all the assets.==FAILURE: Remote message for asset 1458955129215025152 not sent. MiX.Core.Retries.RetryLimitExceededException: The limit for retries has been exceeded. at MiX.Core.Retries.RetryStrategy.d__31`1.MoveNext() in D:\b\1\_work\1888\s\MiX.Core\Retries\RetryStrategy.cs:line 368 --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.Core.Clients.HttpRetries.d__13`1.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.Core.Clients.HttpRetries.d__10`1.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at MiX.DeviceConfig.Api.Client.Repositories.MobileUnitCommandsRepository.d__4.MoveNext() --- End of stack trace from previous location where exception was thrown --- at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw() at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task) at DynaMiX.Logic.AsyncResultExtension.ToSync[T](Task`1 task, Boolean configureAwait) in D:\b\4\_work\558\s\Logic\DynaMiX.Logic\AsyncResultExtension.cs:line 13 at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.CommandManager.SendCommandToMobileDevice(String authToken, Int64 organisationId, Command cmd, Int64 correlationId, Nullable`1 disSupportedUnit) in D:\b\4\_work\558\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\CommandManager.cs:line 212 at DynaMiX.Logic.ConfigAdmin.Integration.MobileUnitLevel.DeviceIntegrationManager.SendCommandToUpdateAssetTimezoneDeviation(String authToken, Int64 orgId, Double secondsBefore, Double secondsAfter, Double ctime, List`1 assetIds, String currentUser, Int64 correlationId, DSTOptionalFields dstOptionalFields) in D:\b\4\_work\558\s\Logic\DynaMiX.Logic\ConfigAdmin\Integration\MobileUnitLevel\DeviceIntegrationManager.cs:line 1320

![[CONFIG-4035 INT cant add asset Image.png | 400]]



## SR Meeting Notes

- [[A typical Comms error]]
- JUST search for the IMEI (eg. 564231767214156) in the LOG and then check the error eg. (POST /devices/==564231767214156==/_commands" failed_)

## Useful Comments from Jira


## Branches

- Config/MR/Feature/Template Jira Issue_INT_ORI
- ALWAYS merge INT back in before merging to DEV, then INT...

## Testing



## Follow the code path

### Log


### Data


### Code


## Final Findings for Jira

- 
