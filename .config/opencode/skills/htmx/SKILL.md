---
name: htmx
description: HTMX v2 progressive-enhancement and hypermedia patterns.
---

# HTMX Conventions

Follow [HTMX](https://htmx.org) v2 and [Hypermedia Systems](https://hypermedia.systems/book/contents/) best practices.

## Philosophy
- Treat the server as the source of truth; return HTML fragments, not JSON, for hypermedia interactions.
- Prefer `hx-*` attributes over client-side JavaScript; reach for client JavaScript only when htmx cannot express the interaction.
- Build progressively: ensure pages function without JavaScript, then enhance with htmx.

## Patterns
- Target fragments with `hx-target` and swap with `hx-swap` (prefer `outerHTML` or `innerHTML` as appropriate).
- Return partial templates or fragments from endpoints; treat partials as isolated components that receive data via the page model.
- Use Out-of-Band Swaps (`hx-swap-oob`) to update multiple regions from a single response.
- Handle errors with a 4xx/5xx partial or `hx-on::responseError`.

## Keep clean
- Return semantic HTML from endpoints; avoid mixing `hx-*` attributes with conflicting client-side handlers.
