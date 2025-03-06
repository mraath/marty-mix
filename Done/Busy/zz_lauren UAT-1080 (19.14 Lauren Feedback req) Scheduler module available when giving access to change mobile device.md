## AU launch

AFR

Ek is SUPER impressed met my vrou!
Haar website launch vandag!!!
Ons is baie bly met wat ons verrig het.
Gaan kyk bietjie: 

www.africaunwind.com

n Groot deel van besigheid deesdae is maar
social media ook - so indien jul kan
help...?

Like haar page en follow haar indien jul wil:
FB: https://www.facebook.com/africaunwind
Insta: https://www.instagram.com/africaunwind

BAIE DANKIE
YEAH GOD vir hierdie nuwe seisoen!!



ENG

I'm SUPER impressed with my wife!
Her website launched 1st Sept!!!
Go have a look:

www.africaunwind.com

A huge part of business nowadays
is social media.... so if you can help...?

Like her FB page and follow her on Insta:
FB: https://www.facebook.com/africaunwind
Insta: https://www.instagram.com/africaunwind

THANKS A LOT!
SUPER STOKED for this new season!

## AU launch

AFR

Ek is SUPER impressed met my vrou!
Haar website launch vandag!!!
Ons is baie bly met wat ons verrig het.
Gaan kyk bietjie: 

www.africaunwind.com

n Groot deel van besigheid deesdae is maar
social media ook - so indien jul kan
help...?

Like haar page en follow haar indien jul wil:
FB: https://www.facebook.com/africaunwind
Insta: https://www.instagram.com/africaunwind

BAIE DANKIE
YEAH GOD vir hierdie nuwe seisoen!!



ENG

I'm SUPER impressed with my wife!
Her website launched 1st Sept!!!
Go have a look:

www.africaunwind.com

A huge part of business nowadays
is social media.... so if you can help...?

Like her FB page and follow her on Insta:
FB: https://www.facebook.com/africaunwind
Insta: https://www.instagram.com/africaunwind

THANKS A LOT!
SUPER STOKED for this new season!

# UAT-1080 [19.14 Lauren Feedback req] Scheduler module available when giving access to change mobile device

  - Resolution

    I have asked Lauren for feedback

  - Issue

    When creating a user with permission to the only the mobile device settings tab (Tab is in Fleet admin but the permission is in the Config Admin section) with permission to change mobile device, the user gets the scheduler module without permission to it.

    Permissions given: 
    Mobile device settings
    Mobile device settings - Change mobile device

    User: laurenvdv82@gmail.com

  - Values

    ASSET_COMMISSIONING_ACCESS_SETTINGS = 520000010;
    ASSET_COMMISSIONING_UPDATE_SETTINGS = 520000011;
    ASSET_LEVEL_CHANGE_MOBILE_DEVICE = 520000005;

  - Findings

    "Mobile device settings"
      ASSET_COMMISSIONING_ACCESS_SETTINGS = 520000010;
      ASSET_COMMISSIONING_UPDATE_SETTINGS = 520000011;

    "Mobile device settings - Change mobile device"
      ConfigAdminPermissions.ASSET_LEVEL_CHANGE_MOBILE_DEVICE   <<< INVESTIGATE THIS NEXT >>>

    ????
    "Configuration Groups - Asset level - Mobile device settings",
      AccessPermissionId = ConfigAdminPermissions.ASSET_LEVEL_ACCESS_MOBILE_DEVICE,
      UpdatePermissionId = ConfigAdminPermissions.ASSET_LEVEL_UPDATE_MOBILE_DEVICE

  - DynaMiXDefaultRoles.xml
  - SR-9485
  - Required by

    <!-- SCHEDULER -->
    <permission id="1100000000" name="Scheduler Module" description="Scheduler Module" >
      <requiredby id="520000010" />           <!-- Asset level - Access Mobile Device -->

    <permission id="1100000001" name="Access Uploads" description="Access Uploads" >
      <requiredby id="520000010" />           <!-- Asset level - Access Mobile Device -->

    <permission id="1100000011" name="Access Downloads" description="Access Downloads" >
        <requiredby id="520000010" />         <!-- Asset level - Access Mobile Device -->

    <permission id="1100000041" name="Scheduler Module" description="Scheduler data access">
        <requiredby id="520000010" />         <!-- Can access mobile device settings -->

    <permission id="1100000032" name="Scheduler Data Access" description="Scheduler Data Access">
      <requiredby id="520000010" />           <!-- Asset level - Access Mobile Device -->

  - User setup

    Roles > Permission >  (Make available to Org)
    User > Permission > Org / Site > Roles > Permissions
