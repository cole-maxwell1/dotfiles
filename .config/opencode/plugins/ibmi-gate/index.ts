/*
Gate the ibmi-mcp-server on its required environment variables.

MCP server enablement is a static boolean in opencode.jsonc. This plugin uses
an MCP transform to enable ibmi-server only when every required credential is
present. The config keeps the server disabled as a fallback if the plugin does
not load.
*/

import { Plugin } from "@opencode/plugin";

const REQUIRED_ENV = ["DB2i_HOST", "DB2i_USER", "DB2i_PASS"] as const;
const SERVER = "ibmi-server";

export default Plugin.define({
  id: "ibmi-gate",
  async setup(ctx) {
    const ready = REQUIRED_ENV.every((name) => {
      const value = process.env[name];
      return typeof value === "string" && value.length > 0;
    });

    await ctx.mcp.transform((editor) => {
      editor.update(SERVER, (server) => {
        server.disabled = !ready;
      });
    });
  },
});
