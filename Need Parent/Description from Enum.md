```c#
//Helper class to get description
namespace DynaMiX.Core.Extensions.Enum
{
	public static class Extensions
	{
		public static string GetDescription(this System.Enum value)
		{
			FieldInfo field = value.GetType().GetField(value.ToString());
			DescriptionAttribute attribute = Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute)) as DescriptionAttribute;
			return attribute == null ? value.ToString() : attribute.Description;
		}
```

```c#
//Useage
MobileUnitConfigurationStatus.GetDescription()

//Enum declaration
public enum ConfigurationStatus : byte
	{
		[Description("Not commissioned")]
		NotCommissioned,
		[Description("Configuration changed")]
		ConfigurationChanged,
		[Description("Compile requested")]
		CompileRequested,
		[Description("Compiling")]
```
