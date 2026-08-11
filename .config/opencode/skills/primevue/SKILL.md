---
name: primevue
description: PrimeVue v4 component patterns and Tailwind integration. Use when writing or styling PrimeVue components.
---

# PrimeVue v4 Conventions

Assume PrimeVue v4 is installed when answering Vue questions. Use the Composition API with `<script setup>`.

## Usage
- Register components via the PrimeVue plugin or import per component.
- Prefer official presets and theming over hand-rolled overrides.

## Tailwind integration
- TailwindCSS is available; when needed, apply utility classes through the component passthrough (`pt`) or the unstyled/preset mechanism rather than overriding internal DOM.
- Keep utility usage consistent with the project's styling layer.

## API detail
- For component props, events, slots, and passthrough (`pt`) keys, fetch the PrimeVue LLM docs index on demand: `https://v4.primevue.org/llms/llms.txt`. Follow the relevant component link for the exact signature.
