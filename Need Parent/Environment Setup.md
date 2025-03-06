---
created: 2024-06-11T16:40
updated: 2024-06-11T16:40
---
[Skip to end of metadata](https://confluence.mixtelematics.com/pages/viewpage.action?spaceKey=DynaMiX&title=Environment+Setup#page-metadata-end)

- Created by [Rudolf du Toit](https://confluence.mixtelematics.com/display/~rudolfd) , last modified on [Jun 21, 2023](https://confluence.mixtelematics.com/pages/diffpagesbyversion.action?pageId=13600337&selectedPageVersions=76&selectedPageVersions=77 "Show changes")

[Go to start of metadata](https://confluence.mixtelematics.com/pages/viewpage.action?spaceKey=DynaMiX&title=Environment+Setup#page-metadata-start)

**ISOs are on  \\dsstbsoftware\Software\**

  

|**OS Setup for AWS Workspaces:**|
|---|
|**  <br>First take note that AWS Workspaces are expensive to run and will therefor hibernate automatically after 1hr of inactivity.  <br>  <br>**1) Download and install the appropriate AWS Workspaces client on your personal PC or laptop here : [https://clients.amazonworkspaces.com/](https://clients.amazonworkspaces.com/)  <br>2) Register the workspace using the registration code you received via email or Teams.  <br>3) Login using your username without the domain. So instead of MIX\BobM, just uses BobM. The password is your MIX domain password provided via email or Teams.  <br>4) When using an AWS Workspace, you do not need to install any VPN software to connect to the MiX network. You will automatically have access to the Development and Integration environments (not UAT or production though, that is on a different domain).  <br>5) Install Office. Do this by opening a browser window to [portal.office365.com](http://portal.office365.com/) and login with your email address and domain account password. You can choose to install the Office desktop app by clicking on the "Install Office" dropdown and following the options.  <br>6) Open the Server Manager. Click on "Local Server" on the left. Turn IE Enhanced Security Configuration OFF for both Users and Administrators (otherwise you will have trouble signing into Visual Studio later).  <br>**It is recommended to set up 2 factor authentication by installing the Microsoft Authenticator app on your phone.**  <br><br>**Add Windows Features:**<br><br>1) Go to Turn Windows Features On or Off (in Programs and Features). The Server Manager will open. Click next until you get to Server Roles.  <br>2) Check Web Server and add the IIS Management Console.  <br>3) If you are installing SQL 2014 specifically, check .NET Framework 3.5. Not required for SQL 2016 and up. Local SQL is not required for general full stack development. Generally only if you are in a reporting/data systems team.  <br>4) Check Message Queuing.  <br>5) Expand the Message Queuing tree view and check Directory Service Integration.  <br>6) Click next to configure the Web Server Role Services.  <br>7) Expand Application Development and check .NET Extensibility 4.7 and click Add Features.  <br>8) Check ASP.NET4.7 and click Add Features.  <br>9) Check the WebSocket Protocol.  <br>10) Click Next and Install.  <br>11) Skip the next section for standalone desktops and continue with "IIS Setup"|

|**OS Setup for Desktops:**|
|---|
|1) If your desktop did not come pre-installed with Windows, install the latest Enterprise flavour of Windows.  <br>2) At the first sign in screen, there is no need to sign in with a Microsoft account. Select create a new account and then "Sign in without a Microsoft account". Don't bother entering your real name as the user account, you will get a new one when you are added to the domain.  <br>3) Depending on your version of Windows, disable the Windows Media Network Sharing Service (unless you want to share your music with everyone)  <br>4) Unless you are already on the MiX domain and have a valid username and password, don't bother customising the OS, your PC must be added to the domain which means you will get a new user profile.  <br>5) If you are not on the MiX domain yet, get MiX IT or Stephan Visagie to add you to the MIX domain.  <br>6) Log in with your MIX credentials. Now you can customise your OS.  <br>7) If you have a Dell, go to [support.dell.com](http://support.dell.com/) and search for your service tag (label on the PC/laptop). Download and install any drivers you think you will need. In general, download the Chipset and graphics drivers.  <br>8) Install Office. Do this by opening a browser window to [portal.office365.com](http://portal.office365.com/) and login with your email address and domain account password. You can choose to install the Office desktop app by clicking on the "Install Office" dropdown and following the options.  <br>**It is recommended to set up 2 factor authentication by installing the Microsoft Authenticator app on your phone.**  <br><br>**Add Windows Features:**<br><br>In addition to what is already checked:  <br>1) Go to Turn Windows Features On or Off (in Programs and Features).  <br>2) If you are installing SQL 2014 specifically, check .NET Framework 3.5. Not required for SQL 2016 and up.  Local SQL is not required for general full stack development. Generally only if you are in a reporting/data systems team.  <br>3) Check Internet Information Services. Keep the default settings. Don't use IIS Express because VS modifies the project files.  <br>4) Check IIS Management Console. Under Application Development Features, check .NET Extensibility 4.7, ASP.NET 4.7, ISAPI Extensions, ISAPI Filters.  <br>5) Check IIS Management Console. Under Common HTTP Features, check Static Content  <br>6) Check Microsoft Message Queue (MSMQ).  <br>7) Expand the MSMQ tree view and check MSMQ Active Directory Domain Services integration.|

**  
  
IIS Setup:**

1) Once the features have been added, open the IIS Manager.  
2) Go to the DefaultAppPool properties and add development\srvciis account details under "Identity". The password is "P4ssw0rd". You can also use your own domain account, but you must then remember to change the App pool password every time you change your domain password - otherwise the App pool will always be in a stopped state to prevent your account being locked.  

  
**GIT Setup:**

