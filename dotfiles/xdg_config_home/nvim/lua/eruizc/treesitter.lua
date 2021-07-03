local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup {
  ensure_installed = "all",
  ignore_install = { "haskell", "kotlin" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "javascriptreact", "typescriptreact" }
  },
}
