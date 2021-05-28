lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  ignore_install = { 'haskell', 'kotlin' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
}
EOF