1.  Download and install the latest Git for Windows here : [https://git-scm.com/download/win](https://git-scm.com/download/win)
    1. NOTE: Make sure "Check out Windows, Commit Unix" line endings is checked.
    2. Keep the rest of the default settings checked (i.e. caching and git credential manager etc).
2. OPTIONAL: Download and install a Git GUI interface if you don't want to use the command line tools. Consider Tortoise Git :[https://tortoisegit.org/download/](https://tortoisegit.org/download/) or use SourceTree or Visual Studio's built-in Git tools.  
    Whichever Git client you use, make sure your Name and Email address is properly configured so that the commits you do are formatted correctly.

**  
IDE Setup:  
**

1. You can decide to use Visual Studio Code if you want, depending on the team you are in and their requirements.  
    [https://code.visualstudio.com/download](https://code.visualstudio.com/download)  
      
    For full framework development it is recommended to install Visual Studio. At the time of writing that is VS 2022.  
    [https://visualstudio.microsoft.com/vs/professional](https://visualstudio.microsoft.com/vs/professional)  
    Choose "Enterprise" if you have an Enterprise level VS subscription. Most likely it will be Professional.  
      
    Run the downloaded installer. Confirm that you are installing the correct version for your license. It should read "Installing - Visual Studio Professional"
2. For most common installations, choose "ASP.NET and web development", "Universal Windows Platform development", ".NET desktop development", "Data storage and processing"  
    Under "Individual Components" tab check all the .NET Framework **4.8** items and also ".NET Portable Library targeting pack" as well as TypeScript SDK  
    Under Data Storage And Processing, make sure SQL Server Data Tools is selected (SSDT).  
    
3. Click Install and make coffee
4. Set the VS shortcut to always start as Administrator, otherwise you will run into build issues **OR (thanks to Ross for this), just browse to C:\Windows\System32\inetsrv\config and click on the button to confirm permissions.  
    **To achieve that, do this:
    1. Browse to devenv.exe (C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE), right-click and select "Troubleshoot compatibility". Select "Troubleshoot program"
    2. Check "The program requires additional permissions"
    3. Click "Next", click "Test the program..."
    4. Wait for VS to launch.
    5. If it is the first time you are running VS, click sign-in and enter your email address (e.g. bob.morgan@mixtelematics.com) and your domain password.
    6. Close VS and click "Next"
    7. Select "Yes, save these settings for this program"
    8. Click "Close"
5. Once VS is open, look for any updates by clicking on the yellow flag top right.
6. Set tab spaces:
    1. Tools > Options > Text Editor > All Languages > Tabs
    2. Select Smart indenting. Set Tab size to 2, indenting to 2, and KEEP tabs.
    3. Tools > Options > Text Editor > T-SQL90 > Tabs
    4. Select Block indenting. Set Tab size to 2, indenting to 2, and INSERT SPACES.
7. Install Redis x64 ([https://github.com/MSOpenTech/redis/releases/](https://github.com/MSOpenTech/redis/releases/)) <<< **This should not be needed anymore even for local development. Install only if you really need this**
8. Setup NuGet.
    1. Open Visual Studio under TOOLS > NuGet Package Manager > Package Manager Settings set NuGet to automatically download packages.
    2. Under "Package Sources", add the MiX NuGet package source: Name: MiX Azure Path: [https://pkgs.dev.azure.com/MiXTelematics/Common/_packaging/Common/nuget/v3/index.json](https://pkgs.dev.azure.com/MiXTelematics/Common/_packaging/Common/nuget/v3/index.json)
9. Install AjaxMinifier. It is used by the Angular UI build process. ([https://github.com/microsoft/ajaxmin/releases/download/v5.14/Microsoft.Ajax.Minifier.v5.14.zip](https://github.com/microsoft/ajaxmin/releases/download/v5.14/Microsoft.Ajax.Minifier.v5.14.zip)), otherwise you won't be able to build the UI Framework. Extract and run AjaxMinSetup.
10. Install PostSharp:
    
    1. Previously PostSharp was installed automatically when you build the DynaMiX.Backend project via NuGet. This does not seem to be the case with VS 2015+.
        
    2. Download the PostSharp EXE here, **THIS SPECIFIC VERSION** (4.3.48): [https://www.postsharp.net/downloads/postsharp-4.3/v4.3.48](https://www.postsharp.net/downloads/postsharp-4.3/v4.3.38)
    3. Don't select the trial or pro license, select **PostSharp Express**. When asked if you don't want to try PostSharp Ultimate, select **No, thanks.**
11. Install the Powershell Tools for Visual Studio extension to support the automated deployment project types. Do this by going to the Extensions menu option and searching online for "powershell tools for VS 2022".
12. If you will be building the DynaMiX Backend, you **MUST** install the 2012 Visual C++ Redistributable Update 4 (64 bit version) - downloadable here: [http://www.microsoft.com/en-us/download/details.aspx?id=30679](http://www.microsoft.com/en-us/download/details.aspx?id=30679) (it HAS to be this version, not something newer or older)
13. Download and install the TypeScript 3.8 SDK : [https://marketplace.visualstudio.com/items?itemName=TypeScriptTeam.typescript-38rc](https://marketplace.visualstudio.com/items?itemName=TypeScriptTeam.typescript-38rc)
14. BUILD ORDER (Clone these projects in D:\Projects or C:\Projects):
    1. Clone the DynaMiX.UI.Framework GIT repo, switch to the master branch, open in Visual Studio and build.
    2. Clone the MiXFleet GIT repo, switch to the Integration branch, open in Visual Studio and build.
    3. Clone the DynaMiX.Backend GIT repo, switch to the Integration branch, open in Visual Studio and build.
15. OPTIONAL:
    1. ReSharper ([https://www.jetbrains.com/resharper/download/](https://www.jetbrains.com/resharper/download/)) (get a key from Russell Simmonds)
    2. For those that had a perpetual key for ReSharper 8, you can install the first version of ReSharper 9 only (9.0.0.0), filename: ReSharperAndToolsPacked01Update1_checked.exe

  

**ENVIRONMENT VARIABLES:  
**1) Add MSBUILD to your path. Open Advanced System Settings and edit the PATH variable. Add ;C:\Windows\Microsoft.NET\Framework64\v4.0.30319\  
2) If you have Visual Studio 2010 installed as well, add the following environment variable: "VisualStudioVersion" with value "11.0"

**CLONE REPOSITORIES:  
**The repositories to clone depends which team you are in. Your Team Lead should provide you with the repositories you need to clone.  
1) You can clone from within VS by clicking on Azure DevOps and signing in. Or if you prefer TortoiseGit or SourceTree, clone repositories using that instead.  
2) Clone the repository into C:\Projects\ (so you end up with C:\Projects\MiXFleet or C:\Projects\DynaMiX.Backend for example).  
3) If you are prompted for a username and password, enter your MiX email address and domain password.

  

**NODEJS (for UI unit tests) - THIS WILL CHANGE SOON BECAUSE OF ANGULAR 4:**  
1) Download and install NodeJS 64bit msi from [https://nodejs.org/download/](https://nodejs.org/download/)  
2) Install Karma. Open a command prompt and navigate to C:\Program Files\nodejs\  
3) npm install -g karma@0.12.31 -msvs_version=2015  (-msvs_version=2015 is only required if you only have VS2015 installed)  
4) npm install -g karma-jasmine@0.1.5 karma-cli@0.0.4 karma-chrome-launcher@0.1.7 karma-sourcemap-loader

The versions above has to be used. Using a version above 0.1.5 of karma-jasmine will result in all unit tests failing due to version incompatibilities between jasmine and Angular 1.0.6/8 which we are using.

  

**Local SQL Setup <<<< Just do steps 2 and 13. The full SQL installation is not needed anymore for general development:  
**~~1) Install SQL Server 2016 Developer Edition  
~~

- ~~Choose New SQL Server stand-alone installation~~
- ~~Select Database Engine Services~~
- ~~In SQL 2016 SQL management studio is no longer available and you have to install SQL Management Tools separately (SMSS-Setup-ENU.exe).~~
- ~~Check Windows AND SQL authentication modes (Mixed Mode authentication). Enter an "sa" password. Under Specify SQL administrators,~~ 
- ~~Click "Add Current User" to add your domain account.~~
- ~~If you like, click on the "Data Directories" tab and change the location of where the databases are created, i.e. D:\MSSQLDbs\~~

2) After installation, in Windows Services, set Distributed Transaction Coordinator to start automatically (delayed)  
~~3) Open SQL Management Studio. Connect to db (local). Right-click local DB, select properties. Click Memory tab and make max mem usage 1024MB.~~  
~~4) Expand "Security > Logins" and make sure your your domain user account is listed and that it has sysadmin rights.~~  
~~5) If you used DEVELOPMENT\SRVCIIS for the IIS DefaultAppPool login, add the DEVELOPMENT\SRVCIIS account as well and assign sysadmin rights.~~  
~~6) Get the DB backups and scripts (from \\dsstbisql01\Backups\DynaMiX\). If you don't have access, please ask Stephan Visagie.~~  
~~7) Edit the "Restore all.sql" file and change the SqlBackup path (where the .bak files are) and the target Data and Log path (where you want your databases to be restored to - your SQL data path).~~  
~~8) Open SQL management studio open the "Restore all.sql" script.  
9) Enter SQLCMD mode. Query -> SQLCMD Mode  
10) Execute the restore script.  
~~~~11) Open and execute Logins.sql.~~  
~~12) Open and execute Set CLR Enabled.sql.~~  
13) Setup MSDTC in Component services  

