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
require('user.plugins.telescope')
require('user.plugins.dashboard')

-- visual settings
local o = vim.o
local g = vim.g

-- general visual settigns
o.guifont = 'JetBrainsMono Nerd Font Mono:h12'

vim.cmd 'colorscheme onedarker'

-- Neovide settings 
if g.neovide then
    g.neovide_cursor_vfx_mode = 'pixiedust'
    g.neovide_cursor_vfx_particle_density = 11.0

    vim.api.nvim_set_keymap('n', '<F11>', ':let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', {})
end

