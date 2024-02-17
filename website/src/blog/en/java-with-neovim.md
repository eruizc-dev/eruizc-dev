---
layout: blogpost.njk
title: Neovim as Java IDE
date: Last Modified
---

A **step by step guide to set up Neovim for Java development**, capable
of fully replacing IntelliJ. This is not a copy-paste solution but
rather a series of instructions that you can adapt to your existing configuration.

You can find the [minimal setup in this GitHub repository](https://github.com/eruizc-dev/minimal-java-nvim/),
I'll try to keep it up to date, but feel free to [open an issue](https://github.com/eruizc-dev/minimal-java-nvim/issues/new)
if I miss something.

 1. [Install the package manager](#install-the-package-manager)
 2. [Set up the Language Server](#setup-the-language-server)
     - [Add lombok support](#add-lombok-support)
 3. [Get code completion](#get-code-completion)
 4. [Run tests](#run-tests)
 5. [Run and debug code](#run-and-debug-code)
 6. [Run and debug tests](#debug-tests)

<h2 id="install-the-package-manager">1. Install the package manager</h2>

I highly recommend [Mason.nvim](https://github.com/williamboman/mason.nvim) to manage
third party dependencies such as Language Servers, linters, and other binaries. Follow the
[installation instructions](https://github.com/williamboman/mason.nvim?tab=readme-ov-file#installation)
and call the `setup()` function.

```lua
-- Plugin manager: add mason.nvim
{ 'williamboman/mason.nvim' }
```

```lua
-- init.lua
require'mason'.setup()
```

<h2 id="setup-the-language-server">2. Setup the Language Server</h2>

Start by installing [Eclipse's JDT Language Server](https://github.com/eclipse-jdtls/eclipse.jdt.ls)
with `:MasonInstall jdtls`, and install [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) plugin. 

```lua
-- Plugin manager: add nvim-jdtls
{ 'mfussenegger/nvim-jdtls' }
```

To set it up we need to call `start_or_attach` when a java file is open,
this can be achieved with an autocmd or a file `java.lua` inside `ftplugin/`
directory. We need to populate the cmd property with the jdtls executable.
If you've installed it using Mason, an executable file should be located in
`$HOME/.local/share/nvim/mason/bin/jdtls`.

```lua
-- ftplugin/java.lua: call start_or_attach when a java file is loaded
require'jdtls'.start_or_attach({
    cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
    }
})
```

You should be able to open any java file or project and see the Language
Server loading, it may take a while but you should be able to see information
about unused variables and syntax errors. There are also new commands available
inside a java file, you can type `:Jdt` and autocomplete the options.

**Note**: Python3 and Java 17+ is required for jdtls to work. If you run
into any issues try executing the binary directly from the command line
(I already told you the path). You can also call `:JdtShowLogs` to get
information from nvim-jdtls.

<h3 id="add-lombok-support">2b. Add Lombok Support</h3>

Add the javaagent to JDTLS with the flag `-javaagent` pointing to the location
of `lombok.jar`. If you used Mason.nvim, it already came with your JDTLS
instalation. Update nvim-jdtls configuration to look like this:

```diff-lua
 -- ftplugin/java.lua: add arguments to jdtls script
 require'jdtls'.start_or_attach({
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
+        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
     }
 })
```

<h2 id="get-code-completion">3. Get code completion</h2>

The most popular completion plugin is [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
which has a couple dependencies, make sure to install them all including the source
for LSP completion.

```lua
-- Plugin manager: install nvim-cmp, LuaSnip, cmp_luasnip, and cmp-nvim-lsp
{
    'hrsh7th/nvim-cmp',
    version = false, -- Ignore tags because nvim-cmp has a very old tag
    dependencies = {
        'L3MON4D3/LuaSnip', -- Snippet engine
        'saadparwaiz1/cmp_luasnip', -- Snippet engine adapter
        'hrsh7th/cmp-nvim-lsp', -- Source for LSP completion
    },
}
```

```diff-lua
 -- Plugin manager: add cmp-nvim-lsp as dependency to nvim-jdtls
 {
     'mfussenegger/nvim-jdtls',
+    dependencies = 'hrsh7th/cmp-nvim-lsp',
 },
```

Next step is to set up nvim-cmp by calling `setup()` to configure the snippet engine,
essential mappings, and the LSP completion source.

```lua
-- init.lua: setup nvim-cmp
require'cmp'.setup({
    snippet = {
        -- Exclusive to LuaSnip, check nvim-cmp documentation for usage with a different snippet engine
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = {
        -- Sample but necessary mappings, read nvim-cmp documentation to customize them
        ['<C-c>'] = require'cmp'.mapping.abort(),
        ['<CR>'] = require'cmp'.mapping.confirm(),
        ['<C-n>'] = require'cmp'.mapping.select_next_item(),
        ['<C-p>'] = require'cmp'.mapping.select_prev_item(),
    },
    sources = {
        { name = 'nvim_lsp' },
    },
})
```

Finally, connect nvim-jdtls with nvim-cmp by adding completion capabilities.

```diff-lua
 -- ftplugin/java.lua
 require'jdtls'.start_or_attach{
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
         ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
     },
+    capabilities = require'cmp_nvim_lsp'.default_capabilities()
 }
```

You should have completion working, open a java file and start typing. You can
cycle through the results with `<C-n>` and `<C-P>`, and select them with `<CR>`.

<h2 id="run-tests">4. Run tests</h2>

[Neotest](https://github.com/nvim-neotest/neotest) provides a great interface for
running tests, for it to work you need to install it alongside its dependencies
including [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

```lua
-- Plugin manager: install neotest with its necessary dependencies
{
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'rcasia/neotest-java',
    },
}
```

```lua
-- init.lua: setup neotest
require'neotest'.setup({
    adapters = {
        require'neotest-java',
    },
})
```

After installing neotest and its dependencies you are going to need the java
parser, install it by calling `:TSInstall java` (note: a C compiler is
required to build the parser, you can use GCC or CLANG).

You should be able to invoke the following commands to view and run tests.
If you run into any trouble you can check neotest logs in `~/.local/state/nvim/neotest.log`

```lua
require('neotest').output_panel.toggle()        -- Opens/closes test pannel
require('neotest').summary.toggle()             -- Toggle summary

require('neotest').run.run()                    -- Test nearest
require('neotest').run.run(vim.fn.expand('%'))  -- Test file
require('neotest').run.run(vim.loop.cwd())      -- Test project
require('neotest').run.stop()                   -- Stop testing
```

<h2 id="run-and-debug-code">5. Run and debug code</h2>

To run and debug code you need a combination of
[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls),
[nvim-dap](https://github.com/mfussenegger/nvim-dap),
and [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui). We also
need to install [java-debug](https://github.com/microsoft/java-debug).

Install the necessary plugins, you should already have nvim-jdtls from
[step 2](#setup-the-language-server) so you only need to add nvim-dap
and its ui. There's no need to call `setup()` here.

```lua
-- Plugin manager: add nvim-dap-ui and nvim-dap
{
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
},
```

Install the debug server with `:MasonInstall java-debug-adapter`, and
bundle the jar together with nvim-djtls by adding it to the `bundles`
property. This property takes a list of paths to jar files.

```diff-lua
 require'jdtls'.start_or_attach({
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
         ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
     },
     capabilities = require'cmp_nvim_lsp'.default_capabilities(),
+    bundles = { vim.fn.expand'$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' },
 })
```

You should be able to open any java project, run `:JdtUpdateDebugConfigs`,
and access the following commands:

```lua
require'dap'.toggle_breakpoint()    -- Set or unset breakpoint
require'dap'.continue()             -- Start debuging or continue to next breakpoint
require'dap'.step_over()            -- Step over
require'dap'.step_into()            -- Step into
require'dap'.repl.open()            -- Open repl
require'dap'.restart()              -- Restart debugging session
require'dap'.close()                -- Close debugging session

require'dapui'.eval()               -- See runtime values of the variables under cursor
require'dapui'.toggle()             -- Open or close debugging UI
```

<h2 id="debug-tests">6. Debug tests</h2>

While we wait for [neotest to support debugging](https://github.com/rcasia/neotest-java/issues/59)
we can rely on [nvim-dap](https://github.com/mfussenegger/nvim-dap) to debug tests.

A working [language server](#setup-the-language-server) and [debug adapter](#run-and-debug-code)
are required. start by installing [java-test](https://github.com/microsoft/vscode-java-test)
with mason  `:MasonInstall java-test`, and update your jdtls configuration to include
a list of all jars from both java-debug and java-test. Because Mason installs
them in similar paths you can use `vim.fn.glob` function to get a newline separated
string containing all required jars that you can convert into a list usin `vim.split`.
we can use `vim.fn.glob` to get a newline separated string containing al jars,

 ```diff-lua
 require'jdtls'.start_or_attach({
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
         ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
     },
     capabilities = require'cmp_nvim_lsp'.default_capabilities(),
-    bundles = { vim.fn.expand'$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' },
+    bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', 1), '\n'),
 })
```

You should have access to two new functions that whill allow you to debug tests,
together with the [previously mentioned](#run-and-debug-code) commands you should
be able to set breakpoints and debug normally.

```lua
require'jdtls'.test_class()             -- Run all tests in class
require'jdtls'.test_nearest_method()    -- Run test closest to cursor
```

# That's it!

Hope this helped you set up your environment. I've made this guide to celebrate
my javaniversary as today (February 17, 2024) is my third year developing Java
on a daily basis, and I've been using Neovim for Java development since
aproximately that much minus 2 months that took me to figure out how to set it up.

Additional resources:
 - [Minimal example repository](https://github.com/eruizc-dev/minimal-java-nvim)

Plugins used:
 - [Lazy.nvim](https://github.com/folke/lazy.nvim): Plugin manager
 - [Mason.nvim](https://github.com/williamboman/mason.nvim): Package manager
 - [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls): Language Server Client
 - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Completion engine, depends on:
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): Extension to nvim-cmp to provide LSP completion
    - [LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine necessary for nvim-cmp
 - [neotest](https://github.com/nvim-neotest/neotest): Test runner with user interface, depends on:
    - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): General utilities for neovim development
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Syntax tree parser
    - [neotest-java](https://github.com/rcasia/neotest-java): Neotest adapter for Java tests
    - [antoinemadec/FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim): Decouple updatetime from CursorHold and CursorHoldI
 - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): Interface for debugging, depends on:
    - [nvim-dap](https://github.com/mfussenegger/nvim-dap): Debug Adapter Client

Packages used:
 - [Eclipse's JDT Language Sever](https://github.com/eclipse-jdtls/eclipse.jdt.ls): Language Server for Java, based on the JDT toolkit
 - [Java Debug](https://github.com/microsoft/java-debug): Java Debug Server
 - [Java Test](https://github.com/microsoft/vscode-java-test): Test runner for Java
 - [Lombok](https://projectlombok.org/): Adds Lombok suport to your language server

Have any feedback? Contact me!:
 - [Twitter](https://twitter.com/eruizc_dev)
