local gears           = require("gears")
local awful           = require("awful")
require("awful.autofocus")
local wibox           = require("wibox")
local beautiful       = require("beautiful")
local lain            = require("lain")
local freedesktop     = require("freedesktop")
local hotkeys_popup   = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table        = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi             = require("beautiful.xresources").apply_dpi
local utils = require("utils")
local copycat = require("copycat")
local enums = require("enums")

local config = {
  theme = copycat.themes.POWERARROW_DARK,
  modkey = enums.modkeys.SUPER,
  shift = enums.modkeys.SHIFT,
  ctrl = enums.modkeys.CONTROL,
  altkey = enums.modkeys.ALT,
  terminal = "alacritty",
  editor = os.getenv("EDITOR") or "vim",
  browser = os.getenv("BROWSER") or "brave",
  screen_locker = nil
}
-- Merge these into config later
local modkey       = enums.modkeys.SUPER
local altkey       = enums.modkeys.ALT

utils.handle_errors()
utils.autostart({
  "flameshot",            -- Screenshots
  "picom",                -- Copositor (Window transparency)
  "xbindkeys --poll-rc",  -- Keymaps
  "source ~/.fehbg",      -- Load wallpaper
  "birdtray",             -- Thunderbird tray
})

awful.util.terminal = config.terminal
awful.util.tagnames = { "1", "2", "3", "4", "5" }
awful.layout.layouts = {
  awful.layout.suit.spiral.dwindle,
  lain.layout.centerwork.horizontal,
}

awful.util.taglist_buttons = my_table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 2, function (c) c:kill() end),
  awful.button({ }, 3, function ()
    local instance = nil

    return function ()
      if instance and instance.wibox.visible then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({theme = {width = dpi(250)}})
      end
    end
  end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), config.theme))

-- {{{ Menu
local myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end },
  { "manual", config.terminal .. " -e man awesome" },
  { "edit config", string.format("%s -e %s %s", config.terminal, config.editor, awesome.conffile) },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
  icon_size = beautiful.menu_height or dpi(16),
  before = {
    { "Awesome", myawesomemenu, beautiful.awesome_icon },
  },
  after = {
    { "Open terminal", config.terminal },
  }
})

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
  local only_one = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if only_one and not c.floating or c.maximized then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Key bindings
local globalkeys = my_table.join(
  -- Hotkeys
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group="awesome" }),
  awful.key({ modkey }, "w", function () awful.util.mymainmenu:show() end, { description = "Open menu", group = "awesome" }),
  awful.key({ modkey }, "b", function () for s in screen do s.mywibox.visible = not s.mywibox.visible if s.mybottomwibox then s.mybottomwibox.visible = not s.mybottomwibox.visible end end end, { description = "Toggle wibox", group = "awesome" }),
  awful.key({ modkey, config.ctrl }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, config.shift }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

  -- Client focus
  awful.key({ modkey }, "j", function() awful.client.focus.global_bydirection("down") if client.focus then client.focus:raise() end end, { description = "Focus down", group = "client" }),
  awful.key({ modkey }, "k", function() awful.client.focus.global_bydirection("up") if client.focus then client.focus:raise() end end, { description = "Focus up", group = "client" }),
  awful.key({ modkey }, "h", function() awful.client.focus.global_bydirection("left") if client.focus then client.focus:raise() end end, { description = "Focus left", group = "client" }),
  awful.key({ modkey }, "l", function() awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end, { description = "Focus right", group = "client" }),
  awful.key({ modkey, config.ctrl }, "h", function () awful.screen.focus_relative(1) end, { description = "Screen Left", group = "screen" }),
  awful.key({ modkey, config.ctrl }, "l", function () awful.screen.focus_relative(-1) end, { description = "Screen right", group = "screen" }),

  -- Layout manipulation
  awful.key({ modkey, config.shift }, "j", function () awful.client.swap.byidx(1) end, { description = "Move down", group = "layout" }),
  awful.key({ modkey, config.shift }, "k", function () awful.client.swap.byidx(-1) end, { description = "Move up", group = "layout" }),
  awful.key({ altkey, config.shift }, "l", function() awful.tag.incmwfact(0.05) end, { description = "Increase window size", group = "layout" }),
  awful.key({ altkey, config.shift }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "Decrease window size", group = "layout" }),
  awful.key({ modkey }, "space", function () awful.layout.inc(1) end, { description = "Select nex layout", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, { description = "Select previous layout", group = "layout" }),

  -- Standard program
  awful.key({ modkey }, "Return", function() awful.spawn(config.terminal) end, {description = "Open terminal", group = "launcher"}),
  awful.key({ modkey }, "q", function () awful.spawn(config.browser) end, {description = "Open browser", group = "launcher"}),
  awful.key({ modkey }, "p", function () os.execute("rofi -show run") end, { description = "Open rofi", group = "launcher" })
)

local clientkeys = my_table.join(
  -- awful.key({ modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end, {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, { description = "Close window", group = "client" }),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "client" }),
  awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "Change screen", group = "client" }),
  awful.key({ modkey }, "m", function(c) c.maximized = not c.maximized c:raise() end, { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = "view tag #", group = "tag"}
    descr_toggle = {description = "toggle tag #", group = "tag"}
    descr_move = {description = "move focused client to tag #", group = "tag"}
    descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
  end
    globalkeys = my_table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
    function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end,
    descr_view),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
    descr_toggle),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    descr_move),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
    descr_toggle_focus)
  )
end

local clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },

  -- Titlebars
  {
    rule_any = { type = { "dialog", "normal" } },
    properties = { titlebars_enabled = false }
  },

  -- Set Firefox to always map on the first tag on screen 1.
  {
    rule = { class = "Firefox" },
    properties = { screen = 1, tag = awful.util.tagnames[1] }
  },

  {
    rule = { class = "Gimp", role = "gimp-image-window" },
    properties = { maximized = true } },
  }
  -- }}}

  -- {{{ Signals
  -- Signal function to execute when a new client appears.
  client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)

  -- Add a titlebar if titlebars_enabled is set to true in the rules.
  client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
      beautiful.titlebar_fun(c)
      return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 2, function() c:kill() end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
    )

    awful.titlebar(c, {size = dpi(16)}) : setup {
      {
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
      },
      {
        {
          align  = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      {
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
