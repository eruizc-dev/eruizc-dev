local naughty = require("naughty")
local awful = require("awful")

local utils = {}

function utils.handle_errors()
  if awesome.startup_errors then
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Errors in AwesomeWM!!",
      text = awesome.startup_errors
    })
  end

  awesome.connect_signal("debug::error", function (err)
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
  end)
end

function utils.autostart(commands)
  for _, command in ipairs(commands) do
    local safe_command = string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", command, command)
    awful.spawn.with_shell(safe_command)
  end
end

return utils

