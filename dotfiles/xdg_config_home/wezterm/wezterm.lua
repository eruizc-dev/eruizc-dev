local wezterm = require('wezterm')

return {
  color_scheme = 'Brogrammer',
  font = wezterm.font('TerminessTTF Nerd Font Mono'),
  font_size = 17, -- TODO: Increase font size in mac
  window_background_opacity = 0.75,
  check_for_updates = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
}
