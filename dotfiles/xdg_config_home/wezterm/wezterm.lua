local wezterm = require('wezterm')

return {
  color_scheme = 'Dracula',
  font = wezterm.font('TerminessTTF Nerd Font Mono'),
  hide_tab_bar_if_only_one_tab = true,
  font_size = 16, -- TODO: Increase font size in mac
  window_background_opacity = 0.69,
  check_for_updates = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
}
