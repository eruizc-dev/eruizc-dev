local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")
local lsputil = require("lsputil.codeAction")
local lsp_signature = require("lsp_signature")
local jdtls = require("jdtls")
local jdtls_ui = require'jdtls.ui'
local jdtls_setup = require("jdtls.setup")
local lsputil_codeAction = require("lsputil.codeAction")

local lsp = {}

local function attach_lsp_signature()
    lsp_signature.on_attach({
      fix_pos = true,
      hint_enable = false,
      handler_opts = { border = "single" },
      extra_trigger_chars = { "(", "{", ",", "\"", "'" }
    })
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local existing_capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  capabilities =require('cmp_nvim_lsp').update_capabilities(existing_capabilities),
  on_attach = function(client)
    attach_lsp_signature()
  end
})

local checkstyle = {
  lintCommand = "java -jar "
    .. vim.fn.expand("/usr/local/lib/checkstyle/checkstyle-*.jar")
    .. " -c checkstyle.xml ${INPUT}",
  lintFormats = { "[ERROR] %f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  lintSeverity = 2,
}

local stylua = {
  lintCommand = "stylua --check --color never -",
  lintFormats = {
    "    %l |+%m",
    "    %l  |+%m",
    "    %l   |+%m",
    "    %l    |+%m",
  },
  lintStdin = true,
  formatCommand = "stylua -",
  formatStdin = true,
  lintIgnoreExitCode = true,
  lintSeverity = 3,
}

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cssls.setup{
  root_dir = function(f)
    return lspconfig.util.root_pattern("package.json", ".git")(f) or vim.loop.cwd()
  end
}
lspconfig.dockerls.setup{}
lspconfig.efm.setup {
  filetypes = { "java", "lua" },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.rename = false
    client.resolved_capabilities.hover = false
    client.resolved_capabilities.goto_definition = false
    client.resolved_capabilities.completion = false
  end,
  root_dir = function(fname)
    if fname:match(".java") then
      return lspconfig.util.root_pattern("checkstyle.xml")(fname)
    end
    if fname:match(".lua") then
      return lspconfig.util.root_pattern(".stylua.toml")(fname)
    end
    return nil
  end,
  settings = {
    rootMarkers = { "checkstyle.xml", ".stylua.toml", ".git" },
    languages = {
      java = { checkstyle },
      lua = { stylua },
    }
  }
}
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
    --
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
    attach_lsp_signature()
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
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.vuels.setup{}
lspconfig.yamlls.setup{}

function lsp.get_jdtls_config()
  local bundles = {
    vim.fn.glob("$HOME/repos/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  }
  vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/repos/microsoft/vscode-java-test/server/*.jar"), "\n"))

  return {
    cmd = { 'jdtls' },
    root_dir = jdtls_setup.find_root({ '*.gradle', 'pom.xml' }),
    init_options = {
      bundles = bundles
    },
    settings = {
      java = {
        implementationsCodeLens = {
          enabled = true
        },
        completion = {
          importOrder = {}
        }
      }
    },
    on_attach = function(client)
      attach_lsp_signature()
      jdtls_setup.add_commands()
      jdtls.setup_dap({ hotcodereplace = 'auto' })
      jdtls.update_project_config()
    end
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
})

-- LSP UTIL
vim.lsp.handlers["textDocument/codeAction"] = lsputil.code_action_handler

function jdtls_ui.pick_one_async(items, prompt, label_fn, cb)
  lsputil_codeAction.code_action_handler(nil, items, nil, nil, cb)
end

return lsp
