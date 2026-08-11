---
name: go
description: Idiomatic Go conventions. Use when editing .go files or go.mod/go.sum.
---

# Go Conventions

Write strictly idiomatic Go following standard formatting and best practices.

## Formatting and style
- `gofmt` / `goimports` formatting is mandatory.
- Follow [Effective Go](https://go.dev/doc/effective_go) and the [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments).

## Design
- Accept `context.Context` as the first parameter on functions doing I/O or long work; honor cancellation.
- Compose via small interfaces; accept interfaces, return structs.
- Wire dependencies explicitly via constructor injection; avoid package-level mutable globals and DI frameworks.
- Return errors explicitly; wrap with `%w` (`fmt.Errorf("do thing: %w", err)`); classify with `errors.Is` / `errors.As`; never discard errors.

## Testing
- Write table-driven tests in `_test.go` using the standard `testing` package.
- Use `t.Run` for subtests; report failures with `t.Errorf` / `t.Fatalf`.
