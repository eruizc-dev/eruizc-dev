local lspconfig = require("lspconfig")
local lsputil = require("lsputil.codeAction")

local lsp = {}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- local existing_capabilities = vim.lsp.protocol.make_client_capabilities()
-- 
-- lspconfig.util.default_config = vim.tbl_extend("force",
-- lspconfig.util.default_config, {
--   capabilities = require('cmp_nvim_lsp').update_capabilities(existing_capabilities),
-- })

lspconfig.bashls.setup{}
--lspconfig.clangd.setup{}
lspconfig.ccls.setup{}
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
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.tsserver.setup{
  cmd = { 'tsserver' },
  root_dir = function(f)
    return lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git')(f) or vim.loop.cwd()
  end
}
lspconfig.vimls.setup{}
lspconfig.vuels.setup{}
lspconfig.yamlls.setup{}
lspconfig.omnisharp.setup{
  cmd = { 'omnisharp' },
  enable_editorconfig_support = false,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = false,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
})

-- LSP UTIL
vim.lsp.handlers["textDocument/codeAction"] = lsputil.code_action_handler

return lsp
