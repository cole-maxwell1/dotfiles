---
description: Generate a Conventional Commit message based on staged changes
---

Inspect the current workspace git status and staged diff (`git diff --staged`). Generate a professional commit message for my approval.

Strictly adhere to the following Conventional Commit specification rules:

### Formatting Rules

- **Format:** `<type>(<optional scope>): <description>` followed by an optional `<body>` and `<footer` separated by blank lines.
- **Subject Case:** The description MUST start with a lowercase letter.
- **No Ending Punctuation:** Do NOT end the subject line with a period.
- **Imperative Mood:** Use imperative, present tense ("add" not "added" or "adds").
- **Breaking Changes:** Append `!` before the colon in the header for breaking changes (e.g., `feat(api)!: drop v1 endpoints`) and include a `BREAKING CHANGE:` footer.

### Allowed Types

- `feat`: Add, adjust, or remove API/UI functionality.
- `fix`: Fix a bug in existing API/UI functionality.
- `refactor`: Structural changes without altering public API/UI behavior.
- `perf`: Special refactor that explicitly improves performance.
- `style`: Formatting, missing semi-colons, whitespace adjustments.
- `test`: Adding or correcting tests.
- `docs`: Documentation updates only.
- `build`: Build tool, dependency, or project version updates.
- `ops`: Infrastructure, CI/CD pipelines, deployment, or operational scripts.
- `chore`: Maintenance tasks (e.g., updating `.gitignore`, repo setup).

### Message Body

The message body should provide a detailed description of the changes, including any relevant context or reasoning.

Provide ONLY the proposed commit message inside a raw code block, followed by a request for my approval.
