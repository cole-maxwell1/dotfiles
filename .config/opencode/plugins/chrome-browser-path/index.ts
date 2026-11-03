import { accessSync, constants } from "node:fs";
import { homedir } from "node:os";
import { delimiter, join } from "node:path";

import { Plugin } from "@opencode/plugin";

const SERVER = "chrome-devtools";
const EXECUTABLE_FLAGS = ["--executablePath", "--executable-path", "-e"];

function isExecutable(path: string): boolean {
  try {
    accessSync(path, constants.X_OK);
    return true;
  } catch {
    return false;
  }
}

function findOnPath(command: string): string | undefined {
  const path = process.env.PATH;
  if (!path) return undefined;

  const extensions =
    process.platform === "win32"
      ? (process.env.PATHEXT ?? ".EXE;.CMD;.BAT;.COM").split(";")
      : [""];

  for (const directory of path.split(delimiter)) {
    if (!directory) continue;
    for (const extension of extensions) {
      const candidate = join(directory, `${command}${extension}`);
      if (isExecutable(candidate)) return candidate;
    }
  }

  return undefined;
}

function firstExecutable(candidates: readonly string[]): string | undefined {
  return candidates.find(isExecutable);
}

function findBrowser(): string | undefined {
  switch (process.platform) {
    case "darwin":
      return firstExecutable([
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
        join(homedir(), "Applications/Chromium.app/Contents/MacOS/Chromium"),
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        join(
          homedir(),
          "Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        ),
      ]);
    case "linux":
      return [
        "chromium",
        "chromium-browser",
        "google-chrome-stable",
        "google-chrome",
      ]
        .map(findOnPath)
        .find((path): path is string => path !== undefined);
    case "win32": {
      const localAppData = process.env.LOCALAPPDATA;
      const programFiles = process.env.PROGRAMFILES;
      const programFilesX86 = process.env["PROGRAMFILES(X86)"];
      const candidates = [
        localAppData && join(localAppData, "Chromium/Application/chrome.exe"),
        programFiles && join(programFiles, "Chromium/Application/chrome.exe"),
        localAppData &&
          join(localAppData, "Google/Chrome/Application/chrome.exe"),
        programFiles &&
          join(programFiles, "Google/Chrome/Application/chrome.exe"),
        programFilesX86 &&
          join(programFilesX86, "Google/Chrome/Application/chrome.exe"),
      ].filter((path): path is string => typeof path === "string");
      return firstExecutable(candidates);
    }
    default:
      return undefined;
  }
}

function removeExecutablePath(command: readonly string[]): string[] {
  const result: string[] = [];

  for (let index = 0; index < command.length; index += 1) {
    const argument = command[index];
    if (EXECUTABLE_FLAGS.includes(argument)) {
      index += 1;
      continue;
    }
    if (EXECUTABLE_FLAGS.some((flag) => argument.startsWith(`${flag}=`))) {
      continue;
    }
    result.push(argument);
  }

  return result;
}

export default Plugin.define({
  id: "chrome-browser-path",
  async setup(ctx) {
    const browser = findBrowser();
    if (!browser) {
      console.warn(
        "chrome-browser-path: no Chromium or Google Chrome executable found; using chrome-devtools-mcp discovery",
      );
      return;
    }

    await ctx.mcp.transform((editor) => {
      editor.update(SERVER, (server) => {
        if (server.type !== "local") return;
        server.command = [
          ...removeExecutablePath(server.command),
          "--executablePath",
          browser,
        ];
      });
    });
  },
});