- Go to cmd and enter services.msc and right click on "Distributed Transaction Coordinator" and set startup type to Automatic (Delayed Start) and press start
- Go to Control panel -> Administrative Tools ->Component Services -> Component Services -> Open Computers -> My Computer -> Distributed Transaction Coordinator -> Right click on Local DTC ->Select properties
- Select Security tab
- Click on Allow Remote Clients and Allow inbound and Allow Outbound
- Select No Authentication Required
- Apply

  
**DACPACS: <<<< Not needed anymore  
**1) You need to run the dacpacs to update your local databases to the latest schema. To do that, navigate to C:\Projects\Database\.build\  
2) Open a command prompt at that location as Administrator and run app.all.full. Watch out for red errors.  
3) Run tests.all.full

  

**SKYPE:**  
1) If you are installing Skype, add this to your hosts file to remove the annoying ads: 127.0.0.1     [apps.skype.com](http://apps.skype.com/) # Skype Ads Blocker  
  
**ZOOM:**  
1) Management prefers to use Zoom for company-wide meetings. Download and install. You will be provided with a meeting room link if you are required to join a Zoom meeting. You can then sign in using SSO.  
  

**DYNAMIX STANDARD TIME**

You might get the exception "The time zone ID 'DynaMiX Standard Time' was not found on the local computer." To resolve this you should run "DynaMiX Standard Time v11.reg". At time of writing, this can be found here: 

\\DSSTBSOFTWARE\Software\Dev Tools