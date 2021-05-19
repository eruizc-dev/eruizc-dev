local lspconfig = require("lspconfig")

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.gopls.setup{}
lspconfig.jdtls.setup{ cmd = { "jdtls" } }
lspconfig.jsonls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.solargraph.setup{}
lspconfig.sqls.setup{}
lspconfig.sumneko_lua.setup {
  cmd = { "lua-language-server" };
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = {
          "vim", -- vim
          "describe", "it", "before_each", "after_each", "teardown", "pending", "clear", -- Busted
        },
      },
      workspace = {
        library = {
          [vim.fn.expand("~/.config/nvim/lua")] = true,
          [vim.fn.expand("~/.config/nvim/plugged/plenary.nvim/lua")] = true,
          [vim.fn.expand("~/.config/nvim/plugged/nvim-lspconfig/lua")] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
  }
)
