---
wiki_ingested: 2026-05-28
created: 2025-08-28T16:27
updated: 2025-08-28T16:28
---
Here's how to use the Developer Command Prompt for Visual Studio:

## Step 1: Find and Open Developer Command Prompt

### ==Method 1 ==- Through Start Menu:

1. Click the **Start** button
2. Type: `Developer Command Prompt`
3. You should see something like:
    - "Developer Command Prompt for VS 2022"
    - "Developer PowerShell for VS 2022"
4. Click on it to open

### Method 2 - Through Visual Studio:

1. Open Visual Studio
2. Go to **Tools** → **Command Line** → **Developer Command Prompt**

### Method 3 - If you can't find it:

1. Press **Windows + R**
2. Type: `cmd`
3. Press Enter
4. Run this command to set up the environment:
    
    ```cmd
    "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat"
    ```
    
    (Replace "Enterprise" with "Professional" or "Community" depending on your VS edition)

## Step 2: ==Navigate== to Your Project

Once the Developer Command Prompt is open, navigate to your build directory:

```cmd
cd C:\Projects\DynaMiX.Backend\.build
```

## Step 3: ==Run== Your Build Command

Now run the MSBuild command:

```cmd
msbuild dynamix.build /t:DoConfigTransformsForApps /p:Environment=DSSTBCFG
```

## How to Verify You're in the Right Command Prompt

You should see something like this at the top when it opens:

```
**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.x.x
** Copyright (c) 2022 Microsoft Corporation
**********************************************************************
```

And when you type `msbuild`, it should show the version without giving a "command not found" error.

## If You Still Get Errors

If you still encounter issues, try this alternative approach in the Developer Command Prompt:

```cmd
# Use the full path to ensure you're using the VS version of MSBuild
"%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" dynamix.build /t:DoConfigTransformsForApps /p:Environment=DSSTBCFG
```

The Developer Command Prompt automatically sets up all the necessary environment variables and paths that Visual Studio projects need, which is why it should resolve the missing targets issue you encountered with the regular PowerShell.