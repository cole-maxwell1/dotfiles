---
name: typescript
description: TypeScript conventions (Google style, strict mode, no any). Use when editing .ts or .tsx files, or tsconfig/jsconfig files.
---

# TypeScript Conventions

Follow the [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html).

## Typing
- `strict: true` in tsconfig; no implicit or explicit `any`.
- Strictly type all variables, functions, and interfaces.
- Prefer `unknown` over `any` when the type is genuinely unknown, then narrow.
- Prefer discriminated unions and type narrowing over runtime checks.
- Declare explicit return types on public and shared APIs.

## Style
- Prefer `interface` for object shapes; use `type` for unions and mapped types.
- Use `const` by default; `let` only when reassignment is required; never `var`.
- Prefer async/await over raw `.then`/`.catch` chains.

## Project overrides
A project's tsconfig or eslint config may relax rules (for example, disable `@typescript-eslint/no-explicit-any`); project configuration overrides these defaults.
