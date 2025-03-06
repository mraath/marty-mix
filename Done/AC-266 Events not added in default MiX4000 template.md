# AC-266 Events not added in default MiX4000 template

    COMMON | Local | INT | Nuget
    BE | local | xx

    Config/MR/Feature/AC-266_EventsNotAdded.21.17.INT.ORI

  --INT
  	<event id="150673821216952582" type="1" returnActionType="3" returnParameterId="-7726304674489494364" legacyId="330" description="Driver side rear door open">
    <event id="485554640130427396" type="1" returnActionType="3" returnParameterId="6497594155372856326" legacyId="331" description="Passenger side rear door open">

    [Description("Driver side rear door open")]
    DriverSideRearDoorOpen = 330,

    [Description("Passenger side rear door open")]
    PassengerSideRearDoorOpen = 331,

  --DEV
    <event id="150673821216952582" type="1" returnActionType="3" returnParameterId="-7726304674489494364" legacyId="292" description="Driver side rear door open">
    <event id="485554640130427396" type="1" returnActionType="3" returnParameterId="6497594155372856326" legacyId="293" description="Passenger side rear door open">


    <parameter id="-7726304674489494364" legacyId="21713" systemName="System.FM.CAN.DD02S" description="Rear door driver side state" valueFormat="2" returnSize="4">
    <parameter id="6497594155372856326" legacyId="21714" systemName="System.FM.CAN.PDOS2" description="Rear door passenger side state" valueFormat="2" returnSize="4">
