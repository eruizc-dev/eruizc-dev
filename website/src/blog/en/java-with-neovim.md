---
layout: blogpost.njk
title: Neovim as Java IDE
date: Last Modified
---

In this guide you will learn how to set up Neovim for Java development, capable
of fully replacing IntelliJ. Keep in mind that this is **not a copy-paste solution**,
but rather a step by step instruction that you should **adapt to your own configuration**.
I'll try to keep this repository up to date, but feel free to [open an issue](https://github.com/eruizc-dev/minimal-java-nvim/issues/new)
if you find something that is outdated or not working.

 1. [Install the package manager](#1.-install-the-package-manager) (not to be confused with plugin manager)
 2. [Set up the Language Server](#2.-setup-the-language-server)
     - [Add lombok support](#add-lombok-support)
 3. [Get code completion](#3.-get-code-completion)
 4. [Run tests](#4.-run-tests)
 5. [Run and debug code](#5.-run-and-debug-code)
 6. [Run and debug tests](#6.-debug-tests)

### 1. Install the package manager

[Mason.nvim](https://github.com/williamboman/mason.nvim) is a package manager
that will allow us to install the necessary binaries, just follow the
[installation instructions](https://github.com/williamboman/mason.nvim?tab=readme-ov-file#installation)
and call the `setup()` function.

```lua
-- Lazy.nvim configuration
{ 'williamboman/mason.nvim' }
```

```lua
-- init.lua
require'mason'.setup()
```

To ensure it is working you can invoke `:Mason` and see a window pop up.
There's also `:MasonLog` if you run into any issues.

### 2. Setup the Language Server

This step used to be complicated but it has become very simple, the problem is
that old and outdated documentation still exists and can cause confusion for
newcomers.

Start by invoking `:MasonInstall jdtls`, this will install the binaries for
[Eclipse's JDT Language Server](https://github.com/eclipse-jdtls/eclipse.jdt.ls).


Next up install the client by installing [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
plugin. 

```lua
-- Plugin manager
{ 'mfussenegger/nvim-jdtls' }
```

To set it up we need to call `start_or_attach` function whenever we open a java
file, this can be achieved with an autocmd or (my favorite) a file `java.lua`
inside `ftplugin/` directory. This function takes a table with the **cmd**
property to tell it how to start the language server. If you've installed it
using Mason, an executable file should be located in `$HOME/.local/share/nvim/mason/bin/jdtls`.

```lua
-- ftplugin/java.lua
require'jdtls'.start_or_attach({
    cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
    }
})
```

At this point you should be able to open any java file or project, and get
information about unused variables and syntax errors. The Language Server
may take a while to load, specially the first time as it needs to download
and set up your project dependencies.

You will also have a couple new commands available to you when inside a java
file, you can see them by typing `:Jdt` and cyclying through the results with
`<tab>`. They're self explanatory so I won't get into them.

 > Python3 and Java 17+ is required for jdtls to work. If you run
 into any issues try executing the binary directly from the command line
 (I already told you the path). You can also call `:JdtShowLogs` to get
 information from nvim-jdtls.

#### Add Lombok Support

If your projects use Lombok you need to add it as a javaagent to JDTLS,
that is done by adding `-javaagent` flag pointing to the location of
`lombok.jar`. If you used Mason.nvim, it already came with your JDTLS
instalation. Update nvim-jdtls configuration to look like this:

```patch
 -- ftplugin/java.lua
 require'jdtls'.start_or_attach({
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
+        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
     }
 })
```

### 3. Get code completion

We will be using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for completion
which depends on a snippet engine, I've chosen [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
but you can check its documentation if you want to use a different one. We will also
need [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) which provides a source
for LSP completion.

We will start by installing all the necessary plugins and its dependencies:

```lua
-- Plugin manager
{
    'hrsh7th/nvim-cmp',
    version = false, -- If your plugin manager prefers tags over latest, disable that because nvim-cmp has a very old tag
    dependencies = {
        'L3MON4D3/LuaSnip', -- Snippet engine
        'saadparwaiz1/cmp_luasnip', -- Its adapter
        'hrsh7th/cmp-nvim-lsp', -- Source for LSP completion
    },
}
```

```patch
 -- Plugin manager, we add a cmp-nvim-lsp as a dependency to nvim-jdtls
 {
     'mfussenegger/nvim-jdtls',
+    dependencies = 'hrsh7th/cmp-nvim-lsp',
 },
```

Next we can set up nvim-cmp by calling `setup()` with the required options.

```lua
-- init.lua
require'cmp'.setup({
    snippet = {
        -- This is exclusive to LuaSnip, check nvim-cmp documentation for different snippet engines
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

And finally we connect nvim-jdtls with nvim-cmp by adding completion
capabilities.

```patch
 -- ftplugin/java.lua
 require'jdtls'.start_or_attach{
     cmd = {
         vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
         ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
     },
+    capabilities = require'cmp_nvim_lsp'.default_capabilities()
 }
```

At this point you should have completion, open a java file and start typing.
You can cycle through the results with `<C-n>` and `<C-P>`, and select them with
`<CR>`.

### 4. Run tests

[Neotest](https://github.com/nvim-neotest/neotest) provides a great interface for running tests,
for it to work you need to install it alongside 

```lua
-- Lazy.nvim configuration
{
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'rcasia/neotest-java',
    }
}
```

```lua
-- init.lua
require'neotest'.setup({
    adapters = {
        require'neotest-java',
    },
})
```

Next up we need to install the Treesitter parser for java, this way neotest can
understand your test files. Run `:TSInstall java`.

> Treesitter may require a C compiler like GCC or CLang to compile the java parser

Just as that we have the following commands available:

```lua
require('neotest').output_panel.toggle()        -- Opens/closes test pannel
require('neotest').summary.toggle()             -- Toggle summary

require('neotest').run.run()                    -- Test nearest
require('neotest').run.run(vim.fn.expand('%'))  -- Test file
require('neotest').run.run(vim.loop.cwd())      -- Test project
require('neotest').run.stop()                   -- Stop testing
```

If you run into any trouble you can check neotest logs in `~/.local/state/nvim/neotest.log`

### 5. Run and debug code

For running our project and debugging we will be using a combination of
[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls),
[nvim-dap](https://github.com/mfussenegger/nvim-dap),
and [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui). We also
need to install [java-debug](https://github.com/microsoft/java-debug).

To get started we will add the necessary plugins, we already have nvim-jdtls
from [step 2](#2.-setup-the-language-server) so we only need nvim-dap and its ui.
No need to call `setup()` here.

```lua
-- Lazy.nvim configuration
{
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
},
```

Now we invoke `:MasonInstall java-debug-adapter` to download the debug server,
and we bundle the jar together with nvim-jdtls adding it to the `bundles` property.
This property takes a list of paths to jar files.

```patch
require'jdtls'.start_or_attach({
    cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
    },
    capabilities = require'cmp_nvim_lsp'.default_capabilities(),
+   bundles = { vim.fn.expand'$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' },
})
```

For debugging we will be using a combination of nvim-dap and nvim-jdtls

 1. Run `:MasonInstall java-debug-adapter`
 2. Add the bundles to jdlts
 3. Install dap
 4. Call `:JdtUpdateDebugConfigs` on your project once the language server has loaded
 5. New commands available

```vim
"""DEBUG COMMANDS"""
command! DebugToggleBreakpoint lua require'dap'.toggle_breakpoint()
command! DebugContinue lua require'dap'.continue()
command! DebugStepOver lua require'dap'.step_over()
command! DebugStepInto lua require'dap'.step_into()
command! DebugInspect lua require'dap'.repl.open()
command! DebugRestart lua require'dap'.restart()
command! DebugClose lua require'dap'.close()
command! DebugEval lua require'dapui'.eval()
command! DebugToggle lua require'dapui'.toggle()
```



### 6. Debug tests

Sadly we are still [waiting for neotest to support dap](https://github.com/rcasia/neotest-java/issues/59),
but in the meanwhile we can use nvim-dap to run and debug our tests.

Steps [2](#2.-setup-the-language-server) and [5](#5.-run-and-debug-code)
are required, now we need the jars for [java-test](https://github.com/microsoft/vscode-java-test)
which can be obtained with `:MasonInstall java-test`.

Now update your bundles to include the new jars, we will be using a little trick
with pattern matching thanks to both java-test and java-debug having very similar
paths. We will use `vim.fn.glob` to get a string containing all jar files, and
split them into a list with `vim.split` as the previous function returns a newline
separated string.

```patch
require'jdtls'.start_or_attach({
    cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
    },
    capabilities = require'cmp_nvim_lsp'.default_capabilities(),
-   bundles = { vim.fn.expand'$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' },
+   bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', 1), '\n'),
})
```

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
 - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): Interface for debugging, depends on:
    - [nvim-dap](https://github.com/mfussenegger/nvim-dap): Debug Adapter Client

Packages used:
 - [Eclipse's JDT Language Sever](https://github.com/eclipse-jdtls/eclipse.jdt.ls): Language Server for Java, based on the JDT toolkit
 - [Java Debug](https://github.com/microsoft/java-debug): Java Debug Server
 - [Java Test](https://github.com/microsoft/vscode-java-test): Test runner for Java
 - [Lombok](https://projectlombok.org/)(optional): Adds Lombok suport to your language server
