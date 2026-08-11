---
name: csharp
description: C# and .NET coding conventions. Use when reading, writing, or reviewing .cs, .razor, .csproj, or .sln files, or any .NET (C#) code.
---

# C# / .NET Conventions

Follow the Microsoft [Common C# code conventions](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions) and [.NET naming guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines). Match patterns already established in the target codebase.

## Structure
- Use file-scoped namespaces (`namespace Example.Services;`).
- Nullable reference types are enabled solution-wide; do not suppress warnings without cause.
- Use `record` types for DTOs and data carriers.
- Use `required` / `init`-only properties for immutable domain models.
- Use primary constructors for services and repositories that take injected dependencies.
- Mark classes `sealed` by default unless inheritance is intended.
- Prefix interfaces with `I` (`IRenderer`, `IRepository`).

## Expressions
- Use raw string literals (`""" ... """`) for multi-line SQL.
- Use `[GeneratedRegex]` partial methods for regex.
- Use collection expressions (`[]`, `[a, b]`).

## Async and cancellation
- Every async method takes `CancellationToken ct = default` and honors it cooperatively (`ct.ThrowIfCancellationRequested()` in long loops).
- Never drop the token when calling downstream async APIs.

## Logging
- Inject `ILogger<T>` and use structured logging with named parameters:
  `_logger.LogInformation("Generated {Count} transactions", count);`

## Naming
- `PascalCase` for types and members.
- `_camelCase` for private fields.

## Testing
- Use xUnit. Mirror the source structure under a `Tests/` directory with a `Tests` suffix on file names.
