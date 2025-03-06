## ---
status: closed
date: 2023-02-16
comment: 
priority: 8
---

# SR-14647 Command 45 App Login Issue

Date: 2023-02-16 Time: 10:16
Parent:: [[Command 45]]
Friend:: [[2023-02-16]]
JIRA:Command 45 App Login Issue
[SR-14647 Command 45 App Login Issue - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/SR-14647)

## Comment

I have copied the latest tool to:
C:\Projects\DaylightSavingsTime.23.5
And removed the older version.
This was done for:
US, UK, ENT, ZA, AU
(UAE was copied, but they need .net, so I skipped this as they didn't have it before, if in future they need it we can install the correct .net sdk on the jumpbox server)

## NEXT STEPS

Deploy to:
- [x] US: DaylightSavingsTime.23.5
- [x] UAE, Copied but need .net, so skipped
- [x] UK: DaylightSavingsTime.23.5
- [x] ENT: DaylightSavingsTime.23.5
- [x] ZA: DaylightSavingsTime.23.5
- [x] AU: DaylightSavingsTime.23.5
- [x] PR Code to INT



## Try this

```c#
private bool GetAuthToken()
		{
			try
			{
				var authResult = AuthenticationClient.LoginAsync(txtName.Text, txtPassword.Text, false, 0, "Web").ConfigureAwait(false).GetAwaiter().GetResult();
				_authToken = authResult.AuthToken;
			}
			catch (Exception ex)
			{
				MessageBox.Show($"Authentication failure. {ex.Message}");
				return false;
			}
			return true;
		}

		private void btnLogin_Click(object sender, EventArgs ev)
		{
			if (string.IsNullOrEmpty(txtName.Text) || string.IsNullOrEmpty(txtPassword.Text))
				MessageBox.Show("Please supply the login details.");

			btnLogin.Enabled = false;
			if (GetAuthToken())
			{
				//if success disable this one enable other
				grpLogin.Enabled = false;
				grpSendCommand.Enabled = true;
			}
			else
			{
				btnLogin.Enabled = true;
			}
		}
```




## Issue

Hedayat said:

![[Command 45 App Login Issue.png | 700]]

## Code analysis

DynaMiX.DeviceConfig > DaylightSavingsTimeAdjuster > 


## Workflow

- See where the data stopped
- Update Graphs in Obsidian
- Decide if we are still the correct team
- Sanity check William (DP)

## Any Development done?

## Development work

Lang, UI, BE, Client (MiX.DeviceConfig), API (Dynamix.DeviceConfig), Common (MiX.DeviceIntegration.Core), DB

| API   |     |
| ----- | --- |
| 23.5 |     |
| Local |     |

## Branch
Config/MR/Bug/SR-14647_Command_45_App_Login_Issue.23.5.INT_ORI

