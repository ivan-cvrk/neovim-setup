require('user.settings')
require('user.autocmd')
require('user.plugins')
require('user.keybinds')

require('user.plugins.lsp.lspconfig')
require('user.plugins.lsp.autocomplete')

require('user.plugins.treesitter')
require('user.plugins.autopairs')
require('user.plugins.lualine')
require('user.plugins.nvim-tree')

-- visual settings
local o = vim.o

o.guifont = "JetBrainsMono Nerd Font Mono:h12"

vim.cmd "colorscheme onedark"
