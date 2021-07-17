local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")
local lsputil = require("lsputil.codeAction")
local lsp_signature = require("lsp_signature")
local lsp = {}

local function attach_lsp_signature()
    lsp_signature.on_attach({
      fix_pos = true,
      hint_enable = false,
      handler_opts = { border = "single" },
      extra_trigger_chars = { "(", "{", ",", "\"", "'" }
    })
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = function(client)
    attach_lsp_signature()
  end
})

local checkstyle = {
  lintCommand = "java -jar /usr/local/lib/checkstyle/checkstyle-8.39-all.jar -c checkstyle.xml ${INPUT}",
  lintFormats = { "[ERROR] %f:%l:%c: %m" },
  lintIgnoreExitCode = true,
}

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cssls.setup{
  root_dir = function(f)
    return lspconfig.util.root_pattern("package.json", ".git")(f) or vim.fn.getcwd()
  end
}
lspconfig.dockerls.setup{}
lspconfig.efm.setup {
  filetypes = { "java" },
  on_attach = function(client)
    client.resolved_capabilities.rename = false
    client.resolved_capabilities.hover = false
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.completion = false
  end,
  root_dir = function() return vim.fn.getcwd() end,
  settings = {
    rootMarkers = { "checkstyle.xml" },
    languages = {
      java = { checkstyle },
    }
  }
}
lspconfig.gopls.setup{}
lspconfig.html.setup{
  root_dir = function() return vim.fn.getcwd() end
}
lspconfig.jsonls.setup{
  root_dir = function() return vim.fn.getcwd() end
}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.sumneko_lua.setup{
  cmd = { "lua-language-server" },
  root_dir = function(fname)
    local nvim_dir = lspconfig.util.root_pattern('lua')(fname)
    if nvim_dir then return nvim_dir..'/lua' end
    return lspconfig.util.root_pattern('rc.lua', 'init.lua', 'init.vim', '.git')(fname) or vim.fn.getcwd()
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      diagnostics = {
        enable = true,
        disable = { "trailing-space", },
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
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

lspconfig.jdtls.setup{}

vim.lsp.handlers["textDocument/codeAction"] = lsputil.code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
})

return lsp
