# Java with Neovim

![banner][banner]

**Java** is still a very popular language, chances of you having to use it are high.
It's also a complex language with tons of features which makes it impossible to
use without additional tooling.

In this quick guide I'll show you how you I set up my Neovim to work with Java

 - [Uninstall IntelliJ](#uninstall-intellij)
 - [Syntax Highlighting](#syntax-highlighting)
 - [Language Server Protoco (LSP)](#language-server-protocol-lsp)
    - [Installing the server](#installing-the-server)
    - [Configuring the client](#configuring-the-client)
    - [Debugging the client](#debugging-the-client)
 - [Code actions](#code-actions)
 - [Autocompletion](#autocompletion)
 - [Autoimport](#autoimport)
 - [Linting with Checkstyle](#linting-with-checkstyle)
 - [Testing](#testing)

## Uninstall IntelliJ

Yeah, you don't need it anymore... Here: <https://www.jetbrains.com/help/idea/uninstall.html#standalone>

## Syntax Highlighting

I use and recommend [Treesitter][treesitter-gh], follow the README as it's very
easy to install. Don't forget to install the **java** parser. An alternative is
[vim-polyglot][vim-polyglot-gh].

## Language Server Protocol (LSP)

Language server is what gives you all the nice smart language features. For this
to work 3 things are required:
 - A server to analzye the code: [Eclipse's JDT Language Server][jdtls-gh] in
   this case
 - A client that interacts with the server: Neovim 0.5 has this natively
 - A proper client configuration: [nvim-lspconfig][nvim-lspconfig-gh] to make
   things easier

### Installing the server

Installing the server can be tricky, so I made a script
[JDTLS Launcher][jdtls-launcher-gh] to make things easier. Just follow the
README to see how it can be installed. At the end you want the command `jdtls`
to work and print something like this (you can ignore the warnings):

```
$ jdtls
Listening for transport dt_socket at address: 1044
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by org.eclipse.osgi.internal.loader.ModuleClassLoader (file:/usr/local/lib/jdtls-launcher/jdtls/plugins/org.eclipse.osgi_3.16.400.v20210616-1525.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int)
WARNING: Please consider reporting this to the maintainers of org.eclipse.osgi.internal.loader.ModuleClassLoader
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release Content-Length: 126
{"jsonrpc":"2.0","method":"window/logMessage","params":{"type":3,"message":"Jun 21, 2021, 8:44:21 PM Main thread is waiting"}}
```

### Configuring the client

 1. Install the plugin [nvim-lspconfig][nvim-lspconfig-gh] as it provides some
    defaults and makes configuration easier
 2. Configure jdtls adding this to your init.vim:
 `lua require'lspconfig'.jdtls.setup{ cmd = { 'jdtls' } }`. Remove the `lua`
 keyword if have an init.lua instead.

### Debugging the client

Open any java file and wait a couple seconds as the server has to start (and
it's quite heavy). Run command `:LspInfo` to see if your server correctly
attached to active buffer. There were some issues in which you had to manually
attach the first time with `:LspStart jdtls`. You should be able to see warnings
and other stuff at this point. If you see this then your configuration is
working:

```
Configured servers: jdtls
Neovim logs at: /path/to/lsp.log

1 client(s) attached to this buffer: jdtls
  Client: jdtls (id 1)
  	root:      /path/to/project
  	filetypes: java
  	cmd:       jdtls

1 active client(s):
  Client: jdtls (id 1)
  	root:      /path/to/project
  	filetypes: java
  	cmd:       jdtls
  	
Clients that match the filetype java:
  Config: jdtls
  	cmd:               jdtls
  	cmd is executable: True
  	identified root:   /path/to/project
```

**CMD IS NOT EXECUTABLE:**

Either you didn't override default `cmd` or you didn't install the server
properly. If you installed JDTLS using [JDTLS Launcher][jdtls-launcher-gh] make
sure `jdtls` is the cmd (as previously shown) being executed.

If the cmd IS `jdtls` try runing that command directly on the console, if that
works then you're probably using different shells but if it doesn't go back to
[server installation][installing-the-server] and try reinstalling it.

If the cmd displayed IS NOT `jdtls` then go back to
[client configuration][configuring-the-client] step and make sure you set `cmd =
{ 'jdtls' }` and that you're not calling the `setup{}` function twice.

**ROOT NOT FOUND:**

All language servers require a project root. The current defaults for jdtls can
be found [here][jdtls-cfg], most likely they're looking for a gradle or maven
project or a git root. I suggest you override the `root_dir` configuration, like
this:

```vim
lua require'lspconfig'.jdtls.setup{
\   cmd = { 'jdtls' },
\   root_dir = function(fname)
\      return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
\   end
\}
```

## Autocompletion

Requires [Language Server](#language-server-protocol-lsp) to be working.

I personally use [nvim-compe][nvim-compe-gh] which is very straight forward
(following the README) but there are other alternatives like
[completion.nvim][completion-nvim-gh]

## Autoimport

Requires [Language Server](#language-server-protocol-lsp) to be working.

There are two ways I do auto importing:

 - On the spot: when autocompleting [nvim-compe][nvim-compe-gh] has this
   functionality and if you have configured it correctly the function call to
   `compe#confirm()` should perform the auto-import
 - With code actions: calling `:lua vim.lsp.buf.code_action()` will prompt you
   with a question on what to do! Organize imports and Import x is what you want

## Code navigation

 - Find and open files with a fuzzy finder!!!! [Telescope][telescope-gh] is by
   FAR my favorite but you can also use [fzf][fzf-vim-gh]or [ctrl-p][ctrlp-gh]
 - Get a quick view of functions in the file with
   [symbols-outline][symbols-outline-gh]. Requires
   [Language server](#language-server-protocol-lsp).

## Linting with checkstyle

Checkstyle is a decent tool for ensuring code-consistency. I'm not a big fan of
these type of tooling but sometimes you have to work in projects that do have
these. We will be using [EFM language server][efm-gh]

 1. Install [lspconfig][nvim-lspconfig-gh]
 2. Install efm like shown [here][efm-installation]
 3. Install [checkstyle][checkstyle-gh] with your favorite package manager or
    download it from the official [releases][checkstyle-releases]
 4. Configure EFM in neovim:
 ```vim
 lua lspconfig.efm.setup {
 \   filetypes = { "java" },
 \   on_attach = function(client)
 \       client.resolved_capabilities.rename = false
 \       client.resolved_capabilities.hover = false
 \       client.resolved_capabilities.document_formatting = false
 \       client.resolved_capabilities.completion = false
 \   end,
 \   root_dir = function() return vim.fn.getcwd() end,
 \   settings = {
 \       rootMarkers = { "checkstyle.xml" },
 \       languages = {
 \           java = {{
 \               lintCommand = "checkstyle -c checkstyle.xml ${INPUT}",
 \               lintFormats = { "[ERROR] %f:%l:%c: %m" },
 \               lintIgnoreExitCode = true,
 \           }}
 \       },
 \   }
 \}
 ```

> NOTE: If you installed checkstyle without a package manager your lintCommand
will be `"java -jar /path/to/checkstyle.jar -c checkstyle.xml ${INPUT}"`

## Testing

I've been practicing TDD lately, pretty cool indeed. But for that you need
proper testing tools: [vim-test][vim-test-gh]. Once you're in an active test
file you can use these 3 commands:
 - TestSuite: run ALL tests in project
 - TestFile: run ALL tests in file
 - TestNearest: run test above the cursor

**Common issues:**
 - TestNearest don't work well in nested classes, I'll try to fix later
 - Maven is the default, if you're working with Gradle read
   [this][vim-test-gradle]. PRO TIP: use `.exrc` files for project configuration


[banner]: ./resources/neovim-with-java.png
[checkstyle-gh]:https://github.com/checkstyle/checkstyle
[checkstyle-releases]: https://github.com/checkstyle/checkstyle/releases
[completion-nvim-gh]: https://github.com/nvim-lua/completion-nvim
[ctrlp-gh]: https://github.com/kien/ctrlp.vim
[efm-gh]: https://github.com/mattn/efm-langserver
[efm-installation]: https://github.com/mattn/efm-langserver#installation
[fzf-vim-gh]: https://github.com/junegunn/fzf.vim
[jdtls-cfg]: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#jdtls
[jdtls-gh]: https://github.com/eclipse/eclipse.jdt.ls
[jdtls-launcher-gh]: https://github.com/eruizc-dev/jdtls-launcher
[nvim-compe-gh]: https://github.com/hrsh7th/nvim-compe
[nvim-lspconfig-gh]: https://github.com/neovim/nvim-lspconfig
[symbols-outline-gh]: https://github.com/simrat39/symbols-outline.nvim
[telescope-gh]: https://github.com/nvim-telescope/telescope.nvim
[treesitter-gh]: https://github.com/nvim-treesitter/nvim-treesitter
[vim-polyglot-gh]: https://github.com/sheerun/vim-polyglot
[vim-test-gh]: https://github.com/vim-test/vim-test
[vim-test-gradle]: https://github.com/vim-test/vim-test#java
