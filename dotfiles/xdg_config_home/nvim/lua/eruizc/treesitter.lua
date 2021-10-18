local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    enable = true,
    disable = { "java", "javascriptreact", "typescriptreact" }
  }
}
