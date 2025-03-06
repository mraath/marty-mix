---
created: 2024-02-02T13:30
updated: 2024-02-02T13:35
---
- Tracy-Lee Fillmore10/19/23 7:16 PMHello 🙂 Anyone experienced this before when running DynaMiX locally... and know what the issue is / how to fix? 

![[Running Dymix API locally Tracy.png]]

- Ridhaa Hendricks10/19/23 8:44 PMEdited
    
    I have the same issue, haven't found a solution yet. If you build DynaMiX do you get a Postsharp error?
    
- Tracy-Lee Fillmore10/19/23 8:57 PMEtienne de Lange
- Etienne de Lange10/19/23 8:57 PM
    
    Yes I got the Postsharp error Ridhaa Hendricks, but only in the DynaMiX.Core.Tests project
    
- Ridhaa Hendricks10/19/23 9:02 PM
    
    Mine is in DynaMiX.Core
    
    ![👍](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/yes/default/20_f.png?v=v70)1 Like reaction.1
- I haven't found a solution yet
    
- Etienne de Lange10/19/23 9:02 PM
    
    This is the full error I get. Seems it can't compile the DLL for some reason
    
    #### Text
    
```txt
Event code: 3007 
Event message: A compilation error has occurred. 
Event time: 2023/10/19 15:01:30 
Event time (UTC): 2023/10/19 13:01:30 
Event ID: 12bbbc00976a4494818da42e27745068 
Event sequence: 3 
Event occurrence: 1 
Event detail code: 0 
 
Application information: 
    Application domain: /LM/W3SVC/1/ROOT/MiXFleet.UI-1-133421940896260202 
    Trust level: Full 
    Application Virtual Path: /MiXFleet.UI 
    Application Path: C:\Development\Azure DevOps\MiX.Fleet.UI\UI\ 
    Machine name: AFSTBWS117 
 
Process information: 
    Process ID: 15068 
    Process name: w3wp.exe 
    Account name: DEVELOPMENT\SRVCAPP 
 
Exception information: 
    Exception type: HttpCompileException 
    Exception message: (0): error CS1504: Source file 'c:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files\mixfleet.ui\cf9f6a03\f80ced7\App_global.asax.ypbb3swm.0.cs' could not be opened ('Unspecified error ')
   at System.Web.Compilation.AssemblyBuilder.Compile()
   at System.Web.Compilation.BuildProvidersCompiler.PerformBuild()
   at System.Web.Compilation.ApplicationBuildProvider.GetGlobalAsaxBuildResult(Boolean isPrecompiledApp)
   at System.Web.Compilation.BuildManager.CompileGlobalAsax()
   at System.Web.Compilation.BuildManager.EnsureTopLevelFilesCompiled()
   at System.Web.Compilation.BuildManager.CallAppInitializeMethod()
   at System.Web.Hosting.HostingEnvironment.Initialize(ApplicationManager appManager, IApplicationHost appHost, IConfigMapPathFactory configMapPathFactory, HostingEnvironmentParameters hostingParameters, PolicyLevel policyLevel, Exception appDomainCreationException)

 
 
Request information: 
    Request URL: http://localhost/MiXFleet.UI/ 
    Request path: /MiXFleet.UI/ 
    User host address: ::1 
    User:  
    Is authenticated: False 
    Authentication Type:  
    Thread account name: DEVELOPMENT\SRVCAPP 
 
Thread information: 
    Thread ID: 7 
    Thread account name: DEVELOPMENT\SRVCAPP 
    Is impersonating: False 
    Stack trace:    at System.Web.Compilation.AssemblyBuilder.Compile()
   at System.Web.Compilation.BuildProvidersCompiler.PerformBuild()
   at System.Web.Compilation.ApplicationBuildProvider.GetGlobalAsaxBuildResult(Boolean isPrecompiledApp)
   at System.Web.Compilation.BuildManager.CompileGlobalAsax()
   at System.Web.Compilation.BuildManager.EnsureTopLevelFilesCompiled()
   at System.Web.Compilation.BuildManager.CallAppInitializeMethod()
   at System.Web.Hosting.HostingEnvironment.Initialize(ApplicationManager appManager, IApplicationHost appHost, IConfigMapPathFactory configMapPathFactory, HostingEnvironmentParameters hostingParameters, PolicyLevel policyLevel, Exception appDomainCreationException)
 
 
Custom event details:
```

