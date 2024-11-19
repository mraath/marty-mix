---
created: 2024-11-06T16:19
updated: 2024-11-06T16:41
---

Lutfi: 
I have a quick question man... we have a customer struggling with PMU
Windows keeps on killing the app
It has the latest C++ installed and is running 4.8 .NetFramework
This is from the Event Viewer Logs

```log
Application: MiX.PlugMangment.WinUI.exe
Framework Version: v4.0.30319
Description: The process was terminated due to an unhandled exception.
Exception Info: System.AccessViolationException
   at <Module>.OpenUSBPortAct(SByte*)
   at <Module>.startDlmUsbPort()
   at <Module>.CDmiWrapper.{ctor}(CDmiWrapper*, dmi.Dmi)
   at dmi.Dmi..ctor()
   at MiX.Plugs.Lib.Concrete.DownloadModuleWorker..ctor()
   at MiX.Plugs.Lib.Concrete.DownloadModuleWorker.get_Instance()
   at MiX.PlugMangment.WinUI.PlugControls.I2C.PlugInformation+<>c__DisplayClass38_0.<ReadPlugInfo>b__0()
   at System.Threading.Tasks.Task.InnerInvoke()
   at System.Threading.Tasks.Task.Execute()
   at System.Threading.Tasks.Task.ExecutionContextCallback(System.Object)
   at System.Threading.ExecutionContext.RunInternal(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
   at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(System.Threading.Tasks.Task ByRef)
   at System.Threading.Tasks.Task.ExecuteEntry(Boolean)
   at System.Threading.Tasks.Task.System.Threading.IThreadPoolWorkItem.ExecuteWorkItem()
   at System.Threading.ThreadPoolWorkQueue.Dispatch()
   at System.Threading._ThreadPoolWaitCallback.PerformWaitCallback()
```

So it's clear this is an issue with Windows and not the app... just thought maybe you would know what the missing dependencies are to get the app to work

We've had this before a few years back when Windows did an update and the fix was to install the latest version .NetFramework and VC Redis C++, but Windows is still killing the app
 
This is the other part of the error in the Event Viewer Logs

```log
Faulting application name: MiX.PlugMangment.WinUI.exe, version: 22.12.8249.15931, time stamp: 0x62e8c957
Faulting module name: unknown, version: 0.0.0.0, time stamp: 0x00000000
Exception code: 0xc0000005
Fault offset: 0x00000000
Faulting process id: 0x5a74
Faulting application start time: 0x01db30184cebdea3
Faulting application path: C:\MiX Telematics\Plug Management Utility\MiX.PlugMangment.WinUI.exe
Faulting module path: unknown
Report Id: 99eb23ed-4efd-4303-8793-b744a4562787
Faulting package full name: 
Faulting package-relative application ID:
```

I asked them to:

OK - then I guess it could be that installing a .Net SDK (old enough) could help
I had something like that on another app
Else - maybe uninstall it and  reinstall it
I think there were 2 ways?
MSI and exe?
Cant recall all of it - but maybe try that
Also - if it works somewhere else - maybe copy the directory over to this PC
The .NEt will still give an issue potentially, but at least then we know the files for the app is OK

## Log file

For both this issue and the other one (not allowing user info to be typed in)
I see there is a log file (potentially in the installation path)
Could you look for the log file (might be in a Logs subfolder)
Let me know if it sheds any light on this

