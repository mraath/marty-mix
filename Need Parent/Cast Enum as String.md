
```c#
//Enum
public enum MyEnum : byte
{
    Value1,
    Value2,
    Value3
}

//Useage
MyEnum enumValue = MyEnum.Value2;
string enumAsString = enumValue.ToString();

Console.WriteLine(enumAsString); // Output: "Value2"

//default behavior of `ToString()` will return the name of the enum value. If you want to customize the string representation, you can use attributes like `DescriptionAttribute`.
```
