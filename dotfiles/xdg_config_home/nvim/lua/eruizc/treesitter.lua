local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  }
}
