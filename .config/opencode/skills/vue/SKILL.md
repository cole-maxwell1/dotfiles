---
name: vue
description: Vue 3 (Composition API, script setup, Pinia, Vue Router) conventions. Use when editing .vue files.
---

# Vue 3 Conventions

Use Vue 3 with the Composition API exclusively.

## Components
- Use `<script setup lang="ts">`; avoid the Options API.
- Type props with `defineProps<T>()` and emits with `defineEmits<T>()`.
- Keep components focused and small; organize by feature directory.

## State and routing
- Use Pinia setup stores (`defineStore('name', () => { ... })`) for shared state.
- Cancel superseded fetches with `AbortController`; expose loading and error state from stores.
- Use Vue Router with route guards for protected views.

## Reactivity
- Prefer `ref` / `reactive` and `computed` over manual watchers.
- Clean up side effects (timers, listeners, observers) in `onScopeDispose` or `onUnmounted`.

## API detail
- For exact reactivity, built-in component, and compiler behavior, fetch the Vue LLM docs index on demand: `https://vuejs.org/llms.txt`. Follow the relevant guide link for the specific API.
