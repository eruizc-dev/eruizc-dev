local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")
local lsputil = require("lsputil.codeAction")
local lsputil_codeAction = require("lsputil.codeAction")

local lsp = {}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local existing_capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  capabilities = require('cmp_nvim_lsp').update_capabilities(existing_capabilities),
})

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cssls.setup{
  root_dir = function(f)
    return lspconfig.util.root_pattern("package.json", ".git")(f) or vim.loop.cwd()
  end
}
lspconfig.dockerls.setup{}
--lspconfig.efm.setup(require('efm_setup').get_opts())
lspconfig.gopls.setup{}
lspconfig.html.setup{
  root_dir = function() return vim.loop.cwd() end
}
lspconfig.jsonls.setup{
  root_dir = function() return vim.loop.cwd() end
}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{
  on_attach = function(client, bufnr)
    -- 1. Run `solargraph config` if no `.solargraph.yml` in workspace dir
    -- 2. Run `bundle install` for installing dependencies
    -- 3. Run `solargraph download-core` for ruby documentaiton
    -- 4. Run `yard gems` to install gem documentation
    -- TODO: Run `solargraph config` if `.solargraph.yml` doesn't exist
    -- Maybe do this when detecting root, something like
    -- if not utils.root_pattern(".solargraph.yml") then
    --   -- Run with plenary maybe?
    --   run({
    --     cwd = utils.root_pattern("Gemfile", ".git") or vim.loop.cwd(),
    --     cmd = "solargraph config"
    --   })
    -- return utils.root_pattern(".solargraph.yml")(fname)
    -- end
  end
}
lspconfig.sumneko_lua.setup{
  cmd = { "lua-language-server" },
  root_dir = function(fname)
    local nvim_dir = lspconfig.util.root_pattern('lua')(fname)
    if nvim_dir then return nvim_dir..'/lua' end
    return lspconfig.util.root_pattern('rc.lua', 'init.lua', 'init.vim', '.git')(fname) or vim.loop.cwd()
  end,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      diagnostics = {
        enable = true,
        disable = { "unused-local" }, -- No hints for params i'm not using
        globals = {
          -- Neovim
          "vim",
          -- Awesome WS
          "awesome", "client", "root", "screen",
          -- Busted
          "describe", "it", "before_each", "after_each", "teardown", "pending", "clear"
        },
      },
      workspace = {
        library = utils.get_lua_runtime(),
        maxPreload = 1024,
        preloadFileSize = 1024,
      },
    },
  },
}
lspconfig.tsserver.setup{
  root_dir = function(f)
    return lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git')(f) or vim.loop.cwd()
  end
}
lspconfig.vimls.setup{}
lspconfig.vuels.setup{}
lspconfig.yamlls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
})

-- LSP UTIL
vim.lsp.handlers["textDocument/codeAction"] = lsputil.code_action_handler

return lsp