- Etienne de Lange10/19/23 9:25 PM
    
    Soooo after uninstalling my last Windows updates, my MiXFleet.UI site loads again  It was related to either KB5031354, KB5031900 or KB5031323
    
    ![😮](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/surprised/default/20_f.png?v=v16)1 Surprised reaction.1![😭](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/loudlycrying/default/20_f.png?v=v24)1 Loudly crying reaction.1![🙁](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/sad/default/20_f.png?v=v30)1 Sad reaction.1
- Etienne de Lange10/19/23 9:36 PM
    
    Bare in mind this is on Windows 11
    
    ![👍](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/yes/default/20_f.png?v=v70)1 Like reaction.1
- Ridhaa Hendricks10/19/23 10:05 PMMine works now too, thank you very much. I broke my brain trying to figure it out. 
- Etienne de Lange10/19/23 10:05 PM
    
    What was wrong in your case Ridhaa Hendricks? Also Windows updates?
    
- Ridhaa Hendricks10/19/23 10:06 PM
    
    Yes, windows update **KB5031354**
    
    ![👍](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/yes/default/20_f.png?v=v70)1 Like reaction.1
- Etienne de Lange10/19/23 10:06 PM
    
    My brain is also a little broken at the moment
    
    ![👵](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/gran/default/20_f.png?v=v58)2 Dancing gran reactions.2
- October 20, 2023Rudolf Du Toit10/20/23 3:36 PMRIdhaa also on Windows 11. Seems to be OK on 10. Hopefully a bad update that MS will patch
- Chad Singlee10/20/23 7:07 PM
    
    I have made a fix for this. Please pull the latest integration branch.
    
    ![❤️](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/heart/default/20_f.png?v=v34)3 Heart reactions.3
- Tracy-Lee Fillmore10/20/23 8:02 PMChad Singlee are you on Windows 11? The latest update seems to break again on Etienne de Lange's machine...
- Chad Singlee10/20/23 8:03 PM
    
    I am windows 11. Is he Windows 10?
    
- Etienne de Lange10/20/23 8:03 PM
    
    Windows 11 too. I can try again
    
- Tracy-Lee Fillmore10/20/23 8:14 PMNew issue after pulling latest

![[Running Dymix API locally-1.png]]

- Etienne de Lange10/20/23 8:14 PM
    
    Yeah this is what I was getting also
    
- Chad Singlee10/20/23 8:14 PM
    
    Having a look
    
    ![👍](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/yes/default/20_f.png?v=v70)1 Like reaction.1
- Ridhaa Hendricks10/20/23 8:15 PM
    
    Mine works with the latest Integration pull and build but I unloaded DynaMiX.Core.Tests
    
- Chad Singlee10/20/23 8:29 PM
    
    Please pull latest again
    
    ![❤️](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/heart/default/20_f.png?v=v34)1 Heart reaction.1
- Tracy-Lee Fillmore10/20/23 8:31 PMIt's working againThanks!![👍](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/yes/default/20_f.png?v=v70)1 Like reaction.1
- Etienne de Lange10/20/23 8:32 PMNow I just need to install that Windows update and then test again
- Ridhaa Hendricks10/20/23 8:34 PM
    
    Mine works still with latest as well, thank you.
    
    ![❤️](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/heart/default/20_f.png?v=v34)1 Heart reaction.1
- Etienne de Lange10/20/23 8:40 PM
    
    And mine works after installing the latest Windows updates, lekker! Thanks Chad Singlee
    
    ![🥳](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/party/default/20_f.png?v=v18)3 Party reactions.3
- Eddie Oosthuizen10/20/23 8:41 PMThanks Chad Singlee!
- Ridhaa Hendricks10/20/23 8:41 PM
    
    Thanks Chad Singlee
    

has context menuParagraph