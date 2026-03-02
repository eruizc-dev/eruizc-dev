import { tool } from "@opencode-ai/plugin"

export default tool({
  description:
    "Open a URL in the user's default application. Works on macOS and Linux.",
  args: {
    url: tool.schema
      .string()
      .url()
      .describe("The HTTP or HTTPS URL to open in the browser"),
  },
  async execute(args) {
    const url = args.url
    const platform = process.platform

    let command: string[]
    if (platform === "darwin") {
      command = ["open", url]
    } else {
      command = ["xdg-open", url]
    }

    const result = await Bun.spawn(command, {
      stdout: "ignore",
      stderr: "pipe",
    })

    const exitCode = await result.exited
    if (exitCode !== 0) {
      const stderr = await new Response(result.stderr).text()
      return `Failed to open URL: ${stderr.trim()}`
    }

    return `Opened ${url} in the default browser`
  },
})
