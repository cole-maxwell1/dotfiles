---
name: python
description: Python conventions (PEP 8, ruff, type hints). Use when editing .py files.
---

# Python Conventions

## Style
- Follow PEP 8; run `ruff check` and `ruff format` for linting and formatting.
- Let ruff manage line length and import ordering; do not hand-format against it.

## Typing
- Add type hints on all function signatures; prefer modern syntax (`list[int]`, `X | None`) on supported Python versions.
- Use `dataclasses` (or Pydantic where validation is required) for structured data.
- Prefer an explicit exception hierarchy over bare `except:`.

## Idioms
- Prefer `pathlib.Path` over `os.path`.
- Use f-strings for interpolation; use the `logging` module with structured handlers instead of `print` in libraries.
- Prefer comprehensions and generator expressions over manual loops where readability is preserved.

## Testing
- Use `unittest` (or `pytest` if the project adopts it); mirror the source layout under a `tests/` directory.
