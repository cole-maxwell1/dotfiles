---
name: bash
description: Shell scripting conventions (set -euo pipefail, quoting, shellcheck). Use when editing .sh or .bash files.
---

# Bash Conventions

## Robustness
- Begin scripts with `#!/usr/bin/env bash` and `set -euo pipefail`.
- Pass `shellcheck` cleanly; treat its warnings as bugs.

## Quoting and expansion
- Double-quote all variable expansions (`"$var"`, `"${array[@]}"`).
- Prefer `[[ ]]` over `[ ]`; use arrays for argument lists rather than space-separated strings.
- Avoid `eval`; do not parse `ls` output.

## Structure
- Declare function-local variables with `local`.
- Use `trap` to clean up temporary files and directories.
- Use `printf` over `echo` for predictable output.
- Prefer a `$TMPDIR`-based path over hardcoded `/tmp` literals.
