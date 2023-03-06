require('user.settings')
require('user.autocmd')
require('user.plugins')
require('user.keybinds')

require('user.plugins.lsp.lspconfig')
require('user.plugins.lsp.autocomplete')

require('user.plugins.treesitter')
require('user.plugins.neogen')
require('user.plugins.lspkind')
require('user.plugins.autopairs')
require('user.plugins.ts-autotag')
require('user.plugins.telescope')
require('user.plugins.lualine')
require('user.plugins.nvim-tree')
require('user.plugins.symbols-outline')

vim.cmd 'colorscheme onedark'

