local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "vue" }
  },
  indent = {
    enable = true,
    disable = { "java", "javascriptreact", "typescriptreact" }
  }
}
