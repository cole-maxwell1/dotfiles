/*
Gate the ibmi-mcp-server on its required environment variables.

opencode's config schema types `mcp.<name>.enabled` as a static boolean and
only interpolates `{env:VAR}` for string values (headers, environment
entries), never for the `enabled` flag. Conditionally enabling a server is
therefore not expressible in opencode.jsonc alone.

This plugin uses the `config` hook, which runs once at startup with the live
merged config (before MCP servers spawn), to flip `ibmi-server.enabled` to
`true` only when every required credential is present. The config keeps
`enabled: false` as a fallback default, so the server stays off if this
plugin fails to load.
 */

import type { Plugin } from "@opencode-ai/plugin";

// Credentials the ibmi-server MCP needs to connect. All must be non-empty.
const REQUIRED_ENV = ["DB2i_HOST", "DB2i_USER", "DB2i_PASS"] as const;
const SERVER = "ibmi-server";

export default (async () => {
  return {
    config: (cfg) => {
      const ready = REQUIRED_ENV.every((name) => {
        const value = process.env[name];
        return typeof value === "string" && value.length > 0;
      });
      const server = cfg.mcp?.[SERVER];
      if (server && typeof server === "object") {
        (server as { enabled?: boolean }).enabled = ready;
      }
    },
  };
}) satisfies Plugin;
