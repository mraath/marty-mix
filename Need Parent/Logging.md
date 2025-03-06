## Class Level

Yes, you can use aspect-oriented programming (AOP) in C# to decorate a class and log the method being called by using an `Attribute` and an `Aspect`. Here's an example:

```c#
[AttributeUsage(AttributeTargets.Method)]
public class LogAttribute : Attribute
{
}

public class LoggingAspect : OnMethodBoundaryAspect
{
    public override void OnEntry(MethodExecutionArgs args)
    {
        Console.WriteLine($"Entering method: {args.Method.Name}");
        base.OnEntry(args);
    }

    public override void OnExit(MethodExecutionArgs args)
    {
        Console.WriteLine($"Exiting method: {args.Method.Name}");
        base.OnExit(args);
    }
}

[Log]
public class MyClass
{
    public void Method1()
    {
        Console.WriteLine("Method1 is called");
    }

    public void Method2()
    {
        Console.WriteLine("Method2 is called");
    }
}
```

In this example, the `LogAttribute` is used to decorate the methods of `MyClass` that we want to log. The `LoggingAspect` class implements the `OnMethodBoundaryAspect` from the PostSharp library, which is an AOP framework for .NET. The `OnEntry` and `OnExit` methods of the `LoggingAspect` are overridden to log the method being entered and exited, respectively.

You'll need to install the PostSharp library to use this code. You can install it via the NuGet Package Manager in Visual Studio.

## Project level

Yes, you can apply the aspect to all methods of a project by using a module-level aspect in PostSharp. Here's an example:

```c#
[Serializable]
[AspectTypeDependency(AspectDependencyAction.Order, AspectDependencyPosition.Before, typeof(LogAttribute))]
public class LoggingModuleAspect : OnMethodBoundaryAspect
{
    public override void OnEntry(MethodExecutionArgs args)
    {
        Console.WriteLine($"Entering method: {args.Method.Name}");
        base.OnEntry(args);
    }

    public override void OnExit(MethodExecutionArgs args)
    {
        Console.WriteLine($"Exiting method: {args.Method.Name}");
        base.OnExit(args);
    }
}
```

In this example, the `LoggingModuleAspect` class implements the `OnMethodBoundaryAspect` and logs the method being entered and exited in a similar manner as the previous example. The `AspectTypeDependencyAttribute` is used to specify that this aspect should be applied before the `LogAttribute`.

To apply this aspect to a project, you'll need to add a reference to the PostSharp library and then add the following line to the project file:

```c#
<PostSharp AspectInfrastructure="Required">
  <Aspects>
    <AssemblyName Pattern="$(SolutionDir)\*\*.dll" />
  </Aspects>
</PostSharp>
```

This line specifies that all assemblies in the solution directory should be processed by PostSharp. With this setup, the `LoggingModuleAspect` will be applied to all methods in all classes in the project.

## Solution Level

Yes, you can apply the aspect to all methods in a solution by using a solution-level aspect in PostSharp. Here's an example:

```c#
[Serializable]
[AspectTypeDependency(AspectDependencyAction.Order, AspectDependencyPosition.Before, typeof(LogAttribute))]
public class LoggingSolutionAspect : OnMethodBoundaryAspect
{
    public override void OnEntry(MethodExecutionArgs args)
    {
        Console.WriteLine($"Entering method: {args.Method.Name}");
        base.OnEntry(args);
    }

    public override void OnExit(MethodExecutionArgs args)
    {
        Console.WriteLine($"Exiting method: {args.Method.Name}");
        base.OnExit(args);
    }
}
```

In this example, the `LoggingSolutionAspect` class implements the `OnMethodBoundaryAspect` and logs the method being entered and exited in a similar manner as the previous examples. The `AspectTypeDependencyAttribute` is used to specify that this aspect should be applied before the `LogAttribute`.

To apply this aspect to a solution, you'll need to add a reference to the PostSharp library and then add the following lines to the solution file:

```c#
<PostSharp AspectInfrastructure="Required">
  <Aspects>
    <SolutionName Pattern="$(SolutionName)" />
  </Aspects>
</PostSharp>
```

This line specifies that all projects in the solution should be processed by PostSharp. With this setup, the `LoggingSolutionAspect` will be applied to all methods in all classes in all projects in the solution.

## OLD WAY

I put something like this in each method... mission... could still use it for more specific info needed:

```c#
DmXLogger.Log($"MiX3K > Default > Update > Template > Device > Logicals > {dataLogicalDevice.Id} > Done", LogLevel.Info);
```

