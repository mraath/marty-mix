---
created: 2025-10-21T16:37
updated: 2025-10-22T16:50
---
## Introduction

While working on OPEN-453, I saw that they need a new permission under the support tools as per the image.

![[Permissions eg.png]]

From this image I could see that the **Error Log** is the closest to what they want. They only need access permission which is also what I see by error log. Knowing this I decided to search across the repos for this error log permission In order to bring this example together.

What you will need to do is add your new permission everywhere where I see this error log permission.

Since I am doing this by searching for the UI, you will notice following this example that it almost goes backwards or in reverse. 
(Maybe follow my example first. For some people it might make more sense starting in the DB...)
If you want to, you could start at the bottom and:
- first add the **database** entry via XML. 
- Then you could go ahead and add the **permissions** constant and 
- then you could add it into the **support tools**.

## Initial places found

The two related places I first found Error Log was under Support Tools in the backend as well as in Languaging.

**Support Tools**:

C:\Projects\DynaMiX.Backend\Common\DynaMiX.Common\PermissionModules\Definitions\SupportTools.cs

```cs
new PermissionModuleFeature
{
	Name = "Error Log",
	AccessPermissionId = Permissions.ACCESS_SUPPORT_TOOLS_ERROR_LOGS,
},
```

You will need to add something similar for your permission.
Later in this document I will show you where to find the above mentioned permissions value.

**Languaging**:
This is very important to add in, in order for this UI story to pass.

C:\Projects\Languaging\MiXFleetManager\mixfleet_usermanagement\templates\langset.pot

```pot
msgid "Error Log"
msgstr ""
```

This will be case sensitive, so please make sure to write the exact string in the correct case.

## Permissions value

I mentioned before that there was a permissions value we need to add. I will show you here where to add it. For this example, what we looked for was the following: **ACCESS_SUPPORT_TOOLS_ERROR_LOGS**

**Permissions**:

C:\Projects\DynaMiX.Backend\Common\DynaMiX.Common\SupportTools\Permissions.cs

```cs
public const long ACCESS_SUPPORT_TOOLS_ERROR_LOGS = 1700000013;
```

You will see that this long gets declared in this permissions clause. We will now look where this long gets added to the database.

## Database

C:\Projects\Database\DynaMiX\Scripts\DeploymentScripts\Data\DynaMiXDefaultRoles.xml

Currently in the database I only see the permission being referred to within a role. You will see that there are different roles. For instance the system administrator or the technician having to install the device. I have asked Zonica which users should have this role by default. For now I think it will be safe to add it to the **system administrator**.

System administrator is part of role id 1.

```xml
<!-- Error logs -->
<permission id="1700000013"/> <!-- name="Access Support Tools Error Logs" description="" -->
```

If you search for this long within the XML file mentioned above, you will see all the other places that added this as a default permission. However, we must just clarify with Zonica which default permission should get this. For now, I think just leave it as System Administrator.

Long to search for: **1700000013**


## Which ID to use

In the above eg. they used 1700000013
Usually they are grouped together and eg. Read, Write, etc would just have some difference in the back.
From this eg. I think a save id to use would be: **1700000023**

### Reasoning

You will notice that for this example, they have grouped all the Support Tools together....
C:\Projects\DynaMiX.Backend\Common\DynaMiX.Common\SupportTools\Permissions.cs

The base one (found at the top) is 1700000000
From there they just counted down... the last one I can see for this group (Support Tools) is 1700000021, but the highest one here is: 1700000022

So I would pick: 1700000023
And if I search for it in the mentioned XML, it isn't yet defined, which is good

## LoadPermissions

We also need to add it into:
C:\Projects\Database\DynaMiX\Scripts\Post-Deployment\LoadPermissions.sql

In this instance we shouldn't need the "requiredby"

Herewith the example as per above:

```sql
<permission id="1700000013" name="Access Support Tools Error Logs" description="" />
```

## Required By

Sometimes we give permission to eg. View error logs, however, within the error log it might call assets in which case the user needs access to Access Assets
This is where **requiredby** comes in which is visible within the sql above.
This logic sometimes feels the wrong way around, so when it is late, make sure you focus when doing this :-D

## Testing

There is a lot that will go into testing this the first time you try it. Maybe the quickest would be to ask one of the testers like Donny or Amy. Please shout if you need any help.

> It does feel like I might miss something. Maybe not, hopefully not, but I might miss something. If I think of that, I will let you know, but please feel free to ask me any questions you might have.
